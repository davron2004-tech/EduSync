//
//  ResourceDataModel.swift
//  
//
//  Created by Davron Abdukhakimov on 02/01/24.
//

import Foundation
import SwiftData


@Model
final class ResourceDataModel{
    
    
    
    var title:String
    var notes:String
    var color:String
    var images:[Data]
    
    var subject:SubjectDataModel
    
    init(title: String, notes: String, color: String, images:[Data],subject:SubjectDataModel) {
       
        self.title = title
        self.notes = notes
        self.color = color
        self.images = images
        self.subject = subject
    }
    
}
