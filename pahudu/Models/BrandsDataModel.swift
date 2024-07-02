//
//  DataModelBrands.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/20/24.
//

import SwiftUI

struct BrandResponse: Codable {
    let version: String
    var brands: [Brand]
}

struct Brand: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let founder: String
    let foundedDate: String
    let about: String
    let headquarters: String
    let yearsActive: String
    let parentCompany: String
    let website: String
    let nationality: String
    let imageName: String
    let history: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, founder, foundedDate, about, headquarters, yearsActive, parentCompany, website, nationality, imageName, history
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        founder = try container.decodeIfPresent(String.self, forKey: .founder) ?? "N/A"
        foundedDate = try container.decodeIfPresent(String.self, forKey: .foundedDate) ?? "N/A"
        about = try container.decodeIfPresent(String.self, forKey: .about) ?? "N/A"
        headquarters = try container.decodeIfPresent(String.self, forKey: .headquarters) ?? "N/A"
        yearsActive = try container.decodeIfPresent(String.self, forKey: .yearsActive) ?? "N/A"
        parentCompany = try container.decodeIfPresent(String.self, forKey: .parentCompany) ?? "N/A"
        website = try container.decodeIfPresent(String.self, forKey: .website) ?? "N/A"
        nationality = try container.decodeIfPresent(String.self, forKey: .nationality) ?? "N/A"
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName) ?? "default_image"
        history = try container.decodeIfPresent(Array.self, forKey: .history) ?? []
    }
}


@MainActor
func fetchBrands() async -> [Brand] {
    let url = URL(string: "https://api.pahudu.com/v1/brands")!
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        var response = try JSONDecoder().decode(BrandResponse.self, from: data)
        response.brands.sort { $0.name.lowercased() < $1.name.lowercased() }
        return response.brands
    } catch {
        print("Error fetching data: \(error)")
        return []
    }
}

extension Brand: Equatable {
    static func == (lhs: Brand, rhs: Brand) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Array where Element == Brand {
    func findBrand(byName name: String) -> Brand? {
        return self.first { $0.name.lowercased().contains(name.lowercased()) }
    }
}
