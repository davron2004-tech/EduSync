//
//  SwiftUIView.swift
//  
//
//  Created by Davron Abdukhakimov on 06/01/24.
//

import SwiftUI

struct ImageView: View {
    
    var imageData:Data
    var body: some View {
        GeometryReader{geo in
            Image(uiImage: UIImage(data: imageData)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width,height: geo.size.height)
        }
        
        
        
    }
}


