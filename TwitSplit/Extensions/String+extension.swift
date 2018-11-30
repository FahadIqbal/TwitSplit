//
//  String+extension.swift
//  TwitSplit
//
//  Created by Fahad Iqbal on 11/29/18.
//  Copyright © 2018 innoverzgen. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm MM/dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = dateFormatter.date(from: self)
        
        return date ?? Date()
    }
    
    func toISODate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        
        return date ?? Date()
    }
    
    func toDate(_ format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //Your date format
        let date = dateFormatter.date(from: self)
        
        return date ?? Date()
    }
}
