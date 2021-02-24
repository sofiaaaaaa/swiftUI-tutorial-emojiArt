//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by punky on 2021/02/24.
//

import SwiftUI


struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: self.uiImage!)
            }
        }
    }
}
