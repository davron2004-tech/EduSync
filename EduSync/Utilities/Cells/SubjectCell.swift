//
//  SubjectCell.swift
//
//
//  Created by Davron Abdukhakimov on 01/01/24.
//

import SwiftUI

struct SubjectCell: View {
    
    
    @Environment(\.modelContext) var context
    @State var isShowingSubjectForm = false
    
    var subject: SubjectDataModel
    
    var body: some View {
        HStack{
            Image(systemName: subject.subjectIcon)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 45,height: 45)
                .background(
                    LinearGradient(colors: [Color("\(subject.color)Full"),Color("\(subject.color)Half")], startPoint: .bottom, endPoint: .top)
                    
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment:.leading){
                Text(subject.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(subject.professorName)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
            .padding(.leading)
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                context.delete(subject)
            } label: {
                Text("Delete")
            }
            Button{
                isShowingSubjectForm = true
            }label: {
                Image(systemName: "square.and.pencil")
            }
            .tint(Color.accentColor)
            .onAppear{
                SwipeTip.sharedTip.invalidate(reason: .actionPerformed)
            }
        }
        .sheet(isPresented: $isShowingSubjectForm){
            SubjectFormView(
                subject: subject,
                isShowingForm: $isShowingSubjectForm,
                isCreating: false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}
#Preview {
    SubjectCell(
        subject:SubjectDataModel(
            name: "Academic English",
            color: "Name",
            professorName: "house",
            subjectIcon: "Green"
        )
    )
}
