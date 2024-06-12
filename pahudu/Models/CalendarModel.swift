//
//  calendar.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/6/24.
//


import Foundation

class CalendarViewModel: ObservableObject {
    
    @Published var monthsData: [MonthData] = []
    @Published var title: String = "Initial Value"
    
    init() {
        monthsData = generateMonthsData()
    }
    
    private func generateMonthsData() -> [MonthData] {
        (0..<12).compactMap { monthIndex in
            MonthData(monthIndex: monthIndex, items: CalendarUtils.precomputeCalendarItems(for: monthIndex))
        }
    }
}



struct MonthData {
    
    let monthIndex: Int
    var items: [CalendarItem]
    
    private static var monthAbbreviations: [String] = {
        DateFormatter().standaloneMonthSymbols.map { $0 }
    }()
    
    var month: String {
        return MonthData.monthAbbreviations[monthIndex % 12]
    }
    
    var year: String {
        let currentYear = Calendar.current.component(.year, from: Date())
        return "\(currentYear)"
    }
}



struct DateItem: Identifiable {
    let date: Date
    let id: UUID = UUID()
    let day: Int
    let month: Int
    let monthString: String
    let year: String
    
    let isCurrentMonth: Bool
    let isToday: Bool
    let dayOfWeek: String
}


enum CalendarItem: Identifiable {
    
    case dayOfWeek(String, UUID)
    case date(DateItem)
    
    var id: UUID {
        switch self {
        case .dayOfWeek(_, let id):
            return id
        case .date(let dateItem):
            return dateItem.id
        }
    }
    
    var isDayOfWeek: Bool {
        switch self {
        case .dayOfWeek:
            return true
        case .date:
            return false
        }
    }
    
    var isDate: Bool {
        switch self {
        case .dayOfWeek:
            return false
        case .date:
            return true
        }
    }
    
    var dateItem: DateItem? {
        switch self {
        case .date(let dateItem):
            return dateItem
        case .dayOfWeek:
            return nil
        }
    }
    
    
}




class CalendarUtils {
    
    private static var calendar: Calendar { Calendar.current }
    
    static func precomputeCalendarItems(for monthIndex: Int) -> [CalendarItem] {
        let today = Date()
        let currentYear = calendar.component(.year, from: today)
        let components = DateComponents(year: currentYear, month: monthIndex + 1)
        
        guard let firstDayOfMonth = calendar.date(from: components),
              let daysInMonthRange = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return []
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E" // Day of week abbreviation, e.g., "M"
        
        let leadingDays = calculateLeadingDays(for: firstDayOfMonth)
        var items: [CalendarItem] = daysOfWeekItems()
        items += (0..<leadingDays).map { _ in .dayOfWeek("", UUID()) }
        
        let month = calendar.component(.month, from: firstDayOfMonth)
        let monthString = DateFormatter().monthSymbols[month - 1]
        let year = String(format: "%d", calendar.component(.year, from: firstDayOfMonth))
        
        items += (1...daysInMonthRange.count).map { day in
            let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
            let dayOfWeek = dateFormatter.string(from: date)
            return .date(DateItem(
                date: date,
                day: day,
                month: month,
                monthString: monthString,
                year: year,
                isCurrentMonth: true,
                isToday: calendar.isDateInToday(date),
                dayOfWeek: dayOfWeek))
        }
        return items
    }
    
    
    private static func calculateLeadingDays(for firstDayOfMonth: Date) -> Int {
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        return (firstWeekday - calendar.firstWeekday + 7) % 7
    }
    
    static func daysOfWeekItems() -> [CalendarItem] {
        let dayOfWeekAbbreviations = ["S", "M", "T", "W", "T", "F", "S"]
        return dayOfWeekAbbreviations.map { CalendarItem.dayOfWeek($0, UUID()) }
    }
}


extension CalendarViewModel {
    var daysOfWeek: [CalendarItem] {
        CalendarUtils.daysOfWeekItems()
    }
}
