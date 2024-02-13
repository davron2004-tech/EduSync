//
//  .swift
//  
//
//  Created by Davron Abdukhakimov on 03/01/24.
//

import SwiftUI

struct SubjectFormView: View {
    
    @Environment(\.modelContext) var context
    
    var subject:SubjectDataModel?
    
    @State var name = ""
    @State var professorName = ""
    @State var subjectIcon = "paintpalette.fill"
    @State var color = "Blue"
    
    @Binding var isShowingForm:Bool
    var isCreating:Bool
    
    var body: some View {
        NavigationStack{
            Form{
                Section ("Subject details"){
                    TextField("Subject Name", text: $name,axis: .vertical)
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                    TextField("Teacher Name", text: $professorName,axis: .vertical)
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                }
                
                Section {
                    Picker("Subject Icon", selection: $subjectIcon) {
                        Label("Art", systemImage: "paintpalette.fill")
                            .tag("paintpalette.fill")
                        Label("Coding", systemImage: "apple.terminal.fill")
                            .tag("apple.terminal.fill")
                        Label("Math", systemImage: "x.squareroot")
                            .tag("x.squareroot")
                        Label("Economy", systemImage: "dollarsign.square.fill")
                            .tag("dollarsign.square.fill")
                        Label("Health", systemImage: "heart.fill")
                            .tag("heart.fill")
                        Label("Literature", systemImage: "book.fill")
                            .tag("book.fill")
                        Label("Biology", systemImage: "leaf.fill")
                            .tag("leaf.fill")
                        Label("Sport", systemImage: "soccerball")
                            .tag("soccerball")
                    }
                }
                Section("Subject Color") {
                    LazyVGrid(columns: colorColumns){
                        ForEach(colors){color in
                            VStack{
                                if self.color == color.colorName{
                                    Circle()
                                        .frame(width: 30)
                                        .foregroundStyle(color.color)
                                        .overlay(
                                            Circle()
                                                .stroke(Color(.label), lineWidth: 5)
                                        )
                                }
                                else{
                                    Circle()
                                        .frame(width: 30)
                                        .foregroundStyle(color.color)
                                }
                                Text(color.colorName)
                            }
                            .onTapGesture {
                                self.color = color.colorName
                            }
                        }
                    }
                }
                
            }
            .padding(.vertical)
            .navigationTitle(isCreating ? "Add Subject" : "Edit Subject")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) { 
                    Button{
                        if isCreating{
                            let newSubject = SubjectDataModel(
                                name: name,
                                color: color,
                                professorName: professorName,
                                subjectIcon: subjectIcon
                            )
                            context.insert(newSubject)
                        }
                        
                        
                        if !isCreating{
                            subject!.name = name
                            subject!.color = color
                            subject!.professorName = professorName
                            subject!.subjectIcon = subjectIcon
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
        .onAppear{
            name = subject?.name ?? ""
            professorName = subject?.professorName ?? ""
            subjectIcon = subject?.subjectIcon ?? "paintpalette.fill"
            color = subject?.color ?? "Blue"
        }
        
        
    }
}


