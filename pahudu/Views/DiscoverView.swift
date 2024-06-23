//
//  DiscoverView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI


struct DiscoverView: View {
        
    @EnvironmentObject var globalData: GlobalData
    @StateObject private var eventModel = EventModel()
    
    @State private var showDesignersList = false
    @State private var showBrandsList = false
    @State private var showShowsList = false
    
    @State private var showDesignerDetails = false
    @State private var showBrandDetails = false
    @State private var showShowDetails = false
    
    var body: some View {
        
        
        NavigationStack() {
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    
                    // Shows
                    VStack(spacing: 15) {
                        
                        HStack{
                            Button(action: {
                                showShowsList = true
                            }, label: {
                                HStack {
                                    Text("Shows")
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                }
                                .font(.button)
                            })
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(globalData.shows) { show in
                                    ShowItemView(show: show, eventModel: eventModel, showShowDetails: $showShowDetails)
                                        .id(show.id)
                                }
                            }
                            .padding(.horizontal, 20)
                            .drawingGroup()
                        }
                        .frame(minHeight: 175)
                    }
                    .padding(.vertical, 20)
                    
                    
                    // Brands
                    VStack(spacing: 15) {
                        
                        HStack {
                            
                            Button(action: {
                                showBrandsList = true
                            }, label: {
                                HStack {
                                    Text("Brands")
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                }
                                .font(.button)
                            })
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(globalData.brands) { brand in
                                    BrandItemView(brand: brand, eventModel: eventModel, showBrandDetails: $showBrandDetails)
                                        .id(brand.id)
                                }
                            }
                            .padding(.horizontal, 20)
                            .drawingGroup()
                        }
                        .frame(minHeight: 140)
                    }
                    .padding(.vertical, 20)
                    
                    
                    
                    
                    // Designers
                    VStack(spacing: 15) {
                        HStack {
                            Button(action: {
                                showDesignersList = true
                            }, label: {
                                HStack {
                                    Text("Designers")
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                }
                                .font(.button)
                            })
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(globalData.designers) { designer in
                                    DesignerItemView(designer: designer, eventModel: eventModel, showDesignerDetails: $showDesignerDetails)
                                        .id(designer.id)
                                }
                            }
                            .padding(.horizontal, 20)
                            .drawingGroup()
                        }
                        .frame(minHeight: 140)
                    }
                    .padding(.vertical, 20)
                    
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
        }
    }
    
    
   

}






struct ShowItemView: View {
    let show: Show
    let width: CGFloat = 180
    
    @ObservedObject var eventModel: EventModel
    @Binding var showShowDetails: Bool
    
    var body: some View {
        Button(action: {
            eventModel.selectedShow = show
            showShowDetails = true
        }) {
            VStack(spacing: 7) {
                ShowImageView(url: URL(string: "https://storage.googleapis.com/pahudu.com/shows/sm/\(show.name).png")!,
                              width: width,
                              height: width)
                
                Text(show.name)
                    .font(.callout)
                    .foregroundColor(Colors.Primary.foreground)
                    .frame(maxWidth: width, alignment: .leading)
                    .truncationMode(.tail)
            }
        }
    }
}


struct BrandItemView: View {
    let brand: Brand
    let width: CGFloat = 115
    
    @ObservedObject var eventModel: EventModel
    @Binding var showBrandDetails: Bool
    
    private let cornerRadius: CGFloat = 15
    
    var body: some View {
        Button(action: {
            eventModel.selectedBrand = brand
            showBrandDetails = true
        }) {
            VStack(spacing: 7) {
                BrandImageView(url: URL(string: "https://storage.googleapis.com/pahudu.com/brands/sm/\(brand.name).png")!,
                               width: width)
                
                Text(brand.name)
                    .font(.callout)
                    .foregroundColor(Colors.Primary.foreground)
                    .frame(maxWidth: width, alignment: .leading)
                    .truncationMode(.tail)
            }
        }
    }
}



struct DesignerItemView: View {
    let designer: Designer
    let width: CGFloat = 115
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDesignerDetails: Bool
    
    var body: some View {
        Button(action: {
            eventModel.selectedDesigner = designer
            showDesignerDetails = true
        }) {
            VStack(spacing: 7) {
                DesignerImageView(url: URL(string: "https://storage.googleapis.com/pahudu.com/designers/sm/\(designer.name).png")!,
                                  width: width)
                
                Text(designer.name.components(separatedBy: " ").first ?? "")
                    .font(.callout)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(Colors.Primary.foreground)
                    .frame(width: width, alignment: .center)
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
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
        .frame(width: width, height: width)
        .background(Colors.Secondary.background)
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(Colors.Primary.background, lineWidth: 1)
        }
    }
}


