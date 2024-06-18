//
//  ShowsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct ShowsView: View {
    
    @ObservedObject var eventModel: EventModel = EventModel()
    @State private var showDetails: Bool = false
    @State private var searchText = ""
    @State private var showGridView = false
    
    var body: some View {
        NavigationStack {
            Group {
                if showGridView {
                    ShowsGridView(eventModel: eventModel, showDetails: $showDetails)
                } else {
                    ShowsListView(eventModel: eventModel, showDetails: $showDetails)
                }
            }
            .navigationBarTitle("Shows", displayMode: .inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .background(Colors.Primary.background)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            showGridView = true
                            UIApplication.triggerHapticFeedback()
                        }) {
                            Label("Grid", systemImage: "square.grid.2x2")
                        }
                        Button(action: {
                            showGridView = false
                            UIApplication.triggerHapticFeedback()
                        }) {
                            Label("List", systemImage: "list.dash")
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
            if let show = eventModel.selectedShow {
                ShowDetailsView(item: show)
            }
        }
    }
}




struct ShowsListView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    let width: CGFloat = 100
    let height: CGFloat = 60
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(DataModel.shows) { item in
                    Button {
                        showDetails = true
                        eventModel.selectedShow = item
                    } label: {
                        HStack(spacing: 15) {
                            
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: width, height: height)
                                .background(Colors.Secondary.background)
                                .foregroundColor(Colors.Primary.foreground)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.title)
                                    .foregroundColor(Colors.Primary.foreground)
                                    .font(.button)
                                
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
        }
    }
}





struct ShowsGridView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    let height: CGFloat = 110
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .topLeading),
        GridItem(.flexible(), spacing: 15, alignment: .topLeading)
    ]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(DataModel.shows) { item in
                    Button {
                        showDetails = true
                        eventModel.selectedShow = item
                    } label: {
                        VStack(spacing: 7) {
                            
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: height)
                                .foregroundColor(Colors.Primary.foreground)
                                .background(Colors.Secondary.background)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 15)
                                )
                            
                            Text(item.title)
                                .font(.caption)
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .background(Colors.Primary.background)
    }
}

