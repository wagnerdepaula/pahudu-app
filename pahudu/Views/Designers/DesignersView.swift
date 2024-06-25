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
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
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
                        ForEach(alphabet, id: \.self) { letter in
                            if let designersForLetter = groupedDesigners[letter] {
                                Section(header: Text(letter).id(letter)
                                    .font(.callout)
                                    .foregroundStyle(Colors.Secondary.foreground)
                                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10))
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
                
                
                VStack(spacing: 0) {
                    ForEach(alphabet, id: \.self) { letter in
                        if (groupedDesigners[letter] != nil) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    if groupedDesigners[letter] != nil {
                                        withAnimation(.easeInOut(duration: 1)) {
                                            scrollProxy.scrollTo(letter, anchor: .top)
                                        }
                                        UIApplication.triggerHapticFeedback()
                                    }
                                }) {
                                    Text(letter)
                                        .font(.footnote)
                                }
                                .padding(.vertical, 3)
                                .frame(width: 40)
                                .background(Colors.Primary.background)
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
                eventModel.selectedDesigner = designer
            }) {
                HStack(spacing: 10) {
                    AsyncCachedImage(url: URL(string: "\(Constants.path)/designers/sm/\(designer.imageName)")!) { image in
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
                        .font(.body)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
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
                        eventModel.selectedDesigner = designer
                    } label: {
                        VStack(alignment: .center, spacing: 5) {
                            
                            GeometryReader { geometry in
                                
                                AsyncCachedImage(url: URL(string: "\(Constants.path)/designers/sm/\(designer.imageName)")!) { image in
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
            .padding(.horizontal, 10)
            .drawingGroup()
            
        }
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}

