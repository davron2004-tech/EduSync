//
//  File.swift
//  
//
//  Created by Davron Abdukhakimov on 04/01/24.
//

import SwiftUI

struct ColorPalette:Identifiable{
    let id = UUID()
    let colorName:String
    let color:Color
}

let colors:[ColorPalette] = [
    
    ColorPalette(colorName: "Blue", color: .blue),
    ColorPalette(colorName: "Red", color: .red),
    ColorPalette(colorName: "Green", color: .green),
    ColorPalette(colorName: "Yellow", color: .yellow),
    ColorPalette(colorName: "Orange", color: .orange),
    ColorPalette(colorName: "Mint", color: .mint),
    ColorPalette(colorName: "Indigo", color: .indigo),
    ColorPalette(colorName: "Teal", color: .teal),
    ColorPalette(colorName: "Brown", color: .brown),
    ColorPalette(colorName: "Cyan", color: .cyan),
    ColorPalette(colorName: "Pink", color: .pink),
    ColorPalette(colorName: "Purple", color: .purple),
    
]
