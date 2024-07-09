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

struct CreativeDirector: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let yearStarted: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, yearStarted
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? "unknown"
        name = try container.decode(String.self, forKey: .name)
        yearStarted = try container.decode(String.self, forKey: .yearStarted)
    }
}

struct Brand: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let founders: [String]
    let creativeDirectors: [CreativeDirector]
    let foundedYear: String
    let about: String
    let headquarters: String
    let yearsActive: String
    let parentCompany: String
    let website: String
    let nationality: String
    let imageName: String
    let history: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, founders, creativeDirectors, foundedYear, about, headquarters, yearsActive, parentCompany, website, nationality, imageName, history
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        founders = try container.decodeIfPresent([String].self, forKey: .founders) ?? ["N/A"]
        creativeDirectors = try container.decodeIfPresent([CreativeDirector].self, forKey: .creativeDirectors) ?? []
        foundedYear = try container.decodeIfPresent(String.self, forKey: .foundedYear) ?? "N/A"
        about = try container.decodeIfPresent(String.self, forKey: .about) ?? "N/A"
        headquarters = try container.decodeIfPresent(String.self, forKey: .headquarters) ?? "N/A"
        yearsActive = try container.decodeIfPresent(String.self, forKey: .yearsActive) ?? "N/A"
        parentCompany = try container.decodeIfPresent(String.self, forKey: .parentCompany) ?? "N/A"
        website = try container.decodeIfPresent(String.self, forKey: .website) ?? "N/A"
        nationality = try container.decodeIfPresent(String.self, forKey: .nationality) ?? "N/A"
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName) ?? "default_image"
        history = try container.decodeIfPresent([String].self, forKey: .history) ?? []
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
        return self.first { brand in
            brand.name.lowercased() == name.lowercased()
        }
    }
}
