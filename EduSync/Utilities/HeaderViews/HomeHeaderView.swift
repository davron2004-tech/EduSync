//
//  HeaderView.swift
//  EduSync
//
//  Created by Davron Abdukhakimov on 19/01/24.
//

import SwiftUI
import SwiftData

struct HomeHeaderView: View {
    
    @Query var lessons:[LessonDataModel]
    @Query var reminders:[ReminderDataModel]
    
    var body: some View {
        VStack(alignment:.leading){
                HStack{
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 70))
                        .padding(.trailing)
                    VStack(alignment:.leading){
                        Text("Welcome")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding(.bottom)
                HStack{
                    VStack{
                        Text("Lessons")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("\(lessons.filter{lesson in getCurrentWeekDay() == lesson.weekDay}.count)")
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
                        Text("\(reminders.count)")
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
                LinearGradient(colors: [Color("BrandFull"),Color("BrandHalf")], startPoint: .top, endPoint: .bottom)
            )
        
    }
}

#Preview {
    HomeHeaderView()
}
