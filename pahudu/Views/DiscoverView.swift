//
//  DiscoverView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI




struct ShowItemView: View {
    
    let show: ShowItem
    let width: CGFloat = 110
    
    @ObservedObject var eventModel: EventModel
    @Binding var showShowDetails: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image(show.imageName)
                .resizable()
                .frame(width: width, height: width)
                .foregroundColor(Colors.Primary.foreground)
                .background(Colors.Secondary.background)
                .clipShape(Rectangle())
                .overlay(
                    Rectangle()
                        .stroke(Colors.Primary.divider, lineWidth: 0.5)
                )
            
            Text(show.title)
                .font(.caption)
                .foregroundColor(Colors.Primary.foreground)
                .frame(maxWidth: width, alignment: .leading)
                .truncationMode(.tail)
        }
        .onTapGesture {
            eventModel.selectedShow = show
            showShowDetails = true
            UIApplication.triggerHapticFeedback()
        }
    }
}




struct BrandItemView: View {
    
    let brand: BrandItem
    let width: CGFloat = 110
    
    @ObservedObject var eventModel: EventModel
    @Binding var showBrandDetails: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(brand.imageName)
                .resizable()
                .frame(width: width, height: width)
                .foregroundColor(Colors.Primary.foreground)
                .background(Colors.Secondary.background)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Colors.Primary.divider, lineWidth: 0.5)
                )
            
            Text(brand.title)
                .font(.caption)
                .foregroundColor(Colors.Primary.foreground)
                .frame(maxWidth: width, alignment: .leading)
                .truncationMode(.tail)
        }
        .onTapGesture {
            eventModel.selectedBrand = brand
            showBrandDetails = true
            UIApplication.triggerHapticFeedback()
        }
    }
}






struct DesignerItemView: View {
    
    let designer: DesignerItem
    let width: CGFloat = 110
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDesignerDetails: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(designer.imageName)
                .resizable()
                .frame(width: width, height: width)
                .background(Colors.Secondary.foreground)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Colors.Primary.background, lineWidth: 0.5)
                )
            Text(designer.title.components(separatedBy: " ").first ?? "")
                .font(.caption)
                .foregroundColor(Colors.Primary.foreground)
                .frame(maxWidth: width, alignment: .center)
                .truncationMode(.tail)
        }
        .onTapGesture {
            eventModel.selectedDesigner = designer
            showDesignerDetails = true
            UIApplication.triggerHapticFeedback()
        }
    }
}










struct DiscoverView: View {
    
    @StateObject private var eventModel = EventModel()
    
    @State private var showDesignersList = false
    @State private var showBrandsList = false
    @State private var showShowsList = false
    
    @State private var showDesignerDetails = false
    @State private var showBrandDetails = false
    @State private var showShowDetails = false
    
    var body: some View {
        
        NavigationStack {
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
                                ForEach(GlobalData.shows) { show in
                                    ShowItemView(show: show, eventModel: eventModel, showShowDetails: $showShowDetails)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 20)
                    .overlay(
                        Divider(),
                        alignment: .bottom
                    )
                    
                    
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
                                ForEach(GlobalData.brands) { brand in
                                    BrandItemView(brand: brand, eventModel: eventModel, showBrandDetails: $showBrandDetails)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 20)
                    .overlay(
                        Divider(),
                        alignment: .bottom
                    )
                    
                    
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
                                ForEach(GlobalData.designers) { designer in
                                    DesignerItemView(designer: designer, eventModel: eventModel, showDesignerDetails: $showDesignerDetails)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 20)
                    .overlay(
                        Divider(),
                        alignment: .bottom
                    )
                    
                    
                    
                    
                }
                
                
                
            }
            .navigationBarTitle("Discover", displayMode: .inline)
            .background(Colors.Primary.background)
            .navigationDestination(isPresented: $showDesignersList) {
                DesignersListView()
            }
            .navigationDestination(isPresented: $showShowsList) {
                ShowsGridView()
            }
            .navigationDestination(isPresented: $showBrandsList) {
                BrandsListView()
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
        }
    }
    
}
