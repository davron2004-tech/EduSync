//
//  SwiftUIView.swift
//  
//
//  Created by Davron Abdukhakimov on 11/01/24.
//

import SwiftUI
import SwiftData

struct StudyView: View {
    @Environment(\.modelContext) var context
    @Query var timers:[TimerDataModel]
    @State var isShowingTimerForm = false
    var body: some View {
        NavigationStack{
            if timers.isEmpty{
                ContentUnavailableView{
                    Label("No Timers", systemImage: "clock.fill")
                }actions: {
                    Button{
                        isShowingTimerForm = true
                    }label: {
                        Text("Add timer")
                    }
                }
                .navigationTitle("Study")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button{
                            isShowingTimerForm = true
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            else{
                List{
                    ForEach(timers,id:\.self){timer in
                        NavigationLink{
                            TimerView(timerObject: timer)
                        }label: {
                            ExtractedView(timer: timer)
                        }
                        .popoverTip(SwipeTip.sharedTip)
                        
                    }
                }
                .navigationTitle("Study")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button{
                            isShowingTimerForm = true
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            
            
            
        }
        .sheet(isPresented: $isShowingTimerForm){
            TimerFormView(
                focusTime: initialTime.addingTimeInterval(3600),
                isShowingForm: $isShowingTimerForm,
                isCreating: true
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        
        
    }
}

#Preview {
    StudyView()
}

struct ExtractedView: View {
    
    @Environment(\.modelContext) var context
    
    var timer:TimerDataModel
    @State var isShowingTimerForm = false
    
    var body: some View {
        VStack(alignment:.leading){
            Text(timer.title)
                .font(.title2)
                .fontWeight(.bold)
            Text(getTimerComponents(timer: timer.focusTime))
                .foregroundStyle(.secondary)
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                context.delete(timer)
            } label: {
                Image(systemName: "trash")
            }
            Button{
                isShowingTimerForm = true
            }label: {
                Image(systemName: "square.and.pencil")
            }
            .tint(Color.accentColor)
            .onAppear{
                SwipeTip.sharedTip.invalidate(reason: .actionPerformed)
            }
        }
        .sheet(isPresented: $isShowingTimerForm) {
            TimerFormView(
                timer: timer,
                focusTime: initialTime.addingTimeInterval(3600),
                isShowingForm: $isShowingTimerForm,
                isCreating: false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}
