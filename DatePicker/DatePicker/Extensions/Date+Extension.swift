//
//  Date+Extension.swift
//  DatePicker
//
//  Created by Yogesh Bharate on 9/3/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.
//

import Foundation

extension Date {
  func toString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    formatter.locale = Locale(identifier: "en_US")
    formatter.timeZone = TimeZone.current
    return formatter.string(from: self)
  }
  
  var yesterday: Date {
    return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
  }
  
  var noon: Date {
    return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
  }
  
  var tomorrow: Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
  }
}
