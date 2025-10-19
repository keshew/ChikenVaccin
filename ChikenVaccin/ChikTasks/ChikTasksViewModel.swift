import SwiftUI

class ChikTasksViewModel: ObservableObject {
    @Published var currentDate = Date()

    var monthsToShow: [Date] {
        var months: [Date] = []
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        for i in 0..<3 {
            if let monthDate = calendar.date(byAdding: .month, value: i, to: startOfMonth) {
                months.append(monthDate)
            }
        }
        return months
    }

    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }

    func generateWeeks(for date: Date) -> [[Date?]] {
        let calendar = Calendar.current
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let firstWeekday = calendar.dateComponents([.weekday], from: monthInterval.start).weekday else {
            return []
        }

        var weeks: [[Date?]] = []
        var currentWeek: [Date?] = Array(repeating: nil, count: 7)
        var weekdayIndex = (firstWeekday + 6) % 7
        var currentDate = monthInterval.start
        let endDate = monthInterval.end

        while currentDate < endDate {
            currentWeek[weekdayIndex] = currentDate

            weekdayIndex += 1
            if weekdayIndex == 7 {
                weeks.append(currentWeek)
                currentWeek = Array(repeating: nil, count: 7)
                weekdayIndex = 0
            }

            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDate
        }

        if currentWeek.contains(where: { $0 != nil }) {
            weeks.append(currentWeek)
        }

        return weeks
    }

    func cellWidth(for totalWidth: CGFloat, spacing: CGFloat) -> CGFloat {
        let horizontalPadding = totalWidth * 0.1
        let totalSpacing = spacing * 6
        return (totalWidth - horizontalPadding - totalSpacing) / 7
    }
}
