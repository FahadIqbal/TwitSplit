//
//  Utilities.swift
//  TwitSplit
//
//  Created by Fahad Iqbal on 11/29/18.
//  Copyright © 2018 technerds. All rights reserved.
//

import UIKit

let CHARACTER_LIMIT = 7
let text = "a b c d e f g h i j k"

class TweetComponent: CustomStringConvertible {
    var content: String
    let index: Int
    let maxPages: Int
    
    var prefix: String {
        return "\(index)/\(maxPages) "
    }
    var characterLimit: Int {
        return CHARACTER_LIMIT - prefix.characters.count
    }
    
    init(content: String, index: Int, maxPages: Int) {
        self.content = content
        self.index = index
        self.maxPages = maxPages
        if content.characters.count > characterLimit {
            print("ERROR \(content) too long, it needs to be \(characterLimit)")
        }
    }
    
    func append(str: String) -> Bool {
        let proposedSentence = "\(content) \(str)"
        if proposedSentence.characters.count <= characterLimit {
            content = proposedSentence
            return true
        }
        return false
    }
    
    public var description: String {
        return "\(prefix)\(content)"
    }
    
}

func split(inputStr: String, maxPages: Int=1) -> [TweetComponent] {
    var words = inputStr.components(separatedBy: .whitespacesAndNewlines)
    // Initialize the first component manually. We'll fix up maxPages later.
    var ret: [TweetComponent] = [TweetComponent.init(content: words.remove(at: 0), index: 1, maxPages: maxPages)]
    for word in words {
        let last = ret.last!
        // A try catch here would be nicer, perhaps.
        let success = last.append(str: word)
        if !success {
            ret.append(TweetComponent.init(content: word, index: ret.count + 1, maxPages: maxPages))
        }
    }
    if ret.count > maxPages {
        return split(inputStr: inputStr, maxPages: ret.count)
    }
    return ret
}
