//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by punky on 2021/02/26.
//

import SwiftUI

struct PaletteChooser: View {
    @ObservedObject var document: EmojiArtDocument
    
    @Binding var chosenPalette: String
    @State private var showPalettedEditor = false
    
    
    var body: some View {
        HStack {
            Stepper(
                onIncrement: {
                    self.chosenPalette = self.document.palette(after: self.chosenPalette)
                },
                onDecrement: {
                    self.chosenPalette = self.document.palette(before: self.chosenPalette)
                },
                label: {
                    EmptyView()
                })
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
            Image(systemName: "keyboard").imageScale(.large)
                .onTapGesture {
                    self.showPalettedEditor = true
                }
                .sheet(isPresented: $showPalettedEditor, content: {
                    PaleteEditor(chosenPalette: self.$chosenPalette, isShowing: $showPalettedEditor)
                        .environmentObject(self.document)
                        .frame(minWidth: 300, minHeight: 500)
                })
//                .popover(isPresented: $showPalettedEditor, content: {
//                    PaleteEditor(chosenPalette: self.$chosenPalette)
//                        .environmentObject(self.document)
//                        .frame(minWidth: 300, minHeight: 500)
//                })
        }
        .fixedSize(horizontal: true, vertical: false)
        //        .onAppear {
        //            self.chosenPalette = self.document.defaultPalette
        //        }
    }
}

struct PaleteEditor: View {
    @EnvironmentObject var document: EmojiArtDocument
    
    @Binding var chosenPalette: String
    @Binding var isShowing: Bool
    @State private var paletteName: String = ""
    @State private var emojisToAdd: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Palette Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                    }, label: {
                        Text("Done")
                    }).padding()
                    
                }
            }
            
            Divider()
            Form {
                Section {
                    
                    TextField("Palette Name", text: $paletteName, onEditingChanged: { began in
                        if !began {
                            self.document.renamePalette(self.chosenPalette, to: self.paletteName)
                        }
                    })
                    .padding()
                }
                
                
                Section {
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                        if !began {
                            self.chosenPalette = self.document.addEmoji(self.emojisToAdd, toPalette: self.chosenPalette)
                            self.emojisToAdd = ""
                        }
                    })
                    .padding()
                }
                Section(header: Text("Remove Emoji")) {
                    Grid(chosenPalette.map { String($0)}, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.fontSize))
                            .onTapGesture {
                                self.chosenPalette = self.document.removeEmoji(emoji, fromPalette: self.chosenPalette)
                            }
                    }.frame(height: self.height)
                    
                }
                
            }
            
        }
        .onAppear{
            self.paletteName = self.document.paletteNames[self.chosenPalette] ?? ""
        }
        
                
    }
    
    //MARK: - Drawing Constants
    var height: CGFloat {
        CGFloat((chosenPalette.count - 1) / 6 ) * 70 + 70
    }
    
    let fontSize: CGFloat = 40

}
