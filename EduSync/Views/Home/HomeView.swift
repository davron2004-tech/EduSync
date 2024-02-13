//
//  .swift
//  UniSync
//
//  Created by Davron Abdukhakimov on 01/01/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) var context
    @Query(sort: \LessonDataModel.startTime) var lessons:[LessonDataModel]
    @Query(sort: \ReminderDataModel.deadline) var reminders:[ReminderDataModel]
    @State var selectedReminder = 0
    @State var selectedLesson = 0
    @State var isShowingDetailView = false
    @State var currentTime = Date()
    @State var lessonToShow:LessonDataModel?
    
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.vertical){
                    HomeHeaderView()
                    VStack{
                        HStack{
                            Text("Today's Lessons")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        if lessons.isEmpty{
                            ContentUnavailableView{
                                Label("No Lessons", systemImage: "square.stack.3d.up.slash.fill")
                            } description: {
                                Text("Add lessons on Timetable section")
                            }
                        }
                        else if lessons.filter({lesson in
                            return getCurrentWeekDay() == lesson.weekDay
                        }).isEmpty{
                            ContentUnavailableView{
                                Label("No Lessons", systemImage: "square.stack.3d.up.slash.fill")
                            } description: {
                                Text("No lessons for today")
                            }
                        }
                        else{
                            ScrollView(.horizontal) {
                                HStack(spacing:20){
                                    ForEach(lessons.filter{lesson in
                                        return getCurrentWeekDay() == lesson.weekDay
                                    },id:\.self){lesson in
                                        Button{
                                            lessonToShow = lesson
                                            isShowingDetailView = true
                                        }label: {
                                            LessonCell(lesson: lesson)
                                        }
                                        .scrollTransition { content, phase in
                                            content
                                                .opacity(phase.isIdentity ? 1.0 : 0.3)
                                                .scaleEffect(phase.isIdentity ? 1.0 : 0.5)
                                        }
                                        .popoverTip(MenuTip.sharedTip)
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            .disabled(isShowingDetailView)
                        }
                        Divider()
                            .padding(.vertical)
                        HStack{
                            Text("Assignments")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        if reminders.isEmpty{
                            ContentUnavailableView{
                                Label("No Assignments", systemImage: "tag.slash")
                            } description: {
                                Text("Add assignments on Subjects section")
                            }
                        }
                        
                        else{
                            ScrollView(.horizontal) {
                                HStack(spacing: 20){
                                    ForEach(reminders,id:\.self){reminder in
                                        NavigationLink{
                                            DetailView(
                                                reminder: reminder
                                            )
                                        }label: {
                                            ReminderCell(reminder: reminder, isShowSubject: true)
                                        }
                                        .scrollTransition { content, phase in
                                            content
                                                .opacity(phase.isIdentity ? 1.0 : 0.3)
                                                .scaleEffect(phase.isIdentity ? 1.0 : 0.5)
                                        }
                                        .popoverTip(MenuTip.sharedTip)
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            .disabled(isShowingDetailView)
                        }
                    }
                    .padding()
                }
                .blur(radius: isShowingDetailView ? 20 : 0)
                if isShowingDetailView{
                    LessonDetailView(
                        lesson: lessonToShow!,
                        isShowingView: $isShowingDetailView
                    )
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
    func getTitle() -> String {
        let closeReminders = reminders.filter{reminder in
            reminder.deadline > Date() && Date() > reminder.remindDate
        }
        return "\(closeReminders.count) assignments to finish."
    }
    func getBody() -> String{
        let closeReminders = reminders.filter{reminder in
            reminder.deadline > Date() && Date() > reminder.remindDate
        }
        var text = ""
        for reminder in closeReminders {
            text += "\(reminder.subject.name): \(reminder.title)\n"
        }
        return text
    }
}

#Preview {
    HomeView()
}
