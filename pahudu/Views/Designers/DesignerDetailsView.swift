//
//  DesignerDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI


struct DesignerDetailsView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @EnvironmentObject var eventModel: EventModel
    
    let designer: Designer
    let size: CGFloat = UIScreen.main.bounds.width
    let imageSize: CGFloat = UIScreen.main.bounds.width
    
    @State private var itemOpacity: Double = 0.0
    @State private var showDetails: Bool = false
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                
                GeometryReader { geometry in
                    
                    let offsetY = geometry.frame(in: .global).minY
                    
                    ZStack(alignment: .bottom) {
                        
                        Colors.Secondary.background
                        
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
                            Colors.Secondary.background
                        }
                        
                        
                        LinearGradient(gradient: Gradient(colors: [.clear, .clear, Colors.Primary.background.opacity(0.7)]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                        
                        Text(designer.name)
                            .foregroundColor(Colors.Primary.foreground)
                            .font(.largeTitle)
                            .kerning(-0.3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 13, trailing: 0))
                        
                        
                        
                        Divider()
                        
                    }
                    .frame(maxWidth: size, maxHeight: size, alignment: .bottom)
                    
                }
                .frame(height: size)
                
                
                
                
                
                VStack(alignment: .leading) {
                    
                    TypedText(text: designer.about)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                        .lineSpacing(6)
                    
                    
                    Spacer(minLength: 20)
                    
                    
                    // Table
                    VStack(spacing: 0) {
                        
                        
                        if let affiliation = designer.affiliation,
                           let foundBrand = globalData.brands.findBrand(byName: affiliation.brand) {
                            HStack(spacing: 0) {
                                Text("\(affiliation.position) at ")
                                    .foregroundColor(Colors.Tertiary.foreground)
                                
                                Button {
                                    showDetails = true
                                    eventModel.selectBrand(brand: foundBrand)
                                } label: {
                                    Text(foundBrand.name)
                                        .foregroundColor(Colors.Primary.accent)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .font(.callout)
                            .padding(EdgeInsets(top: 12, leading: 15, bottom: 13, trailing: 15))
                            Divider(height: 1)
                        }
                        
                        
                        
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
                    
                    
                    Spacer(minLength: 20)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(Array(designer.history.enumerated()), id: \.element) { index, item in
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
                    
                    
                    Spacer(minLength: 100)
                    
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                
                
            }
        }
        .edgesIgnoringSafeArea(.top)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
        .navigationDestination(isPresented: $showDetails) {
            if let brand = eventModel.selectedBrand {
                BrandDetailsView(brand: brand)
            }
        }
    }
}



//struct AffiliationView: View {
//
//    @ObservedObject var eventModel: EventModel
//    @Binding var showDetails: Bool
//
//    let title: String
//    let brand: Brand
//
//    var body: some View {
//
//        VStack(alignment: .leading, spacing: 0) {
//            HStack(alignment: .top) {
//
//                Text(title)
//                    .foregroundColor(Colors.Tertiary.foreground)
//                    .frame(width: 110, alignment: .leading)
//
//                Button {
//                    showDetails = true
//                    eventModel.selectBrand(brand: brand)
//                } label: {
//                    Text(brand.name)
//                        .foregroundColor(Colors.Primary.accent)
//                }
//                .frame(maxWidth: .infinity, alignment: .trailing)
//
//            }
//            .font(.callout)
//            .padding(EdgeInsets(top: 12, leading: 15, bottom: 13, trailing: 15))
//
//            Divider(height: 1)
//        }
//    }
//}




