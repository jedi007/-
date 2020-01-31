//
//  dateTools.swift
//  都信
//
//  Created by 李杰 on 2020/1/30.
//  Copyright © 2020 李杰. All rights reserved.
//

import Foundation

class DateTools
{
    static let shared = DateTools()
    
    private init() {
    }
    
    func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        //let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        //formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
        //return date.components(separatedBy: " ").first!
    }
    
    func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: string)
        return date!
    }
}
