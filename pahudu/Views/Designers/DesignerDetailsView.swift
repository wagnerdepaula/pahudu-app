//
//  DesignerDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI


struct DesignerDetailsView: View {
    
    let designer: Designer
    let size: CGFloat = UIScreen.main.bounds.width
    let imageSize: CGFloat = UIScreen.main.bounds.width
    @State private var itemOpacity: Double = 0.0
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    let offsetY = geometry.frame(in: .global).minY
                    ZStack(alignment: .bottom) {
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Tertiary.background]), startPoint: .top, endPoint: .bottom)
                        AsyncCachedImage(url: URL(string: "https://storage.googleapis.com/pahudu.com/designers/lg/\(designer.name).png")!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: imageSize, height: max(imageSize, imageSize + offsetY))
                                .opacity(itemOpacity)
                                .onAppear {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        itemOpacity = 1.0
                                    }
                                }
                        } placeholder: {
                            Color.clear
                        }
                    }
                    .frame(maxWidth: size, maxHeight: size, alignment: .bottom)
                }
                .frame(height: size)
                
                
                VStack(alignment: .leading) {
                    
                    Text(designer.name)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.largeTitle)
                        .kerning(-0.3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer(minLength: 10)
                    
                    TypedText(text: designer.about)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                        .lineSpacing(6)
                    
                    Spacer(minLength: 25)
                    
                    // Table
                    VStack(alignment: .leading, spacing: 0) {
                        DetailsSectionView(title: "Born", detail: designer.dateOfBirth)
                        DetailsSectionView(title: "Founder", detail: designer.founder)
                        DetailsSectionView(title: "Education", detail: designer.education)
                        DetailsSectionView(title: "Years Active", detail: designer.yearsActive)
                        DetailsSectionView(title: "Spouse", detail: designer.spouse)
                        DetailsSectionView(title: "Nationality", detail: designer.nationality)
                        if designer.website != "N/A" {
                            DetailsLinkSectionView(title: "Website", link: designer.website)
                        } else {
                            DetailsSectionView(title: "Website", detail: "N/A")
                        }
                    }
                    .background(Colors.Secondary.background)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer(minLength: 100)
                }
                .padding(20)
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}






