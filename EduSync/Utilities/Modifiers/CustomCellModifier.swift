//
//  SwiftUIView.swift
//  
//
//  Created by Davron Abdukhakimov on 04/01/24.
//

import SwiftUI

struct CustomCellModifier: ViewModifier {
    var width:Double
    var height:Double
    var color:String
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: width,height: height)
            .background(
                LinearGradient(colors: [Color("\(color)Full"),Color("\(color)Half")], startPoint: .bottom, endPoint: .top)
                
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
    }
}


