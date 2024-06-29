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
        HStack(alignment: .top) {
            
            Text(title)
                .foregroundColor(Colors.Tertiary.foreground)
                .frame(maxWidth: 110, alignment: .leading)
            
            Text(detail)
                .foregroundColor(Colors.Primary.foreground)
                .lineSpacing(4)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 12, leading: 15, bottom: 13, trailing: 15))
        Divider(height: 1)
    }
}



struct DetailsLinkSectionView: View {
    let title: String
    let link: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .foregroundColor(Colors.Tertiary.foreground)
                .frame(maxWidth: 110, alignment: .leading)
            
            Link(cleanURL(link), destination: URL(string: link)!)
                .foregroundColor(Colors.Primary.accent)
                .truncationMode(.tail)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 12, leading: 15, bottom: 13, trailing: 15))
    }
}
