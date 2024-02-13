import SwiftUI

struct EduSyncTabView: View {
    
    
    @Environment(\.horizontalSizeClass) var width
    @State var currentTab:Tabs?
    
    enum Tabs{
        case home
        case timetable
        case subjects
        case study
    }
    
    var body: some View {
        if width == .compact{
            TabView{
                HomeView()
                    .tabItem {Label("Home", systemImage: "house.fill") }
                    
                TimeTableView()
                    .tabItem {Label("Timetable", systemImage: "calendar") }
                SubjectsView()
                    .tabItem {Label("Subjects", systemImage: "books.vertical.fill")}
                    
                StudyView()
                    .tabItem {Label("Study", systemImage: "clock.fill")}
                   
            }
        }
        else{
            NavigationSplitView(columnVisibility: .constant(.doubleColumn)) {
                NavigationStack{
                    List(selection: $currentTab) {
                        Section{
                            Label("Home", systemImage: "house.fill")
                                .tag(Tabs.home)
                            
                            Label("Timetable", systemImage: "calendar")
                                .tag(Tabs.timetable)
                            
                            
                            Label("Subjects", systemImage: "books.vertical.fill")
                                .tag(Tabs.subjects)
                            
                            Label("Study", systemImage: "clock.fill")
                                .tag(Tabs.study)
                            
                        }
                        .listRowSeparator(.hidden)
                    }
                    .padding(.top)
                    .scrollContentBackground(.hidden)
                    .navigationTitle("Edu Sync")
                }
            } detail: {
                switch currentTab {
                case .home:
                    HomeView()
                case .timetable:
                    TimeTableView()
                case .subjects:
                    SubjectsView()
                case .study:
                    StudyView()
                case nil:
                    HomeView()
                }
            }
            .navigationSplitViewStyle(.balanced)
            .onAppear {
                currentTab = .home
            }
        }
    }
}
