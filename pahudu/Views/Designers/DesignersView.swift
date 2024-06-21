//
//  DesignersView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/5/24.
//

import SwiftUI

struct DesignersView: View {
    
    
    @StateObject var eventModel: EventModel = EventModel()
    @State private var showDetails: Bool = false
    @State private var searchText = ""
    @State private var showGridView = false
    @State private var itemOpacity: Double = 0.0
    @State private var designers: [Designer] = []
    
    
    var body: some View {
        
        NavigationStack {
            
            Group {
                if showGridView {
                    DesignersGridView(eventModel: eventModel, showDetails: $showDetails, designers: $designers)
                } else {
                    DesignersListView(eventModel: eventModel, showDetails: $showDetails, designers: $designers)
                }
            }
            .opacity(itemOpacity)
            .task {
                designers = await fetchDesigners()
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
                DesignerDetailsView(item: designer)
            }
        }
    }
}



struct DesignersListView: View {
    
    @StateObject private var viewModel = DesignerViewModel()
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var designers: [Designer]
    let width: CGFloat = 60
    
    
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(
                    viewModel.designersWithImageURLs.indices, id: \.self
                ) { index in
                    Button {
                        showDetails = true
                        eventModel.selectedDesigner = viewModel.designersWithImageURLs[index].designer
                    } label: {
                        HStack(spacing: 15) {
                            
                            //URL(string: "https://storage.googleapis.com/pahudu.com/designers/\(item.name).png")!
                            
                            AsyncCachedImage(url: viewModel.designersWithImageURLs[index].imageURL) { image in
                                        image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: width, height: width)
                                    .background(Colors.Secondary.background)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .stroke(Colors.Primary.background, lineWidth: 1)
                                    }
                                    } placeholder: {
                                        ProgressView()
                                    }
                            
                            Text(viewModel.designersWithImageURLs[index].designer.name)
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
                    .drawingGroup()
                }
            }
        }
    }
    
    
}




struct DesignersGridView: View {
    
    @StateObject private var viewModel = DesignerViewModel()
    @StateObject var eventModel: EventModel
    @Binding var showDetails: Bool
    @Binding var designers: [Designer]
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top)
    ]
    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(
                    viewModel.designersWithImageURLs.indices, id: \.self
                ) { index in
                    Button {
                        showDetails = true
                        eventModel.selectedDesigner = viewModel.designersWithImageURLs[index].designer
                    } label: {
                        VStack(alignment: .center, spacing: 5) {
                            
                            GeometryReader { geometry in
                                
                                AsyncCachedImage(url: viewModel.designersWithImageURLs[index].imageURL) { image in
                                            image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width, height: geometry.size.width)
                                        .background(Colors.Secondary.background)
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle()
                                                .stroke(Colors.Primary.background, lineWidth: 1)
                                        }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                
                                
                    
                            }
                            .aspectRatio(1, contentMode: .fit)
                            
                            
                            Text(viewModel.designersWithImageURLs[index].designer.name.components(separatedBy: " ").first ?? "")
                                .foregroundColor(Colors.Primary.foreground)
                                .font(.caption)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    .drawingGroup()
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            
        }
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}

