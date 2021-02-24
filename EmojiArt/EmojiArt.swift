//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by punky on 2021/02/23.
//

import Foundation

struct EmojiArt: Codable {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable {
        let id: Int
        let text: String
        var x: Int
        var y: Int
        var size: Int
    
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
            
        }
        
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = newEmojiArt
        } else {
            return nil
        }
    }
    
    init() {}
    
    private var uniquEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        
        uniquEmojiId  += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniquEmojiId))
    }
}
