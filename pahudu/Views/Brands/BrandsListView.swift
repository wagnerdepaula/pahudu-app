//
//  BrandsListView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI


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




struct BrandsListView: View {
    
    @ObservedObject var eventModel: EventModel = EventModel()
    @State var showDetails: Bool = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(DataModel.brands) { item in
                        BrandRowView(item: item, eventModel: eventModel, showDetails: $showDetails)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationBarTitle("Brands", displayMode: .inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .background(Colors.Primary.background)
        }
        .navigationDestination(isPresented: $showDetails) {
            if let brand = eventModel.selectedBrand {
                BrandDetailsView(item: brand)
            }
        }
    }
}
