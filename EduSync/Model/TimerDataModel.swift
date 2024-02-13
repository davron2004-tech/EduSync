//
//  File.swift
//  
//
//  Created by Davron Abdukhakimov on 11/01/24.
//

import Foundation
import SwiftData

@Model
final class TimerDataModel{
    var title:String
    var focusTime:Date
    var breakTime:Double
    var breakInterval:Double
    init(title: String, focusTime: Date, breakTime: Double, breakInterval: Double) {
        self.title = title
        self.focusTime = focusTime
        self.breakTime = breakTime
        self.breakInterval = breakInterval
    }
}
