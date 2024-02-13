//
//  SubjectDataModel.swift
//  
//
//  Created by Davron Abdukhakimov on 02/01/24.
//

import Foundation
import SwiftData

@Model
final class SubjectDataModel{
    
    var name:String
    var color:String
    var professorName:String
    var subjectIcon:String
    
    @Relationship(
        deleteRule:.cascade,
        inverse: \LessonDataModel.subject)
    var lessons:[LessonDataModel] = []
    
    @Relationship(
        deleteRule:.cascade,
        inverse: \ReminderDataModel.subject)
    var reminders:[ReminderDataModel] = []
    
    @Relationship(
        deleteRule:.cascade,
        inverse: \ResourceDataModel.subject)
    var resources:[ResourceDataModel] = []
    
    init(name: String, color: String, professorName: String, subjectIcon: String){
        self.name = name
        self.color = color
        self.professorName = professorName
        self.subjectIcon = subjectIcon
        
    }
    
}
