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

struct Show: Codable, Identifiable {
    let id: String
    let name: String
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
}

struct SocialMedia: Codable {
    let instagram: String
    let twitter: String
    let facebook: String
}

struct ShowWithImageURL: Identifiable {
    let id: String
    let show: Show
    let imageURL: URL
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
