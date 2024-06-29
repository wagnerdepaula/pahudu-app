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
                        
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Secondary.background]), startPoint: .top, endPoint: .bottom)
                        
                        AsyncCachedImage(url: URL(string: "\(Path.designers)/lg/\(designer.imageName)")!) { image in
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
                        
                        Divider()
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
                    
                    
                    
                    Spacer(minLength: 30)
                    
                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(Array(designer.history.enumerated()), id: \.element) { index, item in
                            HStack(alignment: .top, spacing: 0) {
                                Text("\(index + 1).")
                                    .foregroundColor(Colors.Secondary.foreground)
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
                        
                        if designer.dateOfBirth != "N/A" {
                            DetailsSectionView(title: "Born", detail: "\(designer.dateOfBirth)")
                        }
                        
                        if designer.placeOfBirth != "N/A" {
                            DetailsSectionView(title: "Place of birth", detail: "\(designer.placeOfBirth)")
                        }
                        
                        if designer.founder != "N/A" {
                            DetailsSectionView(title: "Founder", detail: designer.founder)
                        }
                        
                        if designer.education != "N/A" {
                            DetailsSectionView(title: "Education", detail: designer.education)
                        }
                        
                        if designer.yearsActive != "N/A" {
                            DetailsSectionView(title: "Years Active", detail: designer.yearsActive)
                        }
                        
                        if designer.spouse != "N/A" {
                            DetailsSectionView(title: "Spouse", detail: designer.spouse)
                        }
                        
                        if designer.nationality != "N/A" {
                            DetailsSectionView(title: "Nationality", detail: designer.nationality)
                        }
                        
                        if designer.website != "N/A" {
                            DetailsLinkSectionView(title: "Website", link: designer.website)
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






