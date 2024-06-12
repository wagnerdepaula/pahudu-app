//
//  designerModel.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct DesignerItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}

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
    
    static let designers: [DesignerItem] = [
        DesignerItem(imageName: "Caroline Zimbalist", title: "Caroline Zimbalist", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Colleen Allen", title: "Colleen Allen", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Jacques Agbobly", title: "Jacques Agbobly", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Hedi Slimane", title: "Hedi Slimane", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Kate Barton", title: "Kate Barton", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Nigel Xavier", title: "Nigel Xavier", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Paolo Carzana", title: "Paolo Carzana", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Ludovic de Saint Sernin", title: "Ludovic de Saint Sernin", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Bishme Cromartie", title: "Bishme Cromartie", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Simon Porte Jacquemus", title: "Simon Porte Jacquemus", subtitle: "Fashion Designer"),
        DesignerItem(imageName: "Virginie Viard", title: "Virginie Viard", subtitle: "Fashion Designer"),
        
        
    ]
    
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
        BrandItem(imageName: "Miu Miu", title: "Miu Miu", subtitle: "Miu Miu")
    ]
}
