//
//  ImageCache.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/21/24.
//

import SwiftUI
import Combine


class AsyncImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    
    func loadImage(from url: URL, cacheKey: String) {
        if let cachedImage = ImageCache.shared.getImage(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { data, response in
                UIImage(data: data)?.resized(toWidth: 300) // Resize image for better performance
            }
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .sink { [weak self] image in
                guard let self = self, let image = image else { return }
                ImageCache.shared.setImage(image, forKey: cacheKey)
                self.image = image
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}

struct AsyncImageView: View {
    @StateObject private var loader: AsyncImageLoader
    private let placeholder: Color
    private let url: URL
    
    init(url: URL, placeholder: Color = Colors.Secondary.background) {
        _loader = StateObject(wrappedValue: AsyncImageLoader())
        self.placeholder = placeholder
        self.url = url
    }
    
    var body: some View {
        image
            .onAppear {
                loader.loadImage(from: url, cacheKey: url.absoluteString)
            }
    }
    
    private var image: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .transition(.identity)
            } else {
                placeholder
            }
        }
    }
}


class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}


extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: canvasSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
