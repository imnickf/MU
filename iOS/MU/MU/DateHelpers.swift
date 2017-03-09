//
//  DateHelpers.swift
//  MU
//
//  Created by Nick Flege on 2/19/17.
//  Copyright © 2017 Nick Flege. All rights reserved.
//

import Foundation

/// Extension of Date to add String conversion to ISO8601 format
extension Date
{
  /// Formatter to format date in ISO8601 format
  static let iso8601Formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    return formatter
  }()

  /// Converts Date object to String in ISO9601 format
  var iso8601: String
  {
    return Date.iso8601Formatter.string(from: self)
  }
}

extension String
{
  /// Converts string object in ISO8601 format to Date object
  var dateFromISO8601: Date?
  {
    return Date.iso8601Formatter.date(from: self)
  }
}
