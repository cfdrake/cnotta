//
//  ContentView.swift
//  Cnotta
//
//  Created by Colin Drake on 9/11/26.
//

import SwiftUI
import SwiftData

struct ProjectsList: View {
    
    @StateObject private var navigation = AppNavigator()
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Project.modified, order: .reverse)]) var projects: [Project]
    @State private var isPresentingAddProjectForm = false
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            Group {
                if projects.count > 0 {
                    ScrollView {
                        ForEach(projects) { project in
                            NavigationLink(value: AppDestination.detail(project: project)) {
                                ProjectListRow(project: project)
                                    .padding([.top, .bottom], 4)
                                    .padding([.leading, .trailing], 16)
                            }
                        }
                        .onDelete(perform: deleteProjects)
                    }
                } else {
                    Group {
                        Spacer()
                        ContentUnavailableView("No projects", image: "exclamationmark.circle", description: Text("Tap the plus button to get started!"))
                        Spacer()
                    }
                }
            }
            .navigationTitle(Text("My Projects"))
            .environmentObject(navigation)
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .detail(project: let project):
                    ProjectDetail(
                        project: project,
                        idleTimerController: IdleTimerManager(),
                        haptics: HapticsManager()
                    )
                    .environmentObject(navigation)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .confirm, action: {
                        isPresentingAddProjectForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityHint("Create a new project")
                }
            }
        }
        .sheet(isPresented: $isPresentingAddProjectForm) {
            NewProjectForm()
        }
    }
    
    private func deleteProjects(at offsets: IndexSet) {
        for offset in offsets {
            let project = projects[offset]
            
            modelContext.delete(project)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Project.self, configurations: config)
    
    let projects = [
        Project(name: "Sweater", color: 0xff0000),
        Project(name: "Beanie", color: 0x0000ff)
    ]
    
    for project in projects {
        container.mainContext.insert(project)
    }
    
    return ProjectsList()
        .modelContainer(container)
}
