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
        if let designers = try? await fetchDesigners() {
            designersWithImageURLs = designers.map { DesignerWithImageURL(id: $0.id, designer: $0, imageURL: URL(string: "https://storage.googleapis.com/pahudu.com/designers/sm/\($0.name).png")!) }
        } else {
            // Handle error or set designersWithImageURLs to empty array
        }
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
