//
//  ContentView.swift
//  Cnotta
//
//  Created by Colin Drake on 9/11/26.
//

import SwiftUI
import SwiftData

struct ProjectsList: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Project.modified) var projects: [Project]
    @State private var isPresentingAddProjectForm = false
    
    var body: some View {
        NavigationStack {
            Group {
                if projects.count > 0 {
                    ScrollView {
                        ForEach(projects) { project in
                            NavigationLink(value: project) {
                                ProjectListItem(project: project)
                                    .padding([.top, .bottom], 4)
                                    .padding([.leading, .trailing], 16)
                            }
                        }
                        .onDelete(perform: deleteProjects)
                    }
                } else {
                    Spacer()
                    ContentUnavailableView("No projects!", image: "exclamationmark.circle", description: Text("Create one?"))
                    Spacer()
                }
            }
            .navigationTitle(Text("Projects"))
            .toolbar {
                Button(role: .confirm, action: {
                    isPresentingAddProjectForm = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityHint("Create a new project")
            }
            .navigationDestination(for: Project.self) { project in
                ProjectDetail(project: project, idleTimerController: UIApplication.shared)
            }
            .sheet(isPresented: $isPresentingAddProjectForm) {
                NewProjectForm()
            }
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
    //
    //    for project in projects {
    //        container.mainContext.insert(project)
    //    }
    
    return ProjectsList()
        .modelContainer(container)
}
