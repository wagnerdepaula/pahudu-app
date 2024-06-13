//
//  BrandsListView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct BrandsListView: View {
    
    @ObservedObject var eventModel: EventModel = EventModel()
    @State private var showDetails: Bool = false
    @State private var searchText = ""
    @State private var showGridView = false
    
    var body: some View {
        NavigationStack {
            Group {
                if showGridView {
                    BrandGridView(eventModel: eventModel, showDetails: $showDetails)
                } else {
                    BrandListView(eventModel: eventModel, showDetails: $showDetails)
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
                        }) {
                            Label("Grid", systemImage: "square.grid.2x2")
                        }
                        Button(action: {
                            showGridView = false
                        }) {
                            Label("List", systemImage: "list.dash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                            .foregroundColor(Colors.Primary.accent)
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

struct BrandListView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(DataModel.brands) { item in
                    BrandRowView(item: item, eventModel: eventModel, showDetails: $showDetails)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}



struct BrandGridView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top)
    ]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(DataModel.brands) { item in
                    Button {
                        showDetails = true
                        eventModel.selectedBrand = item
                    } label: {
                        VStack(alignment: .center, spacing: 10) {
                            
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(Colors.Primary.foreground)
                                .background(Colors.Secondary.background)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Text(item.title.components(separatedBy: " ").first ?? "")
                                .foregroundColor(Colors.Tertiary.foreground)
                                .font(.caption)
                        }
                    }
                    
                }
            }
            .padding(20)
        }
        .background(Colors.Primary.background)
    }
}




struct BrandRowView: View {
    
    let item: BrandItem
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    var body: some View {
        Button {
            showDetails = true
            eventModel.selectedBrand = item
        } label: {
            HStack(spacing: 15) {
                
                Image(item.imageName)
                    .resizable()
                    .frame(width: 55, height: 55)
                    .background(Colors.Secondary.background)
                    .foregroundColor(Colors.Primary.foreground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                    
                    Text(item.subtitle)
                        .foregroundColor(Colors.Tertiary.foreground)
                        .font(.caption)
                }
                
                Spacer()
            }
            .background(Colors.Primary.background)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
        .overlay(
            Divider(),
            alignment: .bottom
        )
    }
}
