//
//  DayView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/10/24.
//

import SwiftUI

struct DayView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var eventModel = EventModel()
    @State var item: CalendarItem
    
    @State private var events: [pahudu.Event] = []
    
    var body: some View {
        eventList
            .navigationBarTitle(item.dateItem != nil ? "\(item.dateItem!.monthString) \(item.dateItem!.day), \(item.dateItem!.year)" : "", displayMode: .inline)
            .onAppear {
                if let item = item.dateItem {
                    events = eventModel.eventsForDate(item.date)
                }
            }
    }
    
    private var eventList: some View {
        List {
            ForEach(0..<24, id: \.self) { hour in
                itemListView(hour: hour)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .onTapGesture {
                UIApplication.triggerHapticFeedback()
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
    
    private func itemListView(hour: Int) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 15) {
                Text(getHourString(hour))
                    .font(.numberSmall)
                    .kerning(0.5)
                    .foregroundColor(Color.accentColor)
                    .frame(minWidth: 45, maxWidth: 45, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 15))
                    .overlay(
                        Rectangle()
                            .frame(width: 0.5)
                            .foregroundColor(Color("PrimaryDivider")),
                        alignment: .trailing
                    )

                ForEach(events.flatMap { $0.shows }.filter { $0.hour == hour }, id: \.id) { show in
                    if let event = events.first(where: { $0.shows.contains(where: { $0.id == show.id }) }) {
                        showView(show: show, event: event)
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color("PrimaryDivider")),
            alignment: .bottom
        )
    }

    
    private func showView(show: pahudu.Show, event: pahudu.Event) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack {
                Text(event.acronym)
                    .foregroundColor(colorForAcronym(event.acronym))
                    .font(.callout)
                Text(" \(event.name)")
                    .font(.callout)
            }
                
            Text(show.brand.name)
                .font(.callout)
                .foregroundColor(Color("SecondaryText"))
            if let url = show.ticketLink {
                Button(action: {
                    if let url = URL(string: url.description) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Get Tickets")
                        .font(.callout)
                        .foregroundColor(Color("PrimaryText"))
                        .padding(EdgeInsets(top: 7, leading: 15, bottom: 7, trailing: 15))
                        .background(Color("PrimaryBlue"))
                        .cornerRadius(25)
                }
            }
        }
    }
    
    func getHourString(_ hour: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
        return formatter.string(from: date)
    }
}
