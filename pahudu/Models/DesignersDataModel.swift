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

struct Affiliation: Codable, Hashable {
    let brand: String
    let position: String
    let since: String
}

struct Designer: Codable, Identifiable, Hashable {
    
    let id: String
    let education: String
    let nationality: String
    let founder: String
    let name: String
    let about: String
    let dateOfBirth: String
    let placeOfBirth: String
    let yearsActive: String
    let spouse: String
    let website: String
    let title: String
    let imageName: String
    let history: [String]
    let affiliation: Affiliation?
    
    enum CodingKeys: String, CodingKey {
        case id, education, nationality, founder, name, title, about, dateOfBirth, placeOfBirth, yearsActive, spouse, website, imageName, history, affiliation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        education = try container.decodeIfPresent(String.self, forKey: .education) ?? "N/A"
        nationality = try container.decodeIfPresent(String.self, forKey: .nationality) ?? "N/A"
        founder = try container.decodeIfPresent(String.self, forKey: .founder) ?? "N/A"
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "N/A"
        about = try container.decodeIfPresent(String.self, forKey: .about) ?? "N/A"
        dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth) ?? "N/A"
        placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth) ?? "N/A"
        yearsActive = try container.decodeIfPresent(String.self, forKey: .yearsActive) ?? "N/A"
        spouse = try container.decodeIfPresent(String.self, forKey: .spouse) ?? "N/A"
        website = try container.decodeIfPresent(String.self, forKey: .website) ?? "N/A"
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName) ?? "default_image"
        history = try container.decodeIfPresent(Array.self, forKey: .history) ?? []
        affiliation = try container.decodeIfPresent(Affiliation.self, forKey: .affiliation)
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


extension Designer: Equatable {
    static func == (lhs: Designer, rhs: Designer) -> Bool {
        return lhs.id == rhs.id
    }
}
