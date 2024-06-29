//
//  ShowsDataModel.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/22/24.
//

import Foundation
import SwiftUI
import Combine

struct ShowResponse: Codable {
    let version: String
    var shows: [Show]
}

struct Show: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let acronym: String
    let location: String
    let startDate: String
    let endDate: String
    let organizer: String
    let about: String
    let founder: String
    let established: String
    let frequency: String
    let website: String
    let keyHighlights: String
    let socialMedia: SocialMedia
    let imageName: String
    let history: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, acronym, location, startDate, endDate, organizer, about, founder, established, frequency, website, keyHighlights, socialMedia, imageName, history
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        acronym = try container.decodeIfPresent(String.self, forKey: .acronym) ?? "N/A"
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? "N/A"
        startDate = try container.decodeIfPresent(String.self, forKey: .startDate) ?? "N/A"
        endDate = try container.decodeIfPresent(String.self, forKey: .endDate) ?? "N/A"
        organizer = try container.decodeIfPresent(String.self, forKey: .organizer) ?? "N/A"
        about = try container.decodeIfPresent(String.self, forKey: .about) ?? "N/A"
        founder = try container.decodeIfPresent(String.self, forKey: .founder) ?? "N/A"
        established = try container.decodeIfPresent(String.self, forKey: .established) ?? "N/A"
        frequency = try container.decodeIfPresent(String.self, forKey: .frequency) ?? "N/A"
        website = try container.decodeIfPresent(String.self, forKey: .website) ?? "N/A"
        keyHighlights = try container.decodeIfPresent(String.self, forKey: .keyHighlights) ?? "N/A"
        socialMedia = try container.decodeIfPresent(SocialMedia.self, forKey: .socialMedia) ?? SocialMedia()
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName) ?? "default_image"
        history = try container.decodeIfPresent(Array.self, forKey: .history) ?? []
    }
}

struct SocialMedia: Codable, Hashable {
    let instagram: String
    let twitter: String
    let facebook: String
    
    enum CodingKeys: String, CodingKey {
        case instagram, twitter, facebook
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        instagram = try container.decodeIfPresent(String.self, forKey: .instagram) ?? "N/A"
        twitter = try container.decodeIfPresent(String.self, forKey: .twitter) ?? "N/A"
        facebook = try container.decodeIfPresent(String.self, forKey: .facebook) ?? "N/A"
    }
    
    init(instagram: String = "N/A", twitter: String = "N/A", facebook: String = "N/A") {
        self.instagram = instagram
        self.twitter = twitter
        self.facebook = facebook
    }
}


@MainActor
func fetchShows() async -> [Show] {
    let url = URL(string: "https://api.pahudu.com/v1/shows")!
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        var response = try JSONDecoder().decode(ShowResponse.self, from: data)
        response.shows.sort { $0.name.lowercased() < $1.name.lowercased() }
        return response.shows
    } catch {
        print("Error fetching data: \(error)")
        return []
    }
}


extension Show: Equatable {
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id
    }
}
