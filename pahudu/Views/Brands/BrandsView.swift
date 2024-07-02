//
//  BrandsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct BrandsView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @EnvironmentObject var eventModel: EventModel
    
    @State private var searchText = ""
    @State private var showDetails: Bool = false
    @State private var itemOpacity: Double = 0.0
    @State private var currentViewMode: ViewMode = .list
    
    var body: some View {
        
        NavigationStack {
            
            Group {
                switch currentViewMode {
                case .grid:
                    BrandsGridView(eventModel: eventModel, showDetails: $showDetails, brands: $globalData.brands, searchText: $searchText)
                case .list:
                    BrandsListView(eventModel: eventModel, showDetails: $showDetails, brands: $globalData.brands, searchText: $searchText)
                }
            }
            .opacity(itemOpacity)
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    itemOpacity = 1.0
                }
            }
            .navigationBarTitle("Brands", displayMode: .inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .background(Colors.Primary.background)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        cycleViewMode()
                        UIApplication.triggerHapticFeedback()
                    }) {
                        Image(systemName: currentViewMode.iconName)
                            .foregroundColor(Colors.Primary.accent)
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
    
    func cycleViewMode() {
        let allModes = ViewMode.allCases
        if let currentIndex = allModes.firstIndex(of: currentViewMode) {
            let nextIndex = (currentIndex + 1) % allModes.count
            currentViewMode = allModes[nextIndex]
        }
        
        
    }
}


struct BrandsListView: View {
    
    @ObservedObject private var globalData = GlobalData()
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var brands: [Brand]
    @Binding var searchText: String
    let width: CGFloat = 80
    
    let characters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var filteredBrands: [Brand] {
        if searchText.isEmpty {
            return brands
        } else {
            return brands.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var groupedBrands: [String: [Brand]] {
        Dictionary(grouping: filteredBrands) { String($0.name.prefix(1).uppercased()) }
    }
    
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(characters, id: \.self) { character in
                            if let brandsForLetter = groupedBrands[character] {
                                Section(header: Text(character).id(character)
                                    .font(.callout)
                                    .foregroundStyle(Colors.Secondary.foreground)
                                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20))
                                ) {
                                    ForEach(brandsForLetter, id: \.id) { brand in
                                        BrandRow(brand: brand, eventModel: eventModel, showDetails: $showDetails, width: width)
                                            .id(brand.id)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .refreshable {
                    async let brandsTask = fetchBrands()
                    let fetchedBrands = await brandsTask
                    brands = fetchedBrands
                }
                
                
                VStack(spacing: 0) {
                    ForEach(characters, id: \.self) { character in
                        if (groupedBrands[character] != nil) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    if groupedBrands[character] != nil {
                                        withAnimation(.easeInOut(duration: 1)) {
                                            scrollProxy.scrollTo(character, anchor: .top)
                                        }
                                        UIApplication.triggerHapticFeedback()
                                    }
                                }) {
                                    Text(character)
                                        .font(.footnote)
                                        .padding(.vertical, 2)
                                        .frame(width: 30)
                                        .background(Colors.Primary.background)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}




struct BrandRow: View {
    let brand: Brand
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    let width: CGFloat
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                showDetails = true
                eventModel.selectBrand(brand: brand)
            }) {
                HStack(spacing: 10) {
                    AsyncCachedImage(url: URL(string: "\(Path.brands)/sm/\(brand.imageName)")!) { image in
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
                        RoundedRectangle(cornerRadius: 15)
                    )
                    
                    Text(brand.name)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.subheadline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
                .background(Colors.Primary.background)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}





struct BrandsGridView: View {
    
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var brands: [Brand]
    @Binding var searchText: String
    
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var filteredBrands: [Brand] {
        searchText.isEmpty ? brands : brands.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(filteredBrands) { brand in
                    BrandCell(brand: brand, eventModel: eventModel, showDetails: $showDetails)
                        .id(brand.id)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .drawingGroup()
        }
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
        .refreshable {
            async let brandsTask = fetchBrands()
            let fetchedBrands = await brandsTask
            brands = fetchedBrands
        }
    }
}

struct BrandCell: View {
    let brand: Brand
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    var body: some View {
        Button {
            showDetails = true
            eventModel.selectBrand(brand: brand)
        } label: {
            VStack(alignment: .center, spacing: 5) {
                BrandImage(imageName: brand.imageName)
                    .aspectRatio(1, contentMode: .fit)
                Text(brand.name)
                    .foregroundColor(Colors.Primary.foreground)
                    .font(.caption)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
}

struct BrandImage: View {
    let imageName: String
    var body: some View {
        GeometryReader { geometry in
            AsyncCachedImage(url: URL(string: "\(Path.brands)/sm/\(imageName)")) { image in
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
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
        }
    }
}
