//
//  .swift
//
//
//  Created by Davron Abdukhakimov on 03/01/24.
//

import SwiftUI
import PhotosUI

struct ReminderFormView: View {
    
    @Environment(\.modelContext) var context
    
    var reminder: ReminderDataModel?
    var subject: SubjectDataModel
    
    @State var title = ""
    @State var notes = ""
    @State var deadline = Date()
    @State var selectedItems:[PhotosPickerItem] = []
    @State var images:[Data] = []
    @State var color = "Blue"
    @State var remindDay = "1"
    
    @Binding var isShowingForm:Bool
    var isCreating:Bool
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Assignment details"){
                    TextField("Title", text: $title,axis: .vertical)
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                    
                }
                Section{
                    DatePicker("Deadline:",
                               selection: $deadline,
                               in:Date()...
                    )
                    .datePickerStyle(.compact)
                    Picker("Remind before:", selection: $remindDay) {
                        Text("1 day")
                            .tag("1")
                        Text("3 days")
                            .tag("3")
                        Text("5 days")
                            .tag("5")
                        Text("1 week")
                            .tag("7")
                    }
                }
                
                Section("Images"){
                    if !images.isEmpty{
                        LazyVGrid(columns: imageColumns){
                            ForEach(images,id:\.self){imageData in
                                Image(uiImage: UIImage(data: imageData)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                            }
                        }
                        
                    }
                    PhotosPicker("+ Add Images", selection: $selectedItems, selectionBehavior:.ordered, matching: .images)
                    
                }
                .onChange(of: selectedItems) {
                    Task {
                        images.removeAll()
                        for item in selectedItems {
                            if let image = try? await item.loadTransferable(type: Data.self) {
                                images.append(image)
                            }
                        }
                    }
                }
                Section("Assignment Color") {
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
            .navigationTitle(isCreating ? "Add Assignment" : "Edit Assignment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        if isCreating{
                            let newReminder = ReminderDataModel(
                                
                                title: title,
                                notes: notes,
                                color: color,
                                images:images,
                                deadline: deadline,
                                remindDate: getRemindDate(
                                    day: remindDay,
                                    deadline: deadline
                                ), 
                                remindDay: remindDay,
                                subject: subject
                            )
                            context.insert(newReminder)
                        }
                        if !isCreating{
                            reminder!.title = title
                            reminder!.notes = notes
                            reminder!.color = color
                            reminder!.images = images
                            
                            reminder!.deadline = deadline
                            reminder!.remindDate = getRemindDate(
                                day: remindDay,
                                deadline: deadline
                            )
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
            
            title = reminder?.title ?? ""
            notes = reminder?.notes ?? ""
            deadline = reminder?.deadline ?? Date()
            remindDay = reminder?.remindDay ?? "1"
            images = reminder?.images ?? []
            color = reminder?.color ?? "Blue"
            
        }
    }
}


