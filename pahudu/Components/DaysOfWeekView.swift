//
//  DaysOfWeekView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/28/24.
//

import SwiftUI


struct DaysOfWeekView: View {
    
    @ObservedObject var viewModel: CalendarViewModel = CalendarViewModel()
    
    static let width = floor(UIScreen.main.bounds.width / 7) - 1
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(viewModel.daysOfWeek) { dayOfWeekItem in
                if case let .dayOfWeek(dayAbbreviation, _) = dayOfWeekItem {
                    Text(dayAbbreviation)
                        .callout()
                        .frame(width: DaysOfWeekView.width, height: DaysOfWeekView.width)
                        .background(Color.red)
                        //.fixedSize()
                }
            }
        }
    }
}
