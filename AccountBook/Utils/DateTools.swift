//
//  DateTool.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/19.
//

import Foundation

func dateFormat(_ d: Date, format: String = "yyyy-MM-dd") -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    _ = dateFormatter.date(from: "\(d.timeIntervalSince1970)")
    return ""
}
