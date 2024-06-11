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
        
        HStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .frame(width: 55, height: 55)
                .background(Colors.Secondary.foreground)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Colors.Primary.divider, lineWidth: 0.5)
                )
            
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
        .overlay(
            Divider(),
            alignment: .bottom
        )
        .onTapGesture {
            showDetails = true
            eventModel.selectedDesigner = item
            UIApplication.triggerHapticFeedback()
        }
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
                    ForEach(GlobalData.designers) { item in
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

