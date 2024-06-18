//
//  DesignersView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI


struct DesignersView: View {
    
    @ObservedObject var eventModel: EventModel = EventModel()
    @State private var showDetails: Bool = false
    @State private var searchText = ""
    @State private var showGridView = false
    
    var body: some View {
        NavigationStack {
            Group {
                if showGridView {
                    DesignersGridView(eventModel: eventModel, showDetails: $showDetails)
                } else {
                    DesignersListView(eventModel: eventModel, showDetails: $showDetails)
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
            if let designer = eventModel.selectedDesigner {
                DesignerDetailsView(item: designer)
            }
        }
        
    }
    
}




struct DesignersListView: View {
    
    @State var designers: [Designer] = []
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    let width: CGFloat = 60
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(designers) { item in
                    Button {
                        showDetails = true
                        eventModel.selectedDesigner = item
                    } label: {
                        HStack(spacing: 15) {
                            
                            Image(item.name)
                                .resizable()
                                .frame(width: width, height: width)
                                .background(Colors.Secondary.background)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Colors.Secondary.background, lineWidth: 1)
                                }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.name)
                                    .foregroundColor(Colors.Primary.foreground)
                                    .font(.button)
                                
                                Text("\(item.nationality) \(item.title)")
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
        .onAppear {
            fetchDesigners { designers in
                self.designers = designers
            }
        }
    }
}





struct DesignersGridView: View {
    
    @State var designers: [Designer] = []
    
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
                ForEach(designers) { item in
                    Button {
                        showDetails = true
                        eventModel.selectedDesigner = item
                    } label: {
                        VStack(alignment: .center, spacing: 7) {
                            
                            Image(item.name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Colors.Secondary.background)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Colors.Secondary.background, lineWidth: 1)
                                }
                            
                            Text(item.name.components(separatedBy: " ").first ?? "")
                                .foregroundColor(Colors.Primary.foreground)
                                .font(.caption)
                        }
                    }
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .background(Colors.Primary.background)
        .onAppear {
            fetchDesigners { designers in
                self.designers = designers
            }
        }
    }
}


