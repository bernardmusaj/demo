//
//  Log.swift
//  Demo
//
//  Created by Bernard Musaj on 9.4.21.
//

import Foundation

class Log {
    fileprivate init(){}
    
    static func debug(_ message: Any?...){
        #if DEBUG
        log("DEBUG", message: message)
        #endif
    }
    
    static func info(_ message: Any?...){
        log("INFO", message: message)
    }
    
    static func warning(_ message: Any?...){
        log("WARNING", message: message)
    }
    
    static func error(_ message: Any?...){
        log("ERROR", message: message)
    }
    
    fileprivate static func log(_ level: String, message: [Any?]){
        let time = timeFormatter.string(from: Date())
        let prefix = "\(time) [\(level)]"
        var args = message
        args.insert(prefix, at: 0)
        print(args.map({ (obj: Any?) -> Any in
            return obj == nil ? "null" : obj!
        }))
    }
    
    fileprivate static var timeFormatter: DateFormatter = Log.setupDateFormatter()
    fileprivate static func setupDateFormatter() -> DateFormatter {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.sss"
        return dateFormatter
    }
}
