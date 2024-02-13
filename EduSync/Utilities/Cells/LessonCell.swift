//
// LessonCell.swift
//
//
//  Created by Davron Abdukhakimov on 01/01/24.
//

import SwiftUI

struct LessonCell: View {
    
    @Environment(\.modelContext) var context
    @State var isShowingLessonForm = false
    
    var lesson:LessonDataModel
    
    var body: some View {
        VStack(alignment:.leading){
            //
            Text(lesson.subject.name)
                .lineLimit(2)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                
            
            //
            Spacer()
            Text("\(displayTime(time:lesson.startTime)) - \(displayTime(time:lesson.endTime))")
                .lineLimit(1)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding(.bottom,3)
            HStack{
                Text(lesson.location)
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                Spacer()
                Text(lesson.lessonType)
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                   
            }
            
        }
        .modifier(CustomCellModifier(width: 200, height: 150, color: lesson.subject.color))
        .contextMenu{
            
            Section{
                Button{
                    isShowingLessonForm = true
                }label: {
                    Label("Edit", systemImage: "square.and.pencil")
                }
            }
            
            Section{
                Button(role:.destructive){
                    context.delete(lesson)
                }label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            .onAppear{
                MenuTip.sharedTip.invalidate(reason: .actionPerformed)
            }
            
            
        }
        .sheet(isPresented: $isShowingLessonForm){
            LessonFormView(
                lesson: lesson,
                isShowingForm: $isShowingLessonForm, 
                isCreating: false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    LessonCell(
        lesson:
            LessonDataModel(
                location: "B200",
                lessonType: "Lecture",
                startTime: Date(), endTime: Date(), 
                weekDay: "Monday", 
                subject: SubjectDataModel(
                    name: "Math",
                    color: "Blue",
                    professorName: "Someone",
                    subjectIcon: "house"
                )
            
            )
    )
}
