//
//  DateUtil.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-15.
//

import Foundation

class DateUtil {
    static let shared = DateUtil()
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    private let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()

    private init() {}

    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}
