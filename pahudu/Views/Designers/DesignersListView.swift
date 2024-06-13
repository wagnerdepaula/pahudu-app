//
//  DesignersListView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct DesignersListView: View {
    
    @ObservedObject var eventModel: EventModel = EventModel()
    @State private var showDetails: Bool = false
    @State private var searchText = ""
    @State private var showGridView = false
    
    var body: some View {
        NavigationStack {
            Group {
                if showGridView {
                    DesignerGridView(eventModel: eventModel, showDetails: $showDetails)
                } else {
                    DesignerListView(eventModel: eventModel, showDetails: $showDetails)
                }
            }
            .navigationBarTitle("Designers", displayMode: .inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .background(Colors.Primary.background)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            showGridView = true
                        }) {
                            Label("Grid", systemImage: "circle.grid.2x2")
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
            if let designer = eventModel.selectedDesigner {
                DesignerDetailsView(item: designer)
            }
        }
    }
}

struct DesignerListView: View {
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(DataModel.designers) { item in
                    DesignerRowView(item: item, eventModel: eventModel, showDetails: $showDetails)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}



struct DesignerGridView: View {
    
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
                ForEach(DataModel.designers) { item in
                    Button {
                        showDetails = true
                        eventModel.selectedDesigner = item
                    } label: {
                        VStack(alignment: .center, spacing: 10) {
                            
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Colors.Secondary.foreground)
                                .clipShape(Circle())
                            
                            Text(item.title.components(separatedBy: " ").first ?? "")
                                .foregroundColor(Colors.Primary.foreground)
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
                    .background(Colors.Secondary.foreground)
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
