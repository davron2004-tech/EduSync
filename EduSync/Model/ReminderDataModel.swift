//
//  ReminderDataModel.swift
//  
//
//  Created by Davron Abdukhakimov on 02/01/24.
//

import Foundation
import SwiftData


@Model
final class ReminderDataModel{
    
    
    
    var title:String
    var notes:String
    var color:String
    var images:[Data] = []
    
    var deadline:Date
    var remindDate:Date
    var remindDay:String
    var subject:SubjectDataModel
    var isCompleted = false
    
    init(title: String, notes: String, color: String,images:[Data], deadline: Date,remindDate: Date,remindDay: String,subject:SubjectDataModel) {
        
        self.title = title
        self.notes = notes
        self.color = color
        self.images = images
        self.deadline = deadline
        self.remindDate = remindDate
        self.remindDay = remindDay
        self.subject = subject
    }
    
}
