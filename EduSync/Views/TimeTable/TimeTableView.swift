//
//  .swift
//  UniSync
//
//  Created by Davron Abdukhakimov on 01/01/24.
//

import SwiftUI
import SwiftData
struct TimeTableView: View {
    
    @State var isShowingLessonForm = false
    @Query(sort: \LessonDataModel.startTime) var lessons:[LessonDataModel]
    @State var lessonToShow:LessonDataModel?
    @State var isShowingDetailView = false
    var days:[String]{
        
        var filteredDays:[String] = []
        for lessonToSort in lessons {
            if !filteredDays.contains(lessonToSort.weekDay){
                filteredDays.append(lessonToSort.weekDay)
            }
        }
        filteredDays.sort(by: { (weekDayNumbers[$0] ?? 7) < (weekDayNumbers[$1] ?? 7) })
        return filteredDays
    }
    
    var body: some View{
        NavigationStack{
            ZStack{
                if lessons.isEmpty{
                    ContentUnavailableView{
                        Label("No Lessons", systemImage: "square.stack.3d.up.slash.fill")
                    }actions: {
                        Button{
                            isShowingLessonForm = true
                        }label: {
                            Text("Add lesson")
                        }
                    }
                    .navigationTitle("Time Table")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing) {
                            Button{
                                isShowingLessonForm = true
                            }label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
                else{
                    ScrollView(.vertical){
                        VStack{
                            ForEach(days,id:\.self){day in
                                DayRow(
                                    day: day,
                                    lessons: lessons.filter{lesson in
                                        lesson.weekDay == day
                                    },
                                    isShowingView:$isShowingDetailView,
                                    lessonToShow: $lessonToShow
                                )
                                Divider()
                                    .padding(.vertical)
                            }
                        }
                        .padding()
                        
                    }
                    .disabled(isShowingDetailView)
                    .blur(radius: isShowingDetailView ? 20 : 0)
                    
                    .navigationTitle("Time Table")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing) {
                            Button{
                                isShowingLessonForm = true
                            }label: {
                                Image(systemName: "plus")
                            }
                        }

                    }
                }
                if isShowingDetailView {
                    LessonDetailView(
                        lesson: lessonToShow!,
                        isShowingView: $isShowingDetailView
                    )
                }
            }
        }
        .sheet(isPresented: $isShowingLessonForm){
            LessonFormView(
                isShowingForm: $isShowingLessonForm, 
                isCreating: true
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    TimeTableView()
}

struct DayRow: View {
    @Environment(\.horizontalSizeClass) var width
    var day:String
    var lessons:[LessonDataModel]
    @Binding var isShowingView:Bool
    @Binding var lessonToShow:LessonDataModel?
    
    var body: some View {
        HStack{
            Text(day)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
        }
        ScrollView(.horizontal) {
            HStack(spacing: 20){
                ForEach(lessons){ lesson in
                    Button{
                        lessonToShow = lesson
                        isShowingView = true
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
        
    }
}
