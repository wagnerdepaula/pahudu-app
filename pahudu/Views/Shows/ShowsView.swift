//
//  ShowsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct ShowsView: View {
    
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
                    ShowsGridView(eventModel: eventModel, showDetails: $showDetails, shows: $globalData.shows, searchText: $searchText)
                case .list:
                    ShowsListView(eventModel: eventModel, showDetails: $showDetails, shows: $globalData.shows, searchText: $searchText)
                }
            }
            .opacity(itemOpacity)
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    itemOpacity = 1.0
                }
            }
            .navigationBarTitle("Shows", displayMode: .inline)
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
            if let show = eventModel.selectedShow {
                ShowDetailsView(show: show)
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


struct ShowsListView: View {
    
    @ObservedObject private var globalData = GlobalData()
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var shows: [Show]
    @Binding var searchText: String
    let width: CGFloat = 80
    
    let characters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var filteredShows: [Show] {
        if searchText.isEmpty {
            return shows
        } else {
            return shows.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var groupedShows: [String: [Show]] {
        Dictionary(grouping: filteredShows) { String($0.name.prefix(1).uppercased()) }
    }
    
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(characters, id: \.self) { character in
                            if let showsForLetter = groupedShows[character] {
                                Section(header: Text(character).id(character)
                                    .font(.callout)
                                    .foregroundStyle(Colors.Secondary.foreground)
                                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20))
                                ) {
                                    ForEach(showsForLetter, id: \.id) { show in
                                        ShowRow(show: show, eventModel: eventModel, showDetails: $showDetails, width: width)
                                            .id(show.id)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .refreshable {
                    async let showsTask = fetchShows()
                    let fetchedShows = await showsTask
                    shows = fetchedShows
                }
                
                
                VStack(spacing: 0) {
                    ForEach(characters, id: \.self) { character in
                        if (groupedShows[character] != nil) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    if groupedShows[character] != nil {
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




struct ShowRow: View {
    let show: Show
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    let width: CGFloat
    
    var body: some View {
        Button(action: {
            showDetails = true
            eventModel.selectShow(show: show)
        }) {
            HStack(spacing: 10) {
                AsyncCachedImage(url: URL(string: "\(Path.shows)/sm/\(show.imageName)")!) { image in
                    image
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Colors.Secondary.background
                }
                .overlay {
                    Rectangle()
                        .stroke(Colors.Secondary.divider, lineWidth: 1)
                }
                .frame(width: width, height: width)
                .foregroundColor(Colors.Primary.foreground)
                .background(Colors.Primary.background)
                .clipShape(
                    Rectangle()
                )
                
                Text(show.name)
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





struct ShowsGridView: View {
    
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var shows: [Show]
    @Binding var searchText: String
    
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var filteredShows: [Show] {
        searchText.isEmpty ? shows : shows.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(filteredShows) { show in
                    ShowCell(show: show, eventModel: eventModel, showDetails: $showDetails)
                        .id(show.id)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .drawingGroup()
        }
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
        .refreshable {
            async let showsTask = fetchShows()
            let fetchedShows = await showsTask
            shows = fetchedShows
        }
    }
}

struct ShowCell: View {
    let show: Show
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    var body: some View {
        Button {
            showDetails = true
            eventModel.selectShow(show: show)
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                ShowImage(imageName: show.imageName)
                    .aspectRatio(1, contentMode: .fit)
                Text(show.name)
                    .foregroundColor(Colors.Primary.foreground)
                    .font(.caption)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
}

struct ShowImage: View {
    let imageName: String
    var body: some View {
        GeometryReader { geometry in
            AsyncCachedImage(url: URL(string: "\(Path.shows)/sm/\(imageName)")) { image in
                image
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Colors.Secondary.background
            }
            .overlay {
                Rectangle()
                    .stroke(Colors.Secondary.divider, lineWidth: 1)
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
            .foregroundColor(Colors.Primary.foreground)
            .background(Colors.Primary.background)
            .clipShape(
                Rectangle()
            )
        }
    }
}
