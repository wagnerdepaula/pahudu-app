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
                .foregroundColor(Colors.Primary.foreground)
                .frame(maxWidth: 100, alignment: .leading)
            Text(detail)
                .foregroundColor(Colors.Secondary.foreground)
                .lineSpacing(4)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .frame(alignment: .leading)
        Divider(padding: 0, height: 1)
    }
}


struct DetailsLinkSectionView: View {
    
    let title: String
    let link: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .foregroundColor(Colors.Primary.foreground)
                .frame(maxWidth: 100, alignment: .leading)
            Link(cleanURL(link), destination: URL(string: link)!)
                .foregroundColor(Colors.Primary.accent)
                .truncationMode(.tail)
                .lineLimit(1)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 11, trailing: 15))
        .frame(alignment: .leading)
    }
}
