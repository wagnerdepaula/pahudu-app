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



func fetchDesigners(completion: @escaping ([Designer]) -> Void) {
    let url = URL(string: "https://api.pahudu.com/v1/designers")!

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            print("Error fetching data: \(String(describing: error))")
            completion([])
            return
        }

        do {
            let designerResponse = try JSONDecoder().decode(DesignerResponse.self, from: data)
            completion(designerResponse.designers)
        } catch {
            print("Error decoding data: \(error)")
            completion([])
        }
    }

    task.resume()
}
