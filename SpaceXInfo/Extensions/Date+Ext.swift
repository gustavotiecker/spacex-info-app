//
//  Date+Ext.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 14/12/20.
//

import Foundation

extension Date {
    
    func convertToMonthDayYearTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy - h:mm a"
        return dateFormatter.string(from: self)
    }
}
