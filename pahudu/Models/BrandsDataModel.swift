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

struct Brand: Codable, Identifiable {
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

