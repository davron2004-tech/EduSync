//
//  .swift
//
//
//  Created by Davron Abdukhakimov on 03/01/24.
//

import SwiftUI
import PhotosUI


struct ResourceFormView: View {
    
    @Environment(\.modelContext) var context
    
    var resource:ResourceDataModel?
    var subject:SubjectDataModel
    
    @State var title = ""
    @State var notes = ""
    @State var selectedItems:[PhotosPickerItem] = []
    @State var images:[Data] = []
    @State var color = "Blue"
    
    @Binding var isShowingForm:Bool
    var isCreating:Bool
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Resource details"){
                    TextField("Title", text: $title,axis: .vertical)
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                    
                }
                Section("Images"){
                    if !images.isEmpty{
                        
                        LazyVGrid(columns: imageColumns,spacing: 10){
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
                Section("Resource Color") {
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
            .navigationTitle(isCreating ? "Add Resource" : "Edit Resource")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        if isCreating{
                            let newResource = ResourceDataModel(
                                title: title,
                                notes: notes,
                                color: color,
                                images: images,
                                subject: subject
                            )
                            context.insert(newResource)
                        }
                        if !isCreating{
                            resource!.title = title
                            resource!.notes = notes
                            resource!.color = color
                            
                            resource!.images = images
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
            title = resource?.title ?? ""
            notes = resource?.notes ?? ""
            images = resource?.images ?? []
            color = resource?.color ?? "Blue"
        }
        
    }
}


