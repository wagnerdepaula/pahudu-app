//
//  DesignersView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct DesignersView: View {
    
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
                    DesignersGridView(eventModel: eventModel, showDetails: $showDetails, designers: $globalData.designers, searchText: $searchText)
                case .condensedGrid:
                    DesignersCondesedGridView(eventModel: eventModel, showDetails: $showDetails, designers: $globalData.designers, searchText: $searchText)
                case .list:
                    DesignersListView(eventModel: eventModel, showDetails: $showDetails, designers: $globalData.designers, searchText: $searchText)
                }
            }
            .opacity(itemOpacity)
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    itemOpacity = 1.0
                }
            }
            .navigationBarTitle("Designers", displayMode: .inline)
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
            if let designer = eventModel.selectedDesigner {
                DesignerDetailsView(designer: designer)
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


enum ViewMode: CaseIterable {
    case grid, condensedGrid, list
    
    var iconName: String {
        switch self {
        case .grid: return "circle.grid.2x2.fill"
        case .condensedGrid: return "circle.grid.3x3.fill"
        case .list: return "rectangle.grid.1x2.fill"
        }
    }
}


struct DesignersListView: View {
    
    @ObservedObject private var globalData = GlobalData()
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var designers: [Designer]
    @Binding var searchText: String
    let width: CGFloat = 70
    
    let characters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var filteredDesigners: [Designer] {
        if searchText.isEmpty {
            return designers
        } else {
            return designers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var groupedDesigners: [String: [Designer]] {
        Dictionary(grouping: filteredDesigners) { String($0.name.prefix(1).uppercased()) }
    }
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(characters, id: \.self) { character in
                            if let designersForLetter = groupedDesigners[character] {
                                Section(header: Text(character).id(character)
                                    .font(.callout)
                                    .foregroundStyle(Colors.Secondary.foreground)
                                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20))
                                ) {
                                    ForEach(designersForLetter, id: \.id) { designer in
                                        DesignerRow(designer: designer, eventModel: eventModel, showDetails: $showDetails, width: width)
                                            .id(designer.id)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .refreshable {
                    async let designersTask = fetchDesigners()
                    let fetchedDesigners = await designersTask
                    designers = fetchedDesigners
                }
                
                
                VStack(spacing: 0) {
                    ForEach(characters, id: \.self) { character in
                        if (groupedDesigners[character] != nil) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    if groupedDesigners[character] != nil {
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




struct DesignerRow: View {
    let designer: Designer
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    let width: CGFloat
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                showDetails = true
                eventModel.selectDesigner(designer: designer)
            }) {
                HStack(spacing: 10) {
                    AsyncCachedImage(url: URL(string: "\(Path.designers)/sm/\(designer.imageName)")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Colors.Secondary.background
                    }
                    .frame(width: width, height: width)
                    .background(Colors.Secondary.foreground)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(Colors.Primary.background, lineWidth: 1)
                    }
                    
                    Text(designer.name)
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



struct DesignersGridView: View {
    
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var designers: [Designer]
    @Binding var searchText: String
    
    var filteredDesigners: [Designer] {
        if searchText.isEmpty {
            return designers
        } else {
            return designers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top)
    ]
    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(filteredDesigners) { designer in
                    Button {
                        showDetails = true
                        eventModel.selectDesigner(designer: designer)
                    } label: {
                        VStack(alignment: .center, spacing: 5) {
                            
                            GeometryReader { geometry in
                                
                                AsyncCachedImage(url: URL(string: "\(Path.designers)/sm/\(designer.imageName)")!) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                } placeholder: {
                                    Colors.Secondary.background
                                }
                                .frame(width: geometry.size.width, height: geometry.size.width)
                                .background(Colors.Secondary.foreground)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Colors.Primary.background, lineWidth: 1)
                                }
                                
                                
                            }
                            .aspectRatio(1, contentMode: .fit)
                            
                            Text(designer.name.components(separatedBy: " ").first ?? "")
                                .foregroundColor(Colors.Secondary.foreground)
                                .font(.caption)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    .id(designer.id)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            //.drawingGroup()
            
        }
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}




struct DesignersCondesedGridView: View {
    
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var designers: [Designer]
    @Binding var searchText: String
    
    var filteredDesigners: [Designer] {
        if searchText.isEmpty {
            return designers
        } else {
            return designers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top)
    ]
    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(filteredDesigners) { designer in
                    Button {
                        showDetails = true
                        eventModel.selectDesigner(designer: designer)
                    } label: {
                        VStack(alignment: .center, spacing: 5) {
                            
                            GeometryReader { geometry in
                                
                                AsyncCachedImage(url: URL(string: "\(Path.designers)/sm/\(designer.imageName)")!) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                } placeholder: {
                                    Colors.Secondary.background
                                }
                                .frame(width: geometry.size.width, height: geometry.size.width)
                                .background(Colors.Secondary.foreground)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Colors.Primary.background, lineWidth: 1)
                                }
                                
                                
                            }
                            .aspectRatio(1, contentMode: .fit)
                            
                            Text(designer.name.components(separatedBy: " ").first ?? "")
                                .foregroundColor(Colors.Secondary.foreground)
                                .font(.caption)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    .id(designer.id)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            //.drawingGroup()
            
        }
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}


