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
        let store = self.createStore()
        WindowGroup {
            EmojiArtDocumentChooser().environmentObject(store)
        }
    }
    
    func createStore() -> EmojiArtDocumentStore {
        let store = EmojiArtDocumentStore(named: "Emoji Art")
        store.addDocument()
        return store
    }
}
