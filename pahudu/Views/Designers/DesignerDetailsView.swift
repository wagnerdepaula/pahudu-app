//
//  DesignerDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct DesignerDetailsView: View {
    
    let item: Designer
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    let offsetY = geometry.frame(in: .global).minY

                    
                    ZStack(alignment: .bottom) {
                        Image(item.name)
                            .resizable()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Secondary.background]), startPoint: .top, endPoint: .bottom)
                            )
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: max(width, width + offsetY))
                            .clipped()

                       

                    }
                    .frame(maxWidth: .infinity, maxHeight: height, alignment: .bottom)
                }
                .frame(height: height)

                Text(item.name)
                    .foregroundColor(Colors.Primary.foreground)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                
                TypedText(text: item.about)
                    .foregroundColor(Colors.Primary.foreground)
                    .font(.body)
                    .lineSpacing(6)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

                
                // Table
                VStack(alignment: .leading, spacing: 0) {
                    DetailsSectionView(title: "Born", detail: item.dateOfBirth)
                    DetailsSectionView(title: "Founder", detail: item.founder)
                    DetailsSectionView(title: "Education", detail: item.education)
                    DetailsSectionView(title: "Years Active", detail: item.yearsActive)
                    DetailsSectionView(title: "Spouse", detail: item.spouse)
                    DetailsSectionView(title: "Nationality", detail: item.nationality)
                    if item.website != "N/A" {
                        DetailsLinkSectionView(title: "Website", link: item.website)
                    } else {
                        DetailsSectionView(title: "Website", detail: "N/A")
                    }
                }
                .background(Colors.Secondary.background)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                
                Spacer(minLength: 100)
            }
            .padding(0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .edgesIgnoringSafeArea(.all)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}


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
                .lineSpacing(4)
        }
        .font(.callout)
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 11, trailing: 15))
    }
}
