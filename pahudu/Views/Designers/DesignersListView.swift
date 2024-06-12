//
//  DesignersListView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct DesignerRowView: View {
    
    let item: DesignerItem
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    
    var body: some View {
        
        Button {
            showDetails = true
            eventModel.selectedDesigner = item
        } label: {
            HStack(spacing: 15) {
                
                Image(item.imageName)
                    .resizable()
                    .frame(width: 55, height: 55)
                    //.background(Colors.Secondary.foreground)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Tertiary.background]), startPoint: .top, endPoint: .bottom)
                    )
                    .clipShape(Circle())
                
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





struct DesignersListView: View {
    
    @ObservedObject var eventModel: EventModel = EventModel()
    @State var showDetails: Bool = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(DataModel.designers) { item in
                        DesignerRowView(item: item, eventModel: eventModel, showDetails: $showDetails)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationBarTitle("Designers", displayMode: .inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .background(Colors.Primary.background)
        }
        .navigationDestination(isPresented: $showDetails) {
            if let designer = eventModel.selectedDesigner {
                DesignerDetailsView(item: designer)
            }
        }
    }
}

