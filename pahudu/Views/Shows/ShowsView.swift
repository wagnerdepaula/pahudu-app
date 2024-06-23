//
//  ShowsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct ShowsView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @ObservedObject var eventModel: EventModel = EventModel()
    
    @State private var searchText = ""
    @State private var showDetails: Bool = false
    @State private var showGridView = false
    @State private var itemOpacity: Double = 0.0
    
    var body: some View {
        NavigationStack {
            Group {
                if showGridView {
                    ShowsGridView(eventModel: eventModel, showDetails: $showDetails, shows: $globalData.shows, searchText: $searchText)
                } else {
                    ShowsListView(eventModel: eventModel, showDetails: $showDetails, shows: $globalData.shows, searchText: $searchText)
                }
            }
            .opacity(itemOpacity)
            .onAppear {
                withAnimation(.easeOut(duration: 0.3)) {
                    itemOpacity = 1.0
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
            if let show = eventModel.selectedShow {
                ShowDetailsView(show: show)
            }
        }
    }
}



struct ShowsListView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var shows: [Show]
    @Binding var searchText: String
    
    let width: CGFloat = 70
    
    var filteredShows: [Show] {
        if searchText.isEmpty {
            return shows
        } else {
            return shows.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(filteredShows) { show in
                    Button {
                        showDetails = true
                        eventModel.selectedShow = show
                    } label: {
                        HStack(spacing: 15) {
                            AsyncCachedImage(url: URL(string: "https://storage.googleapis.com/pahudu.com/shows/sm/\(show.name).png")!) { image in
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
                            
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(show.name)
                                    .foregroundColor(Colors.Primary.foreground)
                                    .font(.body)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                
                                Text(show.location)
                                    .foregroundColor(Colors.Tertiary.foreground)
                                    .font(.body)
                            }
                            
                            Spacer()
                        }
                        .background(Colors.Primary.background)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    }
                    .id(show.id)
                }
            }
            .drawingGroup()
        }
    }
}





struct ShowsGridView: View {
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var shows: [Show]
    @Binding var searchText: String
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .topLeading),
        GridItem(.flexible(), spacing: 15, alignment: .topLeading)
    ]
    
    var filteredShows: [Show] {
        if searchText.isEmpty {
            return shows
        } else {
            return shows.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(filteredShows) { show in
                    ShowGridItemView(show: show, eventModel: eventModel, showDetails: $showDetails)
                        .id(show.id)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .drawingGroup()
        }
        .background(Colors.Primary.background)
    }
}




struct ShowGridItemView: View {
    
    let show: Show
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    var body: some View {
        Button {
            showDetails = true
            eventModel.selectedShow = show
        } label: {
            VStack(spacing: 5) {
                AsyncCachedImage(url: URL(string: "https://storage.googleapis.com/pahudu.com/shows/sm/\(show.name).png")!) { image in
                    image
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Colors.Secondary.background
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Colors.Primary.foreground)
                .background(Colors.Secondary.background)
                
                Text(show.name)
                    .font(.callout)
                    .foregroundColor(Colors.Primary.foreground)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("Show: \(show.name)"))
    }
}
