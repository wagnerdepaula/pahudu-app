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
    //@StateObject private var motionManager = MotionManager()
    
    let designer: Designer
    let size: CGFloat = UIScreen.main.bounds.width
    
    @State private var itemOpacity: Double = 0.0
    @State private var showDetails: Bool = false
    
    @State private var logoOffset: CGFloat = 44
    @State private var logoOpacity: CGFloat = 0
    
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 0) {
                
                GeometryReader { geometry in
                    
                    let offsetY = geometry.frame(in: .global).minY
          
                    ZStack(alignment: .bottom) {
                        
                        Colors.Quaternary.background
                        
                        AsyncCachedImage(url: URL(string: "\(Path.designers)/lg/\(designer.imageName)")!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size, height: max(size, size + offsetY))
                                .opacity(itemOpacity)
                                .onAppear {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        itemOpacity = 1.0
                                    }
                                }
                        } placeholder: {
                            Colors.Secondary.background
                        }
                        
                        LinearGradient(gradient: Gradient(colors: [.clear, Colors.Primary.background.opacity(0.8)]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                        
//                        VStack(spacing: 0) {
//                            
//                            Text("\(designer.nationality != "N/A" ? "\(designer.nationality) " : "")Fashion Designer")
//                                .foregroundColor(Colors.Primary.foreground.opacity(0.5))
//                                .font(.body)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            
//                        }
                        
                        Text(designer.name)
                            .foregroundColor(Colors.Primary.foreground)
                            .font(.largeTitle)
                            .kerning(-0.3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 0))
                        
                        Divider()
                        
                    }
                    .frame(maxWidth: size, maxHeight: size, alignment: .bottom)
                }
                .frame(height: size)
                
                
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    
                    // Table
                    VStack(spacing: 0) {
                        
//                        if let affiliation = designer.affiliation,
//                           let foundBrand = globalData.brands.findBrand(byName: affiliation.brand) {
//                            HStack(spacing: 6) {
//                                Text("\(affiliation.position) at")
//                                    .foregroundColor(Colors.Tertiary.foreground)
//                                Button {
//                                    showDetails = true
//                                    eventModel.selectBrand(brand: foundBrand)
//                                } label: {
//                                    Text(foundBrand.name)
//                                        .foregroundColor(Colors.Primary.accent)
//                                }
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            }
//                            .font(.callout)
//                            .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
//                            Divider(height: 1)
//                        }
                        
                        
                        
                        if designer.dateOfBirth != "N/A" {
                            DetailsSectionView(title: "Born", detail: "\(designer.dateOfBirth)")
                        }
                        
                        if designer.placeOfBirth != "N/A" {
                            DetailsSectionView(title: "Place of birth", detail: "\(designer.placeOfBirth)")
                        }
                        
                        if designer.founder != "N/A" {
                            DetailsSectionView(title: "Founder", detail: designer.founder)
                        }
                        
                        if !designer.affiliations.isEmpty {
                            BrandsAffiliationSectionView(title: "Affiliations", designer: designer, brands: globalData.brands, showDetails: $showDetails, eventModel: eventModel)
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
                    
                    
                    
                    TypedText(text: designer.about)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                        .lineSpacing(6)
                    
                   
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(Array(designer.history.enumerated()), id: \.element) { index, item in
                            HStack(alignment: .top, spacing: 0) {
                                Text("\(index + 1).")
                                    .foregroundColor(Colors.Quaternary.foreground)
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
                    
                    
                    Spacer(minLength:50)
                    
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                
                
            }
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                    value: -$0.frame(in: .named("scroll")).origin.y)
            })
            .onPreferenceChange(ViewOffsetKey.self) { value in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    if value > 300 {
                        logoOffset = 0
                        logoOpacity = 1
                    } else {
                        logoOffset = 44
                        logoOpacity = 0
                    }
                }
            }
            
        }
        .coordinateSpace(name: "scroll")
        .toolbarRole(.editor)
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                
                HStack(spacing: 10) {
                    
                    AsyncCachedImage(url: URL(string: "\(Path.designers)/sm/\(designer.imageName)")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .background(Colors.Tertiary.foreground)
                    } placeholder: {
                        Colors.Secondary.background
                    }
                    .frame(width: 35, height: 35)
                    .overlay {
                        Circle()
                            .stroke(Colors.Secondary.background, lineWidth: 1)
                    }
                    .clipShape(Circle())
                    Text(designer.name)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.callout)
                    
                }
                .opacity(logoOpacity)
                .offset(y: logoOffset)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
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



struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
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
//            .padding(EdgeInsets(top: 12, leading: 20, bottom: 13, trailing: 20))
//
//            Divider(height: 1)
//        }
//    }
//}








//                    if let affiliation = designer.affiliation,
//                       let foundBrand = globalData.brands.findBrand(byName: affiliation.brand) {
//
//                        Title(text: "Affiliation")
//
//                        Button(action: {
//                            showDetails = true
//                            eventModel.selectBrand(brand: foundBrand)
//                        }) {
//                            HStack(spacing: 10) {
//                                AsyncCachedImage(url: URL(string: "\(Path.brands)/sm/\(foundBrand.imageName)")!) { image in
//                                    image
//                                        .renderingMode(.template)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                } placeholder: {
//                                    Colors.Secondary.background
//                                }
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .stroke(Colors.Secondary.divider, lineWidth: 1)
//                                }
//                                .frame(width: 80, height: 80)
//                                .foregroundColor(Colors.Primary.foreground)
//                                .background(Colors.Primary.background)
//                                .clipShape(
//                                    RoundedRectangle(cornerRadius: 15)
//                                )
//
//                                Text(foundBrand.name)
//                                    .foregroundColor(Colors.Primary.foreground)
//                                    .font(.subheadline)
//                                    .lineLimit(1)
//                                    .truncationMode(.tail)
//                            }
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .background(Colors.Primary.background)
//                        }
//                        .buttonStyle(BorderlessButtonStyle())
//                    }

