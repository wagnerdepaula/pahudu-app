//
//  designerModel.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI


struct ShowItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}

struct BrandItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}

struct DataModel {
 
    static let shows: [ShowItem] = [
        ShowItem(imageName: "Berlin Fashion Week", title: "Berlin Fashion Week", subtitle: "BFW"),
        ShowItem(imageName: "London Fashion Week", title: "London Fashion Week", subtitle: "LFW"),
        ShowItem(imageName: "Milano Fashion Week", title: "Milano Fashion Week", subtitle: "MFW"),
        ShowItem(imageName: "New York Fashion Week", title: "New York Fashion Week", subtitle: "NYFW"),
        ShowItem(imageName: "Paris Fashion Week", title: "Paris Fashion Week", subtitle: "PFW"),
        ShowItem(imageName: "Rakuten Fashion Week Tokyo", title: "Rakuten Fashion Week Tokyo", subtitle: "TFW"),
        ShowItem(imageName: "Sao Paulo Fashion Week", title: "Sao Paulo Fashion Week", subtitle: "SPFW"),
        ShowItem(imageName: "Shanghai Fashion Week", title: "Shanghai Fashion Week", subtitle: "SFW")
    ]
    
    static let brands: [BrandItem] = [
        BrandItem(imageName: "3.1 Phillip Lim", title: "3.1 Phillip Lim", subtitle: "3.1 Phillip Lim"),
        BrandItem(imageName: "Alaïa", title: "Alaïa", subtitle: "Alaïa"),
        BrandItem(imageName: "AMI Paris", title: "AMI Paris", subtitle: "AMI Paris"),
        BrandItem(imageName: "Brioni", title: "Brioni", subtitle: "Brioni"),
        BrandItem(imageName: "Burberry", title: "Burberry", subtitle: "Burberry"),
        BrandItem(imageName: "Chloé", title: "Chloé", subtitle: "Chloé"),
        BrandItem(imageName: "Coperni", title: "Coperni", subtitle: "Coperni"),
        BrandItem(imageName: "Dior", title: "Dior", subtitle: "Dior"),
        BrandItem(imageName: "Ganni", title: "Ganni", subtitle: "Ganni"),
        BrandItem(imageName: "Goyard", title: "Goyard", subtitle: "Goyard"),
        BrandItem(imageName: "Gucci", title: "Gucci", subtitle: "Gucci"),
        BrandItem(imageName: "Hermès", title: "Hermès", subtitle: "Hermès"),
        BrandItem(imageName: "Isabel Marant", title: "Isabel Marant", subtitle: "Isabel Marant"),
        BrandItem(imageName: "Jil Sander", title: "Jil Sander", subtitle: "Jil Sander"),
        BrandItem(imageName: "Marine Serre", title: "Marine Serre", subtitle: "Marine Serre"),
        BrandItem(imageName: "Missoni", title: "Missoni", subtitle: "Missoni"),
        BrandItem(imageName: "Miu Miu", title: "Miu Miu", subtitle: "Miu Miu"),
        BrandItem(imageName: "Lanvin", title: "Lanvin", subtitle: "Lanvin"),
        BrandItem(imageName: "Loewe", title: "Loewe", subtitle: "Loewe"),
        BrandItem(imageName: "Sandro", title: "Sandro", subtitle: "Sandro"),
        BrandItem(imageName: "Schiaparelli", title: "Schiaparelli", subtitle: "Schiaparelli"),
        BrandItem(imageName: "Sézane", title: "Sézane", subtitle: "Sézane")
    ]

}
