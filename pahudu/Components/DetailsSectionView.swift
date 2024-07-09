//
//  DetailSection.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/22/24.
//

import SwiftUI


struct DetailsSectionView: View {
    
    let title: String
    let detail: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            
            Text(title)
                .foregroundColor(Colors.Tertiary.foreground)
                .frame(maxWidth: 110, alignment: .leading)
            
            Text(detail)
                .foregroundColor(Colors.Primary.foreground)
                .lineSpacing(4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 11, leading: 15, bottom: 12, trailing: 15))
        Divider(height: 1)
    }
}



struct DetailsLinkSectionView: View {
    let title: String
    let link: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            
            Text(title)
                .foregroundColor(Colors.Tertiary.foreground)
                .frame(maxWidth: 110, alignment: .leading)
            
            Link(cleanURL(link), destination: URL(string: link)!)
                .foregroundColor(Colors.Primary.accent)
                .truncationMode(.tail)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 11, leading: 15, bottom: 12, trailing: 15))
    }
}



struct DesignersAffiliationSectionView: View {
    
    let title: String
    let creativeDirectors: [CreativeDirector]
    let designers: [Designer]
    let brandID: String
    
    @Binding var showDetails: Bool
    let eventModel: EventModel
    
    var sortedCreativeDirectors: [CreativeDirector] {
        creativeDirectors.sorted { (d1, d2) -> Bool in
            return d1.yearStarted > d2.yearStarted
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(title)
                .foregroundColor(Colors.Tertiary.foreground)
                .frame(maxWidth: 110, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 5) {
                
                ForEach(sortedCreativeDirectors) { director in
                    HStack(alignment: .top, spacing: 5) {
                        
                        if let designer = designers.first(where: { $0.id == director.id }) {
                            
                            Button {
                                eventModel.selectDesigner(designer: designer)
                                showDetails = true
                            } label: {
                                Text(director.name)
                                    .foregroundColor(Colors.Primary.accent)
                            }
                            
                        } else {
                            Text(director.name)
                                .foregroundColor(Colors.Primary.foreground)
                        }
                        
                        Text("(\(director.yearStarted))")
                            .foregroundColor(Colors.Primary.foreground)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 11, leading: 15, bottom: 12, trailing: 15))
        Divider(height: 1)
    }
}






struct BrandsAffiliationSectionView: View {
    
    let title: String
    let designer: Designer
    let brands: [Brand]
    
    @Binding var showDetails: Bool
    let eventModel: EventModel
    
    var sortedAffiliations: [Affiliation] {
        designer.affiliations.sorted { (a1, a2) -> Bool in
            return a1.since > a2.since
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            
            Text(title)
                .foregroundColor(Colors.Tertiary.foreground)
                .frame(maxWidth: 110, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(sortedAffiliations) { affiliation in
                    HStack(alignment: .top, spacing: 5) {
                        
                        if let brand = brands.first(where: { $0.id == affiliation.id }) {
                            
                            Button {
                                eventModel.selectBrand(brand: brand)
                                showDetails = true
                            } label: {
                                Text(brand.name)
                                    .foregroundColor(Colors.Primary.accent)
                            }
                            
                        } else {
                            Text(affiliation.brand)
                                .foregroundColor(Colors.Primary.foreground)
                        }
                        
                        Text("(\(affiliation.since))")
                            .foregroundColor(Colors.Primary.foreground)
                        
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 11, leading: 15, bottom: 12, trailing: 15))
        Divider(height: 1)
    }
}
