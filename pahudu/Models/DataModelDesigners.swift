//
//  DataModelDesigners.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/18/24.
//

import SwiftUI

struct DesignerResponse: Codable {
    let version: String
    let designers: [Designer]
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



func fetchDesigners() async -> [Designer] {
    let url = URL(string: "https://api.pahudu.com/v1/designers")!
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let designerResponse = try JSONDecoder().decode(DesignerResponse.self, from: data)
        return designerResponse.designers
    } catch {
        print("Error fetching data: \(error)")
        return []
    }
}
