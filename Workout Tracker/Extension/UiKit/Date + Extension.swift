//
//  Date + Extension.swift
//  Workout Tracker
//
//  Created by SNZ on 08.11.2022.
//

import Foundation

extension Date {
    //метод, который корректирует время под наш часовой пояс
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) ?? Date()
        return localDate
    }

        //Получаем дату, влево и последующие даты ...<-18<-19<-20, так же дни недели по 2 буквы пн,вт...
    func getWeekArray() -> [[String]] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "EEEEEE"

        var weekArray : [[String]] = [[], []]
        let calendar = Calendar.current
//        calendar.timeZone = TimeZone(abbreviation: "UTC") ?? .current

        for index in -6...0 {
            let date = calendar.date(byAdding: .day, value: index, to: self) ?? Date()
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            let weekday = formatter.string(from: date)
            weekArray[0].append(weekday)
        }
        return weekArray
    }

    //получаем дату начала тренировки и ее конца
    func startEndDate() -> (Date, Date) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"

        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let dateStart = formatter.date(from: "\(year)/\(month)/\(day)") ?? Date()

        let local = dateStart.localDate()
        let dateEnd: Date = {
            let components = DateComponents(day: 1)
            return calendar.date(byAdding: components, to: local) ?? Date()
        }()
        return (local, dateEnd)
    }

    func getWeekdayNumber() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekday
    }

    //При тапе на ичеку мы должны получить дату с отступом
    public func offsetDays(days: Int) -> Date {
        let offsetDays = Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
        return offsetDays
    }

    public func offsetMonth(month: Int) -> Date {
        let offsetDays = Calendar.current.date(byAdding: .month, value: -month, to: self) ?? Date()
        return offsetDays
    }
}
