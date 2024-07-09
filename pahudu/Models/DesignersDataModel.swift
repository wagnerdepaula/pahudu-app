//
//  DataModelDesigners.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/18/24.
//
import SwiftUI
import Combine

struct DesignerResponse: Codable {
    var designers: [Designer]
}

struct Affiliation: Codable, Identifiable, Hashable {
    var id: String
    let position: String
    let brand: String
    let since: String
    let until: String
}

struct Designer: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let dateOfBirth: String
    let placeOfBirth: String
    let education: String
    let spouse: String
    let nationality: String
    let founder: String
    let about: String
    let yearsActive: String
    let website: String
    let imageName: String
    let history: [String]
    let affiliations: [Affiliation]
    
    enum CodingKeys: String, CodingKey {
        case id, name, dateOfBirth, placeOfBirth, education, spouse, nationality, founder, about, yearsActive, website, imageName, history, affiliations
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth) ?? "N/A"
        placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth) ?? "N/A"
        education = try container.decodeIfPresent(String.self, forKey: .education) ?? "N/A"
        spouse = try container.decodeIfPresent(String.self, forKey: .spouse) ?? "N/A"
        nationality = try container.decodeIfPresent(String.self, forKey: .nationality) ?? "N/A"
        founder = try container.decodeIfPresent(String.self, forKey: .founder) ?? "N/A"
        about = try container.decodeIfPresent(String.self, forKey: .about) ?? "N/A"
        yearsActive = try container.decodeIfPresent(String.self, forKey: .yearsActive) ?? "N/A"
        website = try container.decodeIfPresent(String.self, forKey: .website) ?? "N/A"
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName) ?? "default_image"
        history = try container.decodeIfPresent([String].self, forKey: .history) ?? []
        affiliations = try container.decodeIfPresent([Affiliation].self, forKey: .affiliations) ?? []
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


extension Array where Element == Designer {
    func designersWithAffiliation(forBrandID brandID: String) -> [String] {
        return self.compactMap { designer in
            if designer.affiliations.contains(where: { $0.id == brandID }) {
                return designer.id
            }
            return nil
        }
    }
}


extension Designer {
    func designerIfAffiliated(withBrandID brandID: String) -> Designer? {
        if self.affiliations.contains(where: { $0.id == brandID }) {
            return self
        }
        return nil
    }
}
