//
//  .swift
//
//
//  Created by Davron Abdukhakimov on 02/01/24.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    
    
    
    var subject:SubjectDataModel
    
    @Query var resources: [ResourceDataModel]
    @Query(sort: \ReminderDataModel.deadline) var reminders: [ReminderDataModel]
    
    @State var isShowingResourcesForm = false
    @State var isShowingReminderForm = false
    
    @State var selectedReminder = 0
    @State var selectedResource = 0
    @State var isShowingSubjectForm = false
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                DashboardHeaderView(subject: subject)
                VStack{
                    HStack{
                        Text("Resources")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        
                    }
                    if resources.filter({resource in
                        resource.subject == subject
                    }).isEmpty{
                        ContentUnavailableView{
                            Label("No Resources", systemImage: "square.stack.3d.up.slash.fill")
                        }
                    }
                    else{
                        ScrollView(.horizontal) {
                            HStack(spacing: 20){
                                ForEach(resources.filter{resource in
                                    resource.subject == subject
                                }){resource in
                                    NavigationLink{
                                        DetailView(
                                            resource:resource
                                        )
                                    }label: {
                                        ResourceCell(
                                            resource: resource
                                        )
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
                        .padding(.bottom)
                        .scrollIndicators(.hidden)
                        
                    }
                    HStack{
                        Button{
                            isShowingResourcesForm = true
                        }label: {
                            Text("+ Add")
                                .fontWeight(.bold)
                                .font(.title3)
                            
                        }
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                    Divider()
                        .padding(.vertical)
                    HStack{
                        Text("Assignments")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        
                    }
                    if reminders.filter({reminder in
                        reminder.subject == subject
                    }).isEmpty{
                        ContentUnavailableView{
                            Label("No Assignments", systemImage: "tag.slash")
                        }
                    }
                    else{
                        ScrollView(.horizontal) {
                            HStack(spacing: 20){
                                ForEach(reminders.filter{reminder in
                                    reminder.subject == subject
                                })
                                {reminder in
                                    NavigationLink{
                                        DetailView(
                                            reminder:reminder
                                        )
                                    }label: {
                                        ReminderCell(reminder: reminder, isShowSubject: false)
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
                        .padding(.bottom)
                        .scrollIndicators(.hidden)
                        
                    }
                    HStack{
                        Button{
                            isShowingReminderForm = true
                        }label: {
                            Text("+ Add")
                                .fontWeight(.bold)
                                .font(.title3)
                            
                        }
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                }
                .padding()
            }
            .navigationTitle(subject.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        isShowingSubjectForm = true
                    }label: {
                        Image(systemName: "square.and.pencil")
                    }
                }

            }
            
        }
        .sheet(isPresented: $isShowingResourcesForm){
            ResourceFormView(
                subject: subject,
                isShowingForm: $isShowingResourcesForm,
                isCreating: true
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isShowingReminderForm){
            ReminderFormView(
                subject: subject,
                isShowingForm: $isShowingReminderForm,
                isCreating: true
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isShowingSubjectForm){
            SubjectFormView(
                subject: subject,
                isShowingForm: $isShowingSubjectForm,
                isCreating: false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}
#Preview {
    DashboardView(
        subject: SubjectDataModel(
            name: "Math",
            color: "Blue",
            professorName: "Someone",
            subjectIcon: "house"
        )
    )
}
