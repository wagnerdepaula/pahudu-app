//
//  ImageCache.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/21/24.
//

import SwiftUI
import Combine

actor ImageCache {
    static let shared = ImageCache()
    private var cache = [URL: UIImage]()
    private var lruList = [URL]()
    private let maxCacheSize = 100

    func image(for url: URL) -> UIImage? {
        if let image = cache[url] {
            updateLRU(url)
            return image
        }
        return nil
    }

    func insertImage(_ image: UIImage, for url: URL) {
        cache[url] = image
        updateLRU(url)
        if lruList.count > maxCacheSize {
            if let oldestURL = lruList.first {
                cache.removeValue(forKey: oldestURL)
                lruList.removeFirst()
            }
        }
    }

    private func updateLRU(_ url: URL) {
        if let index = lruList.firstIndex(of: url) {
            lruList.remove(at: index)
        }
        lruList.append(url)
    }
}

@MainActor
struct AsyncCachedImage<ImageView: View, PlaceholderView: View>: View {
    var url: URL?
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView

    @State private var image: UIImage?
    @State private var cancellable: AnyCancellable?

    private let imageCache = ImageCache.shared
    private let imageDownloader = ImageDownloader.shared

    init(
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> ImageView,
        @ViewBuilder placeholder: @escaping () -> PlaceholderView
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
            }
        }
        .onAppear(perform: loadImage)
        .onDisappear(perform: cancelDownload)
        .onChange(of: url) { _ , _ in
            cancelDownload()
            loadImage()
        }
    }

    private func loadImage() {
        guard let url = url else { return }

        Task {
            if let cachedImage = await imageCache.image(for: url) {
                self.image = cachedImage
                return
            }

            await downloadImage(from: url)
        }
    }

    private func downloadImage(from url: URL) async {
        do {
            let image = try await imageDownloader.downloadImage(from: url)
            await imageCache.insertImage(image, for: url)
            self.image = image
        } catch {
            print("Error downloading image: \(error)")
        }
    }

    private func cancelDownload() {
        cancellable?.cancel()
    }
}

class ImageDownloader {
    static let shared = ImageDownloader()

    private let session: URLSession
    private let processingQueue: OperationQueue

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        self.session = URLSession(configuration: configuration)

        self.processingQueue = OperationQueue()
        processingQueue.maxConcurrentOperationCount = 4
        processingQueue.qualityOfService = .userInitiated
    }

    func downloadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await session.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        return await resizeImage(image, to: CGSize(width: 200, height: 200))
    }

    private func resizeImage(_ image: UIImage, to size: CGSize) async -> UIImage {
        await withCheckedContinuation { continuation in
            processingQueue.addOperation {
                let renderer = UIGraphicsImageRenderer(size: size)
                let resizedImage = renderer.image { _ in
                    image.draw(in: CGRect(origin: .zero, size: size))
                }
                continuation.resume(returning: resizedImage)
            }
        }
    }
}
