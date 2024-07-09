//
//  BrandDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/8/24.
//

import SwiftUI

struct BrandDetailsView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @EnvironmentObject var eventModel: EventModel
    
    let brand: Brand
    let size: CGFloat = UIScreen.main.bounds.width
    let imageSize: CGFloat = UIScreen.main.bounds.width - 55
    
    @State private var itemOpacity: Double = 0.0
    @State private var showDetails: Bool = false
    
    @State private var logoOffset: CGFloat = 44
    @State private var logoOpacity: CGFloat = 0
    
    //@State private var showDesignerDetails: Bool = false
    //@State private var showDesignersList: Bool = false
    
    var sortedCreativeDirectors: [CreativeDirector] {
        brand.creativeDirectors.sorted { (d1, d2) -> Bool in
            return d1.yearStarted > d2.yearStarted
        }
    }
    
    
    
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
                            Colors.Secondary.background
                        }
                    }
                    .frame(maxWidth: size, maxHeight: size, alignment: .bottom)
                }
                .frame(height: size)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Table
                    VStack(spacing: 0) {
                        
                        if !brand.founders.isEmpty {
                            let title = brand.founders.count == 1 ? "Founder" : "Founders"
                            DetailsSectionView(title: title, detail: brand.founders.joined(separator: "\n"))
                        }
                        
                        if brand.foundedYear != "N/A" {
                            DetailsSectionView(title: "Founded", detail: brand.foundedYear)
                        }
                        
                        if !brand.creativeDirectors.isEmpty {
                            let title = brand.creativeDirectors.count == 1 ? "Creative Dir." : "Creative Dirs."
                            DesignersAffiliationSectionView(title: title, creativeDirectors: brand.creativeDirectors, designers: globalData.designers, brandID: brand.id, showDetails: $showDetails, eventModel: eventModel)
                        }
                        
                        if brand.yearsActive != "N/A" {
                            DetailsSectionView(title: "Years Active", detail: brand.yearsActive)
                        }
                        
                        if brand.parentCompany != "N/A" {
                            DetailsSectionView(title: "Parent", detail: brand.parentCompany)
                        }
                        
                        if brand.headquarters != "N/A" {
                            DetailsSectionView(title: "Headquarters", detail: brand.headquarters)
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
                    
                    
                    
                    TypedText(text: brand.about)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                        .lineSpacing(6)
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(Array(brand.history.enumerated()), id: \.element) { index, item in
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
                    
                    
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                

                
                
                Spacer(minLength: 30)
                
                
                
                
                // Creative Directors
                if !brand.creativeDirectors.isEmpty {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Button(action: {
                            //showDesignersList = true
                        }, label: {
                            HStack {
                                Text("Creative Directors")
                                Image(systemName: "chevron.forward")
                                    .opacity(0.5)
                                    .fontWeight(.bold)
                            }
                            .font(.title3)
                        })
                        .padding(.horizontal, 20)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            LazyHStack(spacing: 15) {
                                
                                let designerDict = Dictionary(uniqueKeysWithValues: globalData.designers.map { ($0.id, $0) })
                                
                                ForEach(sortedCreativeDirectors, id: \.id) { director in
                                    
                                    if let designer = designerDict[director.id] {
                                        
                                        HStack(alignment: .top, spacing: 5) {
                                            
                                            Button(action: {
                                                showDetails = true
                                                eventModel.selectDesigner(designer: designer)
                                            }) {
                                                VStack(spacing: 7) {
                                                    
                                                    AsyncCachedImage(url: URL(string: "\(Path.designers)/sm/\(designer.imageName)")!) { image in
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                    } placeholder: {
                                                        Colors.Secondary.background
                                                    }
                                                    .overlay {
                                                        Circle()
                                                            .stroke(Colors.Primary.background, lineWidth: 1)
                                                    }
                                                    .frame(width: 115, height: 115)
                                                    .background(Colors.Tertiary.foreground)
                                                    .clipShape(Circle())
                                                    
                                                    
                                                    VStack(spacing: 3) {
                                                        
                                                        Text(director.name)
                                                            .font(.caption)
                                                            .foregroundColor(Colors.Primary.foreground)
                                                            .frame(width: 115, alignment: .center)
                                                            .lineLimit(1)
                                                            .truncationMode(.tail)
                                                        
                                                        Text(director.yearStarted)
                                                            .font(.caption)
                                                            .foregroundColor(Colors.Tertiary.foreground)
                                                            .frame(maxWidth: .infinity, alignment: .center)
                                                            .truncationMode(.tail)
                                                    }
                                                    
                                                    
                                                    
                                                }
                                            }
                                            
                                            .id(director.id)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                
                
                Spacer(minLength: 30)
                
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
            
            ToolbarItem(placement: .principal) {
                
                AsyncCachedImage(url: URL(string: "\(Path.brands)/sm/\(brand.imageName)")!) { image in
                    image
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Colors.Primary.foreground)
                } placeholder: {
                    Color.clear
                }
                .frame(width: 100, height: 100)
                .opacity(logoOpacity)
                .offset(y: logoOffset)
                
                
            }
        }
        .edgesIgnoringSafeArea(.top)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
        .navigationDestination(isPresented: $showDetails) {
            if let designer = eventModel.selectedDesigner {
                DesignerDetailsView(designer: designer)
            }
        }
    }
}
