//
//  Split.swift
//  TwitSplit
//
//  Created by Fahad Iqbal on 11/29/18.
//  Copyright © 2018 innoverzgen. All rights reserved.
//

import Foundation
import UIKit
class Utils {
    
    //Another method for splitting string
    static func splitMessage(message: String, limit: Int) -> [String] {
        let input = message.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let regex = try! NSRegularExpression(pattern: "(.{1,\(limit-4)})(\\s+|$|\n+)")
        var results = [String]()
        let range = NSRange(input.startIndex..., in: message)
        let split = regex.matches(in: input, options: .anchored, range: range)
        if  split.count == 0 && !input.isEmpty
        {
            return [String]();
        }
        else if  split.count == 1
        {
            results.append(input)
            return results;
        }
        var index = 0;
        for match in regex.matches(in: input, options: .anchored, range: range) {
            index = index + 1
            let range = Range(match.range(at: 1), in: message)!
            results.append("\(index)/\(split.count) " + message[range])
        }
        return  results
    }
    
    //Function to check split
    static func checkToSplit(message: String) -> Bool {
        return message.count > kMaxlength
    }
    
    //Function to make split
    static func splitMessage(message: String,vc:UIViewController) -> [String] {
        var result = [String]()
        
        var partId = 1
        let partCount = message.count / kMaxlength + 1
        
        if (Utils.checkWordLength(message: message)) { // Check invalid words
            Utils.extractWords(message: message, partId: &partId, partCount: partCount, result: &result)
            
        } else {
            Utils.showError(message: "Message contains word with over \(kMaxlength) characters",viewController:vc)
        }
        print("result", result)
        
        return result
    }
    
    //MARK:-- Check words length
    static func checkWordLength(message: String) -> Bool {
        let words = message.components(separatedBy: " ")
        
        for word in words {
            if (word.count > kMaxlength) {
                return false
            }
        }
        
        return true
    }
    
    // Loop through message to extract words by length
    static func extractWords(message: String, partId: inout Int, partCount: Int, result: inout [String]) {
        var id = 1
        
        var words = message.components(separatedBy: " ")
        
        if (message.count <= kMaxlength - kPartIndicatorLength) {
            let newMessage = "\(partId)/\(partCount) \(message)"
            result.append(newMessage)
        } else {
            
            while (id < words.count) {
                id += 1
                
                let splitMessage = words[0..<id].joined(separator: " ")
                
                if (splitMessage.count > kMaxlength - kPartIndicatorLength) {
                    let prevId = id - 1
                    let m = "\(partId)/\(partCount) \(words[0..<prevId].joined(separator: " "))"
                    result.append(m)
                    words = Array(words[prevId...])
                    
                    partId += 1
                    break
                }
                
            }
            let nextStr = words.joined(separator: " ")
            extractWords(message: nextStr, partId: &partId, partCount: partCount, result: &result)
        }
        
    }
    
    
    
   static func showError(message: String, viewController:UIViewController) -> Void {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}


