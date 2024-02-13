//
//  SwiftUIView.swift
//
//
//  Created by Davron Abdukhakimov on 15/01/24.
//

import SwiftUI

struct LessonDetailView: View {
    var lesson:LessonDataModel
    @Binding var isShowingView:Bool
    var body: some View {
        VStack{
            HStack(spacing:40){
                VStack(alignment:.leading, spacing:20){
                    VStack(alignment:.leading,spacing: 5){
                        Text("Subject:")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(lesson.subject.name)
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    }
                    VStack(alignment:.leading,spacing: 5){
                        Text("Lesson Type")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(lesson.lessonType)
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    }
                    VStack(alignment:.leading,spacing: 5){
                        Text("Location")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(lesson.location)
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    }
                }
                VStack(alignment:.leading,spacing:20){
                    VStack(alignment:.leading,spacing: 5){
                        Text("Day")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(lesson.weekDay)
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    }
                    VStack(alignment:.leading,spacing: 5){
                        Text("Start Time")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(displayTime(time:lesson.startTime))
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    }
                    VStack(alignment:.leading,spacing: 5){
                        Text("End Time")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(displayTime(time:lesson.endTime))
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .frame(width: 350,height: 300)
        .background(Color(.systemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(radius: 50)
        .overlay(alignment: .topTrailing) {
            Button{
                isShowingView = false
            }label: {
                ZStack{
                    Circle()
                        .frame(width: 40)
                        .foregroundStyle(.gray)
                        .opacity(0.3)
                    Image(systemName: "xmark")
                        .frame(width: 44,height: 44)
                        .foregroundStyle(Color(UIColor.label))
                        .imageScale(.medium)
                    
                }
            }
            .padding(3)
        }
    }
}

#Preview {
    LessonDetailView(
        lesson:
            LessonDataModel(
                    location: "B200",
                    lessonType: "Lecture",
                    startTime: Date(), 
                    endTime: Date(),
                    weekDay: "Monday",
                    subject: SubjectDataModel(
                        name: "Math",
                        color: "Blue",
                        professorName: "Someone",
                        subjectIcon: "house"
                    )
                    
            ), 
        isShowingView: .constant(true)
    )
}
