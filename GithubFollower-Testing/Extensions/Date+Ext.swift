//
//  Date+Ext.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 30/10/20.
//

import Foundation


extension Date {
   
    //MARK: - Convert to MMM YYYY string
    func convertToMonthYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat    = "MMM d, yyyy"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .autoupdatingCurrent
        return dateFormatter.string(from: self)
    }
}

