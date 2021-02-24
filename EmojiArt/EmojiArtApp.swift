//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by punky on 2021/02/23.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
