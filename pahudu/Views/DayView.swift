//
//  DayView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/10/24.
//

import SwiftUI

struct DayView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @EnvironmentObject var eventModel: EventModel
    @Environment(\.presentationMode) var presentationMode
    
    //@State private var events: [pahudu.Event] = []
    
    var body: some View {
        
        let item = globalData.selectedCalendarItem
        
        eventList
//            .navigationBarTitle(globalData.selectedCalendarItem?.dateItem != nil ? "\(item.dateItem!.monthString) \(item.dateItem!.day), \(item.dateItem!.year)" : "", displayMode: .inline)
            .onAppear {
//                if let item = item?.dateItem {
//                    events = eventModel.eventsForDate(item.date)
//                }
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
        .scrollContentBackground(.hidden)
        .background(Colors.Primary.background)
    }
    
    private func itemListView(hour: Int) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                Text(getHourString(hour))
                    .font(.numberSmall)
                    .kerning(0.5)
                    .lineSpacing(0)
                    .foregroundColor(Colors.Tertiary.foreground)
                    .frame(minWidth: 50, maxWidth: 50, maxHeight: .infinity, alignment: .trailing)
                //                    .overlay(
                //                        Rectangle()
                //                            .frame(width: 0.5)
                //                            .foregroundColor(Colors.Primary.divider),
                //                        alignment: .trailing
                //                    )
                
//                ForEach(events.flatMap { $0.shows }.filter { $0.hour == hour }, id: \.id) { show in
//                    if let event = events.first(where: { $0.shows.contains(where: { $0.id == show.id }) }) {
//                        showView(show: show, event: event)
//                    }
//                }
                .padding(EdgeInsets(top: 0.5, leading: 0, bottom: 0.5, trailing: 0))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .overlay(
            Divider(),
            alignment: .bottom
        )
        .background(Colors.Primary.background)
        
        
    }
    
    
//    private func showView(show: pahudu.Show, event: pahudu.Event) -> some View {
//        VStack(alignment: .leading, spacing: 5) {
//            
////            Text(show.brand.name)
////                .font(.callout)
////                .foregroundColor(Colors.Primary.foreground)
//            
//            Text("\(event.name) (\(event.acronym))")
//                .font(.callout)
//                .foregroundColor(Colors.Primary.foreground.opacity(0.5))
//            //            if let url = show.ticketLink {
//            //                Button(action: {
//            //                    if let url = URL(string: url.description) {
//            //                        UIApplication.shared.open(url)
//            //                    }
//            //                }) {
//            //                    Text("Get Tickets")
//            //                        .font(.callout)
//            //                        .foregroundColor(Colors.Primary.foreground)
//            //                        .padding(EdgeInsets(top: 7, leading: 20, bottom: 7, trailing: 20))
//            //                        .background(Colors.Primary.blue)
//            //                        .cornerRadius(25)
//            //                }
//            //            }
//        }
//        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
//        .frame(maxWidth: .infinity, alignment: .leading)
////        .background(
////            RoundedRectangle(cornerRadius: 7)
////                .fill(colorForAcronym(event.acronym).opacity(0.3))
////            //.stroke(colorForAcronym(event.acronym), style: StrokeStyle(lineWidth: 0.5, lineCap: .square))
////        )
//        
//        
//    }
    
    func getHourString(_ hour: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
        return formatter.string(from: date)
    }
}
