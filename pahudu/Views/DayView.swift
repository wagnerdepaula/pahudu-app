//
//  DayView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/10/24.
//
import SwiftUI

struct DayView: View {
    
    @State var item: CalendarItem
    
    var body: some View {
        NavigationView {
            eventList
                .navigationBarTitle(item.dateItem != nil ? "\(item.dateItem!.monthString) \(item.dateItem!.day), \(item.dateItem!.year)" : "", displayMode: .large)
                .background(Color("BackgroundColor"))
                .onAppear {

                }
        }
    }
    
    private var eventList: some View {
        List {
            ForEach(0..<24, id: \.self) { hour in
                itemListView(hour: hour)
            }
            .background(Color("BackgroundColor"))
            .listRowBackground(Color("BackgroundColor"))
            .listRowSeparatorTint(Color("DividerColor"))
            .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .onTapGesture {
                UIApplication.triggerHapticFeedback()
            }
        }
        .background(Color("BackgroundColor"))
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
    
    private func itemListView(hour: Int) -> some View {
        VStack(alignment: .leading) {
            HStack {
                hourLabel(hour: hour)
                Spacer()
                //showDetails
            }
        }
    }
    
    private func hourLabel(hour: Int) -> some View {
        VStack(alignment: .center, spacing: 3) {
            Text(getHourString(hour))
                .caption()
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func getHourString(_ hour: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: Date(timeIntervalSince1970: Double(hour * 3600)))
    }
}
