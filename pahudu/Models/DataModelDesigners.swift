//
//  DataModelDesigners.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/18/24.
//

import SwiftUI
import Combine


struct DesignerResponse: Codable {
    let version: String
    var designers: [Designer]
}

struct Designer: Codable, Identifiable {
    let id: String
    let education: String
    let nationality: String
    let founder: String
    let name: String
    let title: String
    let about: String
    let dateOfBirth: String
    let yearsActive: String
    let spouse: String
    let website: String
}

struct DesignerWithImageURL: Identifiable {
    let id: String
    let designer: Designer
    let imageURL: URL
}

class DesignerViewModel: ObservableObject {
    @Published var designersWithImageURLs: [DesignerWithImageURL] = []

    init() {
        Task {
            await fetchAndPopulateDesigners()
        }
    }
    
    private func fetchAndPopulateDesigners() async {
        let designers = await fetchDesigners()
    }
    
}

@MainActor
func fetchDesigners() async -> [Designer] {
    let url = URL(string: "https://api.pahudu.com/v1/designers")!
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        var response = try JSONDecoder().decode(DesignerResponse.self, from: data)
        response.designers.sort { $0.name.lowercased() < $1.name.lowercased() }
        return response.designers
    } catch {
        print("Error fetching data: \(error)")
        return []
    }
}


extension DesignerViewModel {
    func preloadImages(for url: URL) {
        guard let index = designersWithImageURLs.firstIndex(where: { $0.imageURL == url }) else { return }
        
        // Preload next images
        let preloadCount = 2
        let startIndex = max(0, index - preloadCount)
        let endIndex = min(designersWithImageURLs.count - 1, index + preloadCount)
        
        for i in startIndex...endIndex {
            let preloadUrl = designersWithImageURLs[i].imageURL
            AsyncImageLoader().loadImage(from: preloadUrl, cacheKey: preloadUrl.absoluteString)
        }
    }
}
