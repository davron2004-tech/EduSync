//
//  SwiftUIView.swift
//  
//
//  Created by Davron Abdukhakimov on 19/01/24.
//

import SwiftUI
import SwiftData

struct DashboardHeaderView: View {
    
    var subject:SubjectDataModel
    @Query var resources:[ResourceDataModel]
    @Query var reminders:[ReminderDataModel]
    
    var body: some View {
        VStack(alignment:.leading){
                HStack{
                    Image(systemName: subject.subjectIcon)
                        .font(.system(size: 60))
                        .padding(.trailing)
                    VStack(alignment:.leading){
                        Text(subject.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(subject.professorName)
                            .font(.title2)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                .padding(.bottom)
                HStack{
                    VStack{
                        Text("Resources")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("\(resources.filter({resource in resource.subject == subject}).count)")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                    .padding(.vertical)
                    .frame(width: 170)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack{
                        Text("Assignments")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("\(reminders.filter({reminder in reminder.subject == subject}).count)")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                    .padding(.vertical)
                    .frame(width: 170)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
            .foregroundStyle(.white)
            .background(
                LinearGradient(colors: [Color("\(subject.color)Full"),Color("\(subject.color)Half")], startPoint: .top, endPoint: .bottom)
            )
        
    }
}

#Preview {
    DashboardHeaderView(
        subject:SubjectDataModel(
            name: "Math",
            color: "Blue",
            professorName: "Someone",
            subjectIcon: "house"
        )
    )
}
