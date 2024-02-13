//
//  ResourceCell.swift
//  
//
//  Created by Davron Abdukhakimov on 02/01/24.
//

import SwiftUI

struct ResourceCell: View {
    
    @Environment(\.modelContext) var context
    @State var isShowingResourceForm = false
    
    var resource:ResourceDataModel
    
    var body: some View {
        VStack(alignment:.leading){
            
            Text(resource.title)
                .lineLimit(2)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Spacer()
            Text(resource.notes)
                .lineLimit(1)
                .foregroundStyle(.white)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.bottom,3)
            HStack{
                Text("\(resource.images.count) images")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                Spacer()
            }
            
        }
        .modifier(CustomCellModifier(width: 200, height: 150, color: resource.color))
        .contextMenu{
            Section{
                Button{
                    isShowingResourceForm = true
                }label: {
                    Label("Edit", systemImage: "square.and.pencil")
                }
            }
            
            Section{
                Button(role:.destructive){
                    context.delete(resource)
                }label: {
                    Label("Delete", systemImage: "trash")
                        .foregroundStyle(.red)
                }
            }
            .onAppear{
                MenuTip.sharedTip.invalidate(reason: .actionPerformed)
            }
            
        }
        .sheet(isPresented: $isShowingResourceForm) {
            ResourceFormView(
                resource:resource,
                subject: resource.subject, 
                isShowingForm: $isShowingResourceForm,
                isCreating:false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ResourceCell(
        resource: ResourceDataModel(
            title: "Lesson - 1",
            notes: "Binary Tree",
            color: "Green",
            images: [], 
            subject:SubjectDataModel(
                name: "Academic English",
                color: "Name",
                professorName: "house",
                subjectIcon: "Green"
            )
        )
    )
}
