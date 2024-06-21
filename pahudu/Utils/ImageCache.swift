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
    private let cache = NSCache<NSURL, UIImage>()
    
    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }
    
    func insertImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
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
        .onChange(of: url) { _ in
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
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data) else { return }
            
            let resizedImage = await resizeImage(uiImage, to: CGSize(width: 300, height: 300))
            await imageCache.insertImage(resizedImage, for: url)
            
            self.image = resizedImage
        } catch {
            print("Error downloading image: \(error)")
        }
    }
    
    private func resizeImage(_ image: UIImage, to size: CGSize) async -> UIImage {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                let renderer = UIGraphicsImageRenderer(size: size)
                let resizedImage = renderer.image { _ in
                    image.draw(in: CGRect(origin: .zero, size: size))
                }
                continuation.resume(returning: resizedImage)
            }
        }
    }
    
    private func cancelDownload() {
        cancellable?.cancel()
    }
}
