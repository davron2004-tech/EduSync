import SwiftUI
import SwiftData
import TipKit

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            EduSyncTabView()
                .task { 
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
        .modelContainer(
            for: [
            SubjectDataModel.self,
            LessonDataModel.self,
            ResourceDataModel.self,
            ReminderDataModel.self,
            TimerDataModel.self
            ],
            isAutosaveEnabled: true
        )
    }
}
