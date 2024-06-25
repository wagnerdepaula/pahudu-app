//
//  BrandsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct BrandsView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @ObservedObject var eventModel: EventModel = EventModel()
    
    @State private var searchText = ""
    @State private var showGridView = false
    @State private var showDetails: Bool = false
    @State private var itemOpacity: Double = 0.0
    
    var body: some View {
        NavigationStack {
            Group {
                if showGridView {
                    BrandsGridView(eventModel: eventModel, showDetails: $showDetails, brands: $globalData.brands, searchText: $searchText)
                } else {
                    BrandsListView(eventModel: eventModel, showDetails: $showDetails, brands: $globalData.brands, searchText: $searchText)
                }
            }
            .opacity(itemOpacity)
            .onAppear {
                withAnimation(.easeOut(duration: 0.3)) {
                    itemOpacity = 1.0
                }
            }
            .navigationBarTitle("Brands", displayMode: .inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .background(Colors.Primary.background)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            showGridView = true
                            UIApplication.triggerHapticFeedback()
                        }) {
                            Label("Grid", systemImage: "circle.grid.3x3.fill")
                        }
                        Button(action: {
                            showGridView = false
                            UIApplication.triggerHapticFeedback()
                        }) {
                            Label("List", systemImage: "rectangle.grid.1x2.fill")
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Colors.Tertiary.background)
                                .frame(width: 30, height: 30)
                            Image(systemName: "ellipsis")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(Colors.Primary.accent)
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showDetails) {
            if let brand = eventModel.selectedBrand {
                BrandDetailsView(brand: brand)
            }
        }
    }
}




struct BrandsListView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var brands: [Brand]
    @Binding var searchText: String
    
    let width: CGFloat = 70
    
    var filteredBrands: [Brand] {
        if searchText.isEmpty {
            return brands
        } else {
            return brands.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(filteredBrands) { brand in
                    Button {
                        showDetails = true
                        eventModel.selectedBrand = brand
                    } label: {
                        HStack(spacing: 10) {
                            AsyncCachedImage(url: URL(string: "\(Constants.path)/brands/sm/\(brand.imageName)")!) { image in
                                image
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Colors.Secondary.background
                            }
                            .frame(width: width, height: width)
                            .background(Colors.Secondary.background)
                            .foregroundColor(Colors.Primary.foreground)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(brand.name)
                                .foregroundColor(Colors.Primary.foreground)
                                .font(.body)
                            
                            Spacer()
                        }
                        .background(Colors.Primary.background)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                    }
                    .id(brand.id)
                }
            }
            .drawingGroup()
        }
    }
}





struct BrandsGridView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var brands: [Brand]
    @Binding var searchText: String
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top)
    ]
    
    var filteredBrands: [Brand] {
        if searchText.isEmpty {
            return brands
        } else {
            return brands.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(filteredBrands) { brand in
                    BrandGridItemView(brand: brand, eventModel: eventModel, showDetails: $showDetails)
                        .id(brand.id)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .drawingGroup()
        }
        .background(Colors.Primary.background)
    }
}





struct BrandGridItemView: View {
    let brand: Brand
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    private let cornerRadius: CGFloat = 10
    
    var body: some View {
        Button {
            showDetails = true
            eventModel.selectedBrand = brand
        } label: {
            VStack(alignment: .center, spacing: 5) {
                GeometryReader { geometry in
                    AsyncCachedImage(url: URL(string: "\(Constants.path)/brands/sm/\(brand.imageName)")!) { image in
                        image
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Colors.Secondary.background
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .foregroundColor(Colors.Primary.foreground)
                    .background(Colors.Secondary.background)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                }
                .aspectRatio(1, contentMode: .fit)
                
                
                Text(brand.name)
                    .foregroundColor(Colors.Secondary.foreground)
                    .font(.caption)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("Brand: \(brand.name)"))
    }
}




