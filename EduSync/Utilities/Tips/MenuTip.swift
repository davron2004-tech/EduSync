//
//  File.swift
//  
//
//  Created by Davron Abdukhakimov on 22/01/24.
//

import Foundation
import TipKit

struct MenuTip: Tip{
    static let sharedTip = MenuTip()
    var title: Text {
        Text("Show Menu")
            .foregroundStyle(Color.accentColor)
    }
    var message: Text?{
        Text("Press and hold to see additional options")
    }
    var image: Image?{
        Image(systemName: "hand.tap.fill")
    }
    
    
}
