//
//  .swift
//  UniSync
//
//  Created by Davron Abdukhakimov on 01/01/24.
//

import SwiftUI
import SwiftData

struct SubjectsView: View {
    
    @Environment(\.modelContext) var context
    
    @Query var subjects:[SubjectDataModel]
    
    @State var isShowingSubjectForm = false
    
    var body: some View {
        NavigationStack{
            if subjects.isEmpty{
                ContentUnavailableView{
                    Label("No Subjects", systemImage: "books.vertical.fill")
                }actions: {
                    Button{
                        isShowingSubjectForm = true
                    }label: {
                        Text("Add subject")
                    }
                }
                .navigationTitle("Subjects")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button{
                            isShowingSubjectForm = true
                        }label: {
                            Image(systemName: "plus")
                        }
                    }

                }
            }
            else{
                List{
                    ForEach(subjects){subject in
                        NavigationLink{
                            DashboardView(subject: subject)
                        }label: {
                            SubjectCell(subject: subject)
                        }
                        .popoverTip(SwipeTip.sharedTip)
                        
                    }
                }
                .navigationTitle("Subjects")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button{
                            isShowingSubjectForm = true
                        }label: {
                            Image(systemName: "plus")
                        }
                    }

                }
            }
        }
        .sheet(isPresented: $isShowingSubjectForm){
            SubjectFormView(
                isShowingForm: $isShowingSubjectForm,
                isCreating: true
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    SubjectsView()
}
