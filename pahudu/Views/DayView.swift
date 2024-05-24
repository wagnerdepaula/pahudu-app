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
        NavigationView {
            eventList
                .navigationBarTitle(item.dateItem != nil ? "\(item.dateItem!.monthString) \(item.dateItem!.day), \(item.dateItem!.year)" : "", displayMode: .inline)
                .onAppear {
                    if let item = item.dateItem {
                        events = eventModel.eventsForDate(item.date)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            UIApplication.triggerHapticFeedback()
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 30, height: 30)
                                .font(.system(size: 10, weight: .bold))
                                .tint(Color("AccentColor"))
                                .background(Color("TertiaryColor"))
                                .clipShape(Circle())
                                .padding(.trailing, -8)
                        }
                    }
                }
        }
    }
    
    private var eventList: some View {
        List {
            ForEach(0..<24, id: \.self) { hour in
                itemListView(hour: hour)
            }
            .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .listRowSeparator(.hidden)
            .onTapGesture {
                UIApplication.triggerHapticFeedback()
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
    
    private func itemListView(hour: Int) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(getHourString(hour))
                    .numberSmall()
                    .foregroundColor(Color("QuaternaryColor"))
                ForEach(events.flatMap { $0.shows }.filter { $0.hour == hour }, id: \.id) { show in
                    if let event = events.first(where: { $0.shows.contains(where: { $0.id == show.id }) }) {
                        showView(show: show, event: event)
                    }
                }
            }
        }
    }
    
    //    private func hourLabel(hour: Int) -> some View {
    //        VStack(alignment: .center, spacing: 3) {
    //
    //        }
    //        .frame(maxWidth: .infinity, alignment: .leading)
    //    }
    
    private func showView(show: pahudu.Show, event: pahudu.Event) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(event.acronym) \(event.name)")
                .body()
            Text(show.brand.name)
                .body()
            if let url = show.ticketLink {
                Link("Get Tickets", destination: URL(string: url.description)!)
                    .foregroundColor(.blue)
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
