//
//  BrandDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/8/24.
//

import SwiftUI

struct BrandDetailsView: View {
    
    let brand: Brand
    let size: CGFloat = UIScreen.main.bounds.width
    let imageSize: CGFloat = UIScreen.main.bounds.width - 55
    @State private var itemOpacity: Double = 0.0
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    let offsetY = geometry.frame(in: .global).minY
                    ZStack(alignment: .bottom) {
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Tertiary.background]), startPoint: .top, endPoint: .bottom)
                        AsyncCachedImage(url: URL(string: "https://storage.googleapis.com/pahudu.com/brands/lg/\(brand.name).png")!) { image in
                            image
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Colors.Primary.foreground)
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
                    
                    Text(brand.name)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.largeTitle)
                        .kerning(-0.3)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer(minLength: 10)
                    
                    TypedText(text: brand.about)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                        .lineSpacing(6)
                    
                    Spacer(minLength: 25)
                    
                    // Table
                    VStack(alignment: .leading, spacing: 0) {
                        DetailsSectionView(title: "Founder", detail: brand.founder)
                        DetailsSectionView(title: "Date founded", detail: brand.foundedDate)
                        DetailsSectionView(title: "Headquarters", detail: brand.headquarters)
                        DetailsSectionView(title: "Years Active", detail: brand.yearsActive)
                        DetailsSectionView(title: "Parent", detail: brand.parentCompany)
                        DetailsSectionView(title: "Nationality", detail: brand.nationality)
                        if brand.website != "N/A" {
                            DetailsLinkSectionView(title: "Website", link: brand.website)
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
