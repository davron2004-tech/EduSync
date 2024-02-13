//
//  File.swift
//  
//
//  Created by Davron Abdukhakimov on 22/01/24.
//

import Foundation
import TipKit

struct SwipeTip: Tip{
    static let sharedTip = SwipeTip()
    var title: Text {
        Text("Show Menu")
            .foregroundStyle(Color.accentColor)
    }
    var message: Text?{
        Text("Swipe to the left to see additional options")
    }
    var image: Image?{
        Image(systemName: "hand.draw.fill")
    }
    
    
}
                    
