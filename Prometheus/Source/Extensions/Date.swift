//
//  Date.swift
//  Prometheus
//
//  Created by Kristopher Jackson on 12/19/21.
//

import UIKit

extension Date {

    func getElapsedInterval() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self as Date, to: Date())

        if let year = interval.year, year > 0 {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: self as Date)

        } else if let month = interval.month, month > 0 {

            return "\(month)mo"

        } else if let day = interval.day, day > 0 {

            return day == 1 ? "Yesterday" :  "\(day)d"

        } else if let hour = interval.hour, hour > 0 {

                return "\(hour)h"

        } else if let minute = interval.minute, minute > 0 {

            return "\(minute)m"

        } else if let second = interval.second, second > 0 {

            return "Now"

        } else {

            return "Now"

        }

    }

}
