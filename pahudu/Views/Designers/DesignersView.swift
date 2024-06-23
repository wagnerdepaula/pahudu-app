//
//  DesignersView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct DesignersView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @StateObject var eventModel: EventModel = EventModel()
    
    @State private var searchText = ""
    @State private var showDetails: Bool = false
    @State private var showGridView = false
    @State private var itemOpacity: Double = 0.0
    
    
    var body: some View {
        
        NavigationStack {
            
            Group {
                if showGridView {
                    DesignersGridView(eventModel: eventModel, showDetails: $showDetails, designers: $globalData.designers, searchText: $searchText)
                } else {
                    DesignersListView(eventModel: eventModel, showDetails: $showDetails, designers: $globalData.designers, searchText: $searchText)
                }
            }
            .opacity(itemOpacity)
            .onAppear {
                withAnimation(.easeOut(duration: 0.3)) {
                    itemOpacity = 1.0
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
            if let designer = eventModel.selectedDesigner {
                DesignerDetailsView(designer: designer)
            }
        }
    }
}



struct DesignersListView: View {
    
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var designers: [Designer]
    @Binding var searchText: String
    let width: CGFloat = 70
    
  
    var filteredDesigners: [Designer] {
        if searchText.isEmpty {
            return designers
        } else {
            return designers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(filteredDesigners) { designer in
                    Button {
                        showDetails = true
                        eventModel.selectedDesigner = designer
                    } label: {
                        HStack(spacing: 10) {
                            AsyncCachedImage(url: URL(string: "https://storage.googleapis.com/pahudu.com/designers/sm/\(designer.name).png")!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Colors.Secondary.background
                            }
                            .frame(width: width, height: width)
                            .background(Colors.Secondary.background)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Colors.Primary.background, lineWidth: 1)
                            }
                            
                            Text(designer.name)
                                .foregroundColor(Colors.Primary.foreground)
                                .font(.body)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            
                            Spacer()
                        }
                        .background(Colors.Primary.background)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    }
                    .id(designer.id)
                    
                }
            }
            .drawingGroup()
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
                        eventModel.selectedDesigner = designer
                    } label: {
                        VStack(alignment: .center, spacing: 5) {
                            
                            GeometryReader { geometry in
                                
                                AsyncCachedImage(url: URL(string: "https://storage.googleapis.com/pahudu.com/designers/sm/\(designer.name).png")!) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                } placeholder: {
                                    Colors.Secondary.background
                                }
                                .frame(width: geometry.size.width, height: geometry.size.width)
                                .background(Colors.Secondary.background)
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
            .drawingGroup()
            
        }
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}

