//
//  DiscoverView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI


struct ShowItemView: View {
    
    let show: ShowItem
    let width: CGFloat = 245
    let height: CGFloat = 150
    
    @ObservedObject var eventModel: EventModel
    @Binding var showShowDetails: Bool
    
    var body: some View {
        
        Button {
            
            eventModel.selectedShow = show
            showShowDetails = true
            
        } label: {
            VStack(spacing: 7) {
                
                Image(show.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .foregroundColor(Colors.Primary.foreground)
                    .background(Colors.Secondary.background)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
                
                Text(show.title)
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
    
    var body: some View {
        
        Button {
            eventModel.selectedBrand = brand
            showBrandDetails = true
        } label: {
            VStack(spacing: 7) {
                Image(brand.name)
                    .resizable()
                    .frame(width: width, height: width)
                    .foregroundColor(Colors.Primary.foreground)
                    .background(Colors.Secondary.background)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
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
        
        Button {
            
            eventModel.selectedDesigner = designer
            showDesignerDetails = true
            
        } label: {
            
            VStack(spacing: 7) {
                
                ZStack{
                    Image(designer.name)
                        .resizable()
                }
                .frame(width: width, height: width)
                .background(Colors.Secondary.background)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Colors.Primary.background, lineWidth: 1)
                }
                
                Text(designer.name.components(separatedBy: " ").first ?? "")
                    .font(.callout)
                    .foregroundColor(Colors.Primary.foreground)
                    .frame(maxWidth: width, alignment: .center)
                    .truncationMode(.tail)
            }
            
        }
    }
}










struct DiscoverView: View {
    
    @State private var brands: [Brand] = []
    @State private var designers: [Designer] = []
    
    @EnvironmentObject var globalData: GlobalData
    @StateObject private var eventModel = EventModel()
    
    @State private var showDesignersList = false
    @State private var showBrandsList = false
    @State private var showShowsList = false
    
    @State private var showDesignerDetails = false
    @State private var showBrandDetails = false
    @State private var showShowDetails = false
    
    @State private var itemOpacity: Double = 0.0
    
    
    var body: some View {
        
        NavigationStack() {
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    
                    // Shows
                    VStack(spacing: 5) {
                        
                        HStack{
                            
                            Button(action: {
                                showShowsList = true
                            }, label: {
                                HStack {
                                    Text("Shows")
                                    Image(systemName: "chevron.forward")
                                }
                                .font(.button)
                            })
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(DataModel.shows) { show in
                                    ShowItemView(show: show, eventModel: eventModel, showShowDetails: $showShowDetails)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 20)
        
                    
                    
                    // Brands
                    VStack(spacing: 5) {
                        
                        HStack {
                            
                            Button(action: {
                                showBrandsList = true
                            }, label: {
                                HStack {
                                    Text("Brands")
                                    Image(systemName: "chevron.forward")
                                }
                                .font(.button)
                            })
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(brands) { brand in
                                    BrandItemView(brand: brand, eventModel: eventModel, showBrandDetails: $showBrandDetails)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        }
                        .opacity(itemOpacity)
                        
                        
                    }
                    .padding(.vertical, 20)
                    
                    
                    // Designers
                    VStack(spacing: 5) {
                        HStack {
                            Button(action: {
                                showDesignersList = true
                            }, label: {
                                HStack {
                                    Text("Designers")
                                    Image(systemName: "chevron.forward")
                                }
                                .font(.button)
                            })
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(designers) { designer in
                                    DesignerItemView(designer: designer, eventModel: eventModel, showDesignerDetails: $showDesignerDetails)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        }
                        .opacity(itemOpacity)
                        
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
                    ShowDetailsView(item: show)
                }
            }
            .navigationDestination(isPresented: $showBrandDetails) {
                if let brand = eventModel.selectedBrand {
                    BrandDetailsView(item: brand)
                }
            }
            .navigationDestination(isPresented: $showDesignerDetails) {
                if let designer = eventModel.selectedDesigner {
                    DesignerDetailsView(item: designer)
                }
            }
            .task {
                designers = await fetchDesigners()
                brands = await fetchBrands()
                withAnimation(.easeOut(duration: 0.3)) {
                    itemOpacity = 1.0
                }
            }
        }
    }
    
}
