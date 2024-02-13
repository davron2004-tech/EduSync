//
//  SwiftUIView.swift
//
//
//  Created by Davron Abdukhakimov on 06/01/24.
//

import SwiftUI

//@State var title = ""
//@State var notes = ""
//@State var deadline = Date()

//@State var images:[Data] = []


struct DetailView: View {
    
    var resource:ResourceDataModel?
    var reminder:ReminderDataModel?
    
    @State var isShowingResourceForm = false
    @State var isShowingReminderForm = false
    @State var isCompleted = false
    
    var title: String{
        if let resource{
            return resource.title
        }
        if let reminder{
            return reminder.title
        }
        return ""
    }
    var notes: String{
        if let resource{
            return resource.notes
        }
        if let reminder{
            return reminder.notes
        }
        return ""
    }
    var images: [Data]{
        if let resource{
            return resource.images
        }
        if let reminder{
            return reminder.images
        }
        return []
    }
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical) {
                VStack(alignment:.leading){
                    if reminder != nil{
                        Toggle("Completed", isOn: $isCompleted)
                            .padding(.trailing)
                    }
                    HStack{
                        Text("Notes")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        Spacer()
                    }
                    if notes == ""{
                        ContentUnavailableView("No notes", systemImage: "note")
                    }
                    else{
                        Text(notes)
                            .multilineTextAlignment(.leading)
                            .font(.title3)
                            .padding(.bottom)
                    }
                    
                    HStack{
                        Text("Images")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        Spacer()
                    }
                    if images.isEmpty{
                        ContentUnavailableView("No images", systemImage: "photo.fill")
                    }
                    else{
                        
                        LazyVGrid(columns: imageColumns,spacing: 10){
                            ForEach(images,id:\.self){imageData in
                                NavigationLink{
                                    ImageView(imageData: imageData)
                                }label: {
                                    Image(uiImage: UIImage(data: imageData)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .frame(width: 110,height: 110)
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                    
                }
                .padding()
            }
            .navigationTitle(title)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        if reminder != nil{
                            isShowingReminderForm = true
                        }
                        if resource != nil{
                            isShowingResourceForm = true
                        }
                    }label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
                
            }
        }
        .onAppear{
            if let reminder{
                isCompleted = reminder.isCompleted
            }
        }
        .onDisappear{
            if let reminder{
                reminder.isCompleted = isCompleted
            }
        }
        .sheet(isPresented: $isShowingReminderForm){
            ReminderFormView(
                reminder: reminder, 
                subject: reminder!.subject,
                isShowingForm: $isShowingReminderForm,
                isCreating: false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isShowingResourceForm){
            ResourceFormView(
                resource: resource,
                subject: resource!.subject,
                isShowingForm: $isShowingResourceForm,
                isCreating: false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        
    }
}


