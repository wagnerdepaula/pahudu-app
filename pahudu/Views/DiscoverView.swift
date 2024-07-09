//
//  DiscoverView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI


struct DiscoverView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @EnvironmentObject var eventModel: EventModel
    
    @State private var showDesignersList = false
    @State private var showBrandsList = false
    @State private var showShowsList = false
    
    @State private var showDesignerDetails = false
    @State private var showBrandDetails = false
    @State private var showShowDetails = false
    
    @State private var opacity: Double = 0
    
    var body: some View {
        
        
        NavigationStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    
                    // More to discover
                    if globalData.designers.count > 0 {
                        
                        Text("Highlights")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Colors.Primary.foreground)
                            .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(Array(globalData.designers.prefix(10)), id: \.id) { designer in
                                    HighlightsItemView(designer: designer, eventModel: eventModel, showDesignerDetails: $showDesignerDetails)
                                        .id(designer.id)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    
                    Spacer()
                    
                    
                    
                    // Shows
                    if globalData.shows.count > 0 {
                        
                        Button(action: {
                            showShowsList = true
                        }, label: {
                            HStack {
                                Text("Shows")
                                Image(systemName: "chevron.forward")
                                    .opacity(0.5)
                                    .fontWeight(.bold)
                            }
                            .font(.title3)
                        })
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(globalData.shows) { show in
                                    ShowItemView(show: show, width: 180, eventModel: eventModel, showShowDetails: $showShowDetails)
                                        .id(show.id)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                    }
                    
                    
                    
                    Spacer()
                    
                    
                    // Brands
                    if globalData.brands.count > 0 {
                        
                        Button(action: {
                            showBrandsList = true
                        }, label: {
                            HStack {
                                Text("Brands")
                                Image(systemName: "chevron.forward")
                                    .opacity(0.5)
                                    .fontWeight(.bold)
                            }
                            .font(.title3)
                        })
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(globalData.brands) { brand in
                                    BrandItemView(brand: brand, width: 115, eventModel: eventModel, showBrandDetails: $showBrandDetails)
                                        .id(brand.id)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    
                    
                    
                    Spacer()
                    
                    
                    // Designers
                    if globalData.designers.count > 0 {
                        Button(action: {
                            showDesignersList = true
                        }, label: {
                            HStack {
                                Text("Designers")
                                Image(systemName: "chevron.forward")
                                    .opacity(0.5)
                                    .fontWeight(.bold)
                            }
                            .font(.title3)
                        })
                        .padding(.horizontal, 20)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(globalData.designers) { designer in
                                    DesignerItemView(designer: designer, width: 115, eventModel: eventModel, showDesignerDetails: $showDesignerDetails)
                                        .id(designer.id)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                    }
                    
                    
                    
                    
                    Spacer()
                    
                    
                    // Recent
                    if globalData.recentItems.count > 0 {
                        
                        
                        Text("Recently viewed")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Colors.Primary.foreground)
                            .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(globalData.recentItems.indices, id: \.self) { index in
                                    switch globalData.recentItems[index] {
                                    case let show as Show:
                                        ShowItemView(show: show, width: 115, eventModel: eventModel, showShowDetails: $showShowDetails)
                                            .id(show.id)
                                    case let brand as Brand:
                                        BrandItemView(brand: brand, width: 115, eventModel: eventModel, showBrandDetails: $showBrandDetails)
                                            .id(brand.id)
                                    case let designer as Designer:
                                        DesignerItemView(designer: designer, width: 115, eventModel: eventModel, showDesignerDetails: $showDesignerDetails)
                                            .id(designer.id)
                                    default:
                                        Text("Unknown item type")
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                
            }
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) {
                    opacity = 1.0
                }
            }
            .navigationBarTitle("Discover", displayMode: .inline)
            .background(Colors.Primary.background)
            .navigationDestination(isPresented: $showDesignersList) {
                DesignersView()
            }
            .navigationDestination(isPresented: $showShowsList) {
                ShowsView()
            }
            .navigationDestination(isPresented: $showBrandsList) {
                BrandsView()
            }
            .navigationDestination(isPresented: $showShowDetails) {
                if let show = eventModel.selectedShow {
                    ShowDetailsView(show: show)
                }
            }
            .navigationDestination(isPresented: $showBrandDetails) {
                if let brand = eventModel.selectedBrand {
                    BrandDetailsView(brand: brand)
                }
            }
            .navigationDestination(isPresented: $showDesignerDetails) {
                if let designer = eventModel.selectedDesigner {
                    DesignerDetailsView(designer: designer)
                }
            }
            .refreshable {
                async let showsTask = fetchShows()
                async let brandsTask = fetchBrands()
                async let designersTask = fetchDesigners()
                
                let fetchedShows = await showsTask
                let fetchedBrands = await brandsTask
                let fetchedDesigners = await designersTask
                
                globalData.shows = fetchedShows
                globalData.brands = fetchedBrands
                globalData.designers = fetchedDesigners
            }
            
        }
    }
    
    
}







struct HighlightsItemView: View {
    
    let designer: Designer
    let width: CGFloat = 280
    let height: CGFloat = 170
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDesignerDetails: Bool
    
    var body: some View {
        
        let url: URL = URL(string: "\(Path.designers)/lg/\(designer.imageName)")!
        
        Button(action: {
            showDesignerDetails = true
            eventModel.selectDesigner(designer: designer)
        }) {
            
            ZStack(alignment: .bottomTrailing) {
                
                AsyncCachedImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Colors.Secondary.background
                }
                
                let name = designer.name.split(separator: " ", maxSplits: 1)
                Text("\(name[0])\n\(name.count > 1 ? name[1] : "")")
                    .font(.headline)
                    .foregroundColor(Colors.Primary.foreground)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 10))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
        .background(Colors.Secondary.background)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .frame(width: width, height: height, alignment: .bottom)
        
        
        
        
        
    }
}










struct ShowItemView: View {
    
    let show: Show
    let width: CGFloat
    
    @ObservedObject var eventModel: EventModel
    @Binding var showShowDetails: Bool
    
    var body: some View {
        Button(action: {
            showShowDetails = true
            eventModel.selectShow(show: show)
        }) {
            VStack(spacing: 7) {
                ShowImageView(url: URL(string: "\(Path.shows)/sm/\(show.imageName)")!, width: width, height: width)
                Text(show.name)
                    .font(.caption)
                    .foregroundColor(Colors.Primary.foreground)
                    .frame(maxWidth: width, alignment: .leading)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}




struct BrandItemView: View {
    
    let brand: Brand
    let width: CGFloat
    
    @ObservedObject var eventModel: EventModel
    @Binding var showBrandDetails: Bool
    
    var body: some View {
        Button(action: {
            showBrandDetails = true
            eventModel.selectBrand(brand: brand)
        }) {
            VStack(spacing: 7) {
                BrandImageView(url: URL(string: "\(Path.brands)/sm/\(brand.imageName)")!, width: width)
                Text(brand.name)
                    .font(.caption)
                    .foregroundColor(Colors.Primary.foreground)
                    .frame(maxWidth: width, alignment: .leading)
                    .truncationMode(.tail)
            }
        }
    }
}



struct DesignerItemView: View {
    
    let designer: Designer
    let width: CGFloat
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDesignerDetails: Bool
    
    var body: some View {
        Button(action: {
            showDesignerDetails = true
            eventModel.selectDesigner(designer: designer)
        }) {
            VStack(spacing: 7) {
                DesignerImageView(url: URL(string: "\(Path.designers)/sm/\(designer.imageName)")!, width: width)
                Text(designer.name.components(separatedBy: " ").first ?? "")
                    .font(.caption)
                    .foregroundColor(Colors.Primary.foreground)
                    .frame(width: width, alignment: .center)
                    .truncationMode(.tail)
            }
        }
    }
}





struct ShowImageView: View {
    
    let url: URL
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncCachedImage(url: url) { image in
            image
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Colors.Secondary.background
        }
        .frame(width: width, height: height)
        .foregroundColor(Colors.Primary.foreground)
        .background(Colors.Secondary.background)
        .clipShape(
            Rectangle()
        )
    }
}



struct BrandImageView: View {
    
    let url: URL
    let width: CGFloat
    
    var body: some View {
        AsyncCachedImage(url: url) { image in
            image
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Colors.Secondary.background
        }
        .frame(width: width, height: width)
        .foregroundColor(Colors.Primary.foreground)
        .background(Colors.Secondary.background)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
    
}




struct DesignerImageView: View {
    
    let url: URL
    let width: CGFloat
    
    var body: some View {
        AsyncCachedImage(url: url) { image in
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
        .frame(width: width, height: width)
        .background(Colors.Tertiary.foreground)
        .clipShape(Circle())
        
    }
}
