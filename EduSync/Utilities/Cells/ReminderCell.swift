//
//  AssignmentCell.swift
//
//
//  Created by Davron Abdukhakimov on 01/01/24.
//

import SwiftUI

struct ReminderCell: View {
    
    @Environment(\.modelContext) var context
    @State var isShowingReminderForm = false
    
    var reminder:ReminderDataModel
    var isShowSubject:Bool
    var body: some View {
        VStack(alignment:.leading){
            
            Text(isShowSubject ? reminder.subject.name : reminder.title)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.trailing,30)
            
            Spacer()
            Text(isShowSubject ? reminder.title : reminder.notes)
                .lineLimit(1)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding(.bottom,3)
            HStack{
                Text(getInterval(deadline: reminder.deadline))
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                Spacer()
            }
            
        }
        .overlay(alignment: .topTrailing){
            if reminder.isCompleted{
                Image(systemName: "checkmark.circle")
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }
        .modifier(CustomCellModifier(width: 200, height: 150, color: reminder.color))
        .contextMenu{
            Section{
                Button{
                    reminder.isCompleted.toggle()
                }label: {
                    if reminder.isCompleted{
                        Label("Completed", systemImage: "checkmark")
                    }
                    else{
                        Text("Completed")
                    }
                }
                Button{
                    isShowingReminderForm = true
                }label: {
                    Label("Edit", systemImage: "square.and.pencil")
                }
            }
            
            Section {
                
                Button(role:.destructive){
                    context.delete(reminder)
                }label: {
                    Label("Delete", systemImage: "trash")
                        .foregroundStyle(.red)
                }
            }
            .onAppear{
                MenuTip.sharedTip.invalidate(reason: .actionPerformed)
            }
            
        }
        .sheet(isPresented: $isShowingReminderForm) {
            ReminderFormView(
                reminder: reminder,
                subject: reminder.subject, 
                isShowingForm: $isShowingReminderForm,
                isCreating: false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ReminderCell(
        reminder: ReminderDataModel(
            title: "Assignment-1",
            notes: "Exervise -5",
            color: "Green", 
            images: [],
            deadline: Date(),
            remindDate: getRemindDate(day: "1", deadline: Date()), 
            remindDay: "1",
            subject: SubjectDataModel(
                name: "Academic English",
                color: "Name",
                professorName: "house",
                subjectIcon: "Green"
                
            )
        ), 
        isShowSubject: true
    )
}
