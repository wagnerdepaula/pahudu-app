//
//  BrandsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct BrandsView: View {
    
    @ObservedObject var eventModel: EventModel = EventModel()
    @State private var showDetails: Bool = false
    @State private var searchText = ""
    @State private var showGridView = false
    @State private var brands: [Brand] = []
    @State private var itemOpacity: Double = 0.0
    
    
    var body: some View {
        NavigationStack {
            Group {
                if showGridView {
                    BrandsGridView(eventModel: eventModel, showDetails: $showDetails, brands: $brands)
                } else {
                    BrandsListView(eventModel: eventModel, showDetails: $showDetails, brands: $brands)
                }
            }
            .opacity(itemOpacity)
            .task {
                brands = await fetchBrands()
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
                BrandDetailsView(item: brand)
            }
        }
    }
}



struct BrandsListView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var brands: [Brand]
    let width: CGFloat = 60
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(brands) { item in
                    Button {
                        showDetails = true
                        eventModel.selectedBrand = item
                    } label: {
                        
                        HStack(spacing: 15) {
                            
                            Image(item.name)
                                .resizable()
                                .frame(width: width, height: width)
                                .background(Colors.Secondary.background)
                                .foregroundColor(Colors.Primary.foreground)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(item.name)
                                .foregroundColor(Colors.Primary.foreground)
                                .font(.body)
                            
                            Spacer()
                        }
                        .background(Colors.Primary.background)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    }
                    //                    .overlay(
                    //                        Divider(),
                    //                        alignment: .bottom
                    //                    )
                }
            }
        }
    }
}




struct BrandsGridView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var brands: [Brand]
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top)
    ]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(brands) { item in
                    
                    Button {
                        showDetails = true
                        eventModel.selectedBrand = item
                    } label: {
                        VStack(alignment: .center, spacing: 5) {
                            
                            Image(item.name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(Colors.Primary.foreground)
                                .background(Colors.Secondary.background)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(item.name)
                                .foregroundColor(Colors.Tertiary.foreground)
                                .font(.callout)
                                .lineLimit(1)
                                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                        }
                    }
                    
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
        }
        .background(Colors.Primary.background)
    }
}




