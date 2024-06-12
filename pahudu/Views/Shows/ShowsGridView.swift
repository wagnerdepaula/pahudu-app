//
//  ShowsGridView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct ShowGridItemView: View {
    
    let item: ShowItem
    
    @ObservedObject var eventModel: EventModel
    @Binding var showDetails: Bool
    
    var body: some View {
        
        
        Button {
            
            showDetails = true
            eventModel.selectedShow = item
            
        } label: {
            VStack(spacing: 10) {
                
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Colors.Primary.foreground)
                    .background(Colors.Secondary.background)
                    .clipShape(Rectangle())
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(item.title)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.caption)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(item.subtitle)
                        .foregroundColor(Colors.Tertiary.foreground)
                        .font(.caption)
                        .kerning(0.5)
                    
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
        }

        
        

    }
}




struct ShowsGridView: View {
    
    @ObservedObject var eventModel: EventModel = EventModel()
    @State var showDetails: Bool = false
    
    let columns = [
        GridItem(.flexible(), spacing: 15, alignment: .top),
        GridItem(.flexible(), spacing: 15, alignment: .top)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(DataModel.shows) { item in
                        ShowGridItemView(item: item, eventModel: eventModel, showDetails: $showDetails)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(20)
            }
            .navigationBarTitle("Shows", displayMode: .inline)
            .background(Colors.Primary.background)
            
        }
        .navigationDestination(isPresented: $showDetails) {
            if let show = eventModel.selectedShow {
                ShowDetailsView(item: show)
            }
        }
        
    }
}
