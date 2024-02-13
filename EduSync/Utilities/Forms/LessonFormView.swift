//
//  SwiftUIView.swift
//
//
//  Created by Davron Abdukhakimov on 05/01/24.
//

import SwiftUI
import SwiftData

struct LessonFormView: View {
    
    @Environment(\.modelContext) var context
    @Query var subjects:[SubjectDataModel]
    
    var lesson: LessonDataModel?
    
    @State var subjectName = ""
    @State var location = ""
    @State var lessonType = "Lecture"
    
    @State var weekDay = "Monday"
    @State var startTime = Date()
    @State var endTime = Date()
    
    @Binding var isShowingForm:Bool
    @State var isShowingSubjectForm = false
    var isCreating:Bool
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Lesson details"){
                    Picker("Select The Subject", selection: $subjectName) {
                        if subjects.isEmpty{
                            Text("No subject")
                        }
                        else{
                            ForEach(subjects,id:\.self){subject in
                                Text(subject.name)
                                    .tag(subject.name)
                            }
                        }
                        
                    }
                    Button{
                        isShowingSubjectForm = true
                    }label: {
                        Label("Add subject", systemImage: "plus")
                    }
                    Picker("Lesson Type",selection: $lessonType){
                        Text("Lecture")
                            .tag("Lecture")
                        Text("Practice")
                            .tag("Practice")
                    }
                    TextField("Location", text: $location,axis: .vertical)
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                }
                Section{
                    Picker("Week Day", selection: $weekDay) {
                        Text("Monday")
                            .tag("Monday")
                        Text("Tuesday")
                            .tag("Tuesday")
                        Text("Wednesday")
                            .tag("Wednesday")
                        Text("Thursday")
                            .tag("Thursday")
                        Text("Friday")
                            .tag("Friday")
                        Text("Saturday")
                            .tag("Saturday")
                    }
                    DatePicker("Starting Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("Ending Time", selection: $endTime, displayedComponents: .hourAndMinute)
                }
            }
            .padding(.vertical)
            .navigationTitle(isCreating ? "Add Lesson" : "Edit Lesson")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        if isCreating{
                            let newLesson = LessonDataModel(
                                location: location,
                                lessonType: lessonType,
                                startTime: startTime,
                                endTime: endTime,
                                weekDay: weekDay,
                                subject: subjects.first{subject in
                                    subject.name == subjectName
                                }!
                            )
                            context.insert(newLesson)
                        }
                        if !isCreating{
                            lesson!.subject = subjects.first{subject in
                                subject.name == subjectName
                            }!
                            lesson!.lessonType = lessonType
                            lesson!.location = location
                            
                            lesson!.weekDay = weekDay
                            lesson!.startTime = startTime
                            lesson!.endTime = endTime
                        }
                        isShowingForm = false
                    }label:{
                        Text(isCreating ? "Save" : "Done")
                    }
                    
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        isShowingForm = false
                    }label:{
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                    
                }
            }
        }
        .onChange(of: subjects){
            subjectName = subjects.first?.name ?? "No subject"
        }
        .sheet(isPresented: $isShowingSubjectForm){
            SubjectFormView(
                isShowingForm: $isShowingSubjectForm,
                isCreating: true
            )
            
        }
        .onAppear{
            subjectName = subjects.first?.name ?? "No Subject"
            location = lesson?.location ?? ""
            lessonType = lesson?.lessonType ?? "Lecture"
            
            startTime = lesson?.startTime ?? Date()
            endTime = lesson?.endTime ?? Date()
            weekDay = lesson?.weekDay ?? "Monday"
        }
    }
}

#Preview {
    LessonFormView(isShowingForm: .constant(true), isCreating: false)
}
