//
//  LessonDataModel.swift
//
//
//  Created by Davron Abdukhakimov on 02/01/24.
//

import Foundation
import SwiftData


@Model
final class LessonDataModel{
    
    
    
    var location:String
    var lessonType:String
    
    
    var startTime:Date
    var endTime:Date
    var weekDay:String
    
    var subject:SubjectDataModel
    
    init(location: String, lessonType: String, startTime: Date, endTime: Date , weekDay: String,subject:SubjectDataModel) {
        
        
        
        self.location = location
        self.lessonType = lessonType
        self.startTime = startTime

        self.endTime = endTime
        self.weekDay = weekDay
        self.subject = subject
        
        
    }
    
}


