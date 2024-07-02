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
                        
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Secondary.background]), startPoint: .top, endPoint: .bottom)
                        
                        AsyncCachedImage(url: URL(string: "\(Path.brands)/lg/\(brand.imageName)")!) { image in
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
                    
                    
                    Spacer(minLength: 30)
                    
                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(Array(brand.history.enumerated()), id: \.element) { index, item in
                            HStack(alignment: .top, spacing: 0) {
                                Text("\(index + 1).")
                                    .foregroundColor(Colors.Tertiary.foreground)
                                    .font(.body)
                                    .frame(width: 25, alignment: .leading)
                                Text(item)
                                    .foregroundColor(Colors.Primary.foreground)
                                    .font(.body)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineSpacing(6)
                            }
                        }
                    }
                    
                    Spacer(minLength: 30)
                    
                    
                    // Table
                    VStack(spacing: 0) {
                        if brand.founder != "N/A" {
                            DetailsSectionView(title: "Founder", detail: brand.founder)
                        }
                        
                        if brand.foundedDate != "N/A" {
                            DetailsSectionView(title: "Date founded", detail: brand.foundedDate)
                        }
                        
                        if brand.headquarters != "N/A" {
                            DetailsSectionView(title: "Headquarters", detail: brand.headquarters)
                        }
                        
                        if brand.yearsActive != "N/A" {
                            DetailsSectionView(title: "Years Active", detail: brand.yearsActive)
                        }
                        
                        if brand.parentCompany != "N/A" {
                            DetailsSectionView(title: "Parent", detail: brand.parentCompany)
                        }
                        
                        if brand.nationality != "N/A" {
                            DetailsSectionView(title: "Nationality", detail: brand.nationality)
                        }
                        
                        if brand.website != "N/A" {
                            DetailsLinkSectionView(title: "Website", link: brand.website)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Colors.Secondary.background)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    
                    Spacer(minLength: 100)
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
            }
        }
        .edgesIgnoringSafeArea(.top)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}
