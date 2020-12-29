//
//  GFLogger.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 29/12/20.
//

import Foundation

internal enum LogEvent: String {
    case error = "❌" // Error
    case infor = "ℹ️" // Infor
    case debug = "💬" // Debug
    case verbose = "🔬" // Verbose
    case warning = "⚠️" // Warning
    case severity = "🔥" // Severe
}


class GFLogger {
    
    static private func print(_ object: Any) {
        #if DEBUG
        Swift.print(object)
        #endif
    }
    
    
    static private func extractSourceFile(filename: String) -> String {
        return String(filename.components(separatedBy: "/").last ?? "")
    }

    
    static func log(_ event     : LogEvent,
                    _ object    : Any,
                    _ filename  : String = #fileID,
                    _ line      : Int = #line,
                    _ column    : Int = #column,
                    _ function  : String = #function)
    {
        print("\(Date().convertToFullDate()) \(event.rawValue) [\(extractSourceFile(filename: filename))] [\(line) \(column)] \(function) -> \(object)\n")
    }
}
