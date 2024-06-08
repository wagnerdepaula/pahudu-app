//
//  DiscoverView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/24/24.
//

import SwiftUI



struct DesignerItemView: View {
    
    let designer: DesignerItem
    let width: CGFloat = 110
    let color: Color = getRandomColor()
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDesignersDetails: Bool
    
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
            showDesignersDetails = true
            eventModel.selectedDesigner = designer
            UIApplication.triggerHapticFeedback()
        }
    }
}





struct ShowItemView: View {
    
    let show: ShowItem
    let width: CGFloat = 110
    let color: Color = Colors.Primary.divider
    @Binding var showShowsList: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(show.imageName)
                .resizable()
                .frame(width: width, height: width)
                .foregroundColor(Colors.Primary.foreground)
                .background(Colors.Secondary.background)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(color, lineWidth: 0.5)
                )
            
            Text(show.title)
                .font(.caption)
                .foregroundColor(Colors.Primary.foreground)
                .frame(maxWidth: width, alignment: .leading)
                .truncationMode(.tail)
        }
        .onTapGesture {
            showShowsList = true
            UIApplication.triggerHapticFeedback()
        }
    }
}



struct BrandItemView: View {
    
    let brand: BrandItem
    let width: CGFloat = 110
    let color: Color = Colors.Primary.divider
    @Binding var showBrandsList: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(brand.imageName)
                .resizable()
                .frame(width: width, height: width)
                .foregroundColor(Colors.Primary.foreground)
                .background(Colors.Secondary.background)
                .clipShape(Rectangle())
                .overlay(
                    Rectangle()
                        .stroke(color, lineWidth: 0.5)
                )
            
            Text(brand.title)
                .font(.caption)
                .foregroundColor(Colors.Primary.foreground)
                .frame(maxWidth: width, alignment: .leading)
                .truncationMode(.tail)
        }
        .onTapGesture {
            showBrandsList = true
            UIApplication.triggerHapticFeedback()
        }
    }
}





struct DiscoverView: View {
    
    @StateObject private var eventModel = EventModel()
    
    @State private var showDesignersList = false
    @State private var showBrandsList = false
    @State private var showShowsList = false
    
    @State private var showDesignersDetails = false
    @State private var showBrandsDetails = false
    @State private var showShowsDetails = false
    
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    
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
                                    DesignerItemView(designer: designer, eventModel: eventModel, showDesignersDetails: $showDesignersDetails)
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
                                    BrandItemView(brand: brand, showBrandsList: $showBrandsList)
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
                                    ShowItemView(show: show, showShowsList: $showShowsList)
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
            .navigationDestination(isPresented: $showDesignersDetails) {
                if let designer = eventModel.selectedDesigner {
                    DesignerDetailsView(item: designer)
                }
            }
        }
    }
}
