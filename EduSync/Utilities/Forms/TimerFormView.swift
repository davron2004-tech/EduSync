//
//  SwiftUIView.swift
//  
//
//  Created by Davron Abdukhakimov on 11/01/24.
//

import SwiftUI

struct TimerFormView: View {
    
    @Environment(\.modelContext) var context
    
    var timer:TimerDataModel?
    
    @State var title = ""
    @State var focusTime = Date()
    @State var breakTime = 1.0
    @State var breakInterval = "5"
    
    @Binding var isShowingForm:Bool
    var isCreating:Bool
    
    var body: some View {
        NavigationStack{
            
            Form{
                Section("Timer details"){
                    TextField("Title", text: $title,axis: .vertical)
                        .multilineTextAlignment(.leading)
                        .autocorrectionDisabled(true)
                }
                Section{
                    DatePicker("Focus Duration:",
                               selection: $focusTime,
                               in: initialTime...initialTime.addingTimeInterval(6 * 3600),
                               displayedComponents: .hourAndMinute)
                    VStack(alignment:.leading){
                        HStack{
                            Text("Break Duration:")
                            Text("\(breakTime,specifier: "%.0f") minutes")
                                .foregroundStyle(Color.accentColor)
                        }
                        Slider(value: $breakTime, in: 1...60,step: 1.0)
                    }
                    Picker("Take Break Every:", selection: $breakInterval) {
                        Text("5 minutes")
                            .tag("5")
                        Text("15 minutes")
                            .tag("15")
                        Text("30 minutes")
                            .tag("30")
                        Text("1 hour")
                            .tag("60")
                    }
                    
                }
            }
            .navigationTitle(isCreating ? "Add Timer" : "Edit Timer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        isShowingForm = false
                    }label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        if isCreating{
                            let newTimer = TimerDataModel(
                                title: title,
                                focusTime: focusTime,
                                breakTime: Double(breakTime),
                                breakInterval: Double(breakInterval) ?? 0.0
                            )
                            context.insert(newTimer)
                        }
                        if !isCreating{
                            timer!.title = title
                            timer!.focusTime = focusTime
                            timer!.breakTime = Double(breakTime)
                            timer!.breakInterval = Double(breakInterval) ?? 0.0
                        }
                        isShowingForm = false
                    }label: {
                        Text(isCreating ? "Save" : "Done")
                    }
                }
            }
            
            
        }
        .onAppear{
            if !isCreating{
                title = timer!.title
                focusTime = timer!.focusTime
                breakTime = timer!.breakTime
                breakInterval = String(Int(timer!.breakInterval))
            }
        }
        
        
        
    }
}

#Preview {
    TimerFormView(isShowingForm: .constant(true), isCreating: true)
}
