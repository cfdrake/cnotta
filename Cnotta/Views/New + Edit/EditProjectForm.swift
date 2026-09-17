//
//  EditProjectForm.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI
import SwiftData

struct EditProjectForm: View {
    
    private var colors = Color.projectColors
    private var projectNamePlaceholders = [
        "Sweater", "Beanie", "Scarf", "Sock"
    ]
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var name: String
    @State private var color: Color
    @State private var isPresentingAlertDialog: Bool = false
    
    let project: Project
    
    private var createDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: project.created)
    }
    
    init(project: Project) {
        self.project = project
        self.name = project.name
        self.color = Color.fromHexCode(project.color)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField(projectNamePlaceholders.randomElement() ?? "", text: $name)
                        .accessibilityLabel(Text("Project name"))
                }
                Section("Color") {
                    ColorPicker(selectedColor: $color, colors: colors)
                        .listRowBackground(Color.clear)
                }
                Button(action: {
                    isPresentingAlertDialog = true
                }) {
                    Text("Delete Project")
                }
                .foregroundStyle(.red)
            }
            .alert("Are you sure you want to delete \"\(name)\"?", isPresented: $isPresentingAlertDialog, actions: {
                Button(role: .destructive, action: {
                    deleteProject()
                }, label: {
                    Text("Delete")
                })
                Button(role: .cancel, action: {
                    // no-op.
                }, label: {
                    Text("Cancel")
                })
            })
            .navigationTitle(Text(name))
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(role: .confirm) {
                        updateProject()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(!canCreateProject())
                }
            }
        }
    }
    
    private func deleteProject() {
        modelContext.delete(project)
        dismiss()
    }
    
    private func updateProject() {
        project.name = name
        project.color = color.toHexCode()
    }
    
    private func canCreateProject() -> Bool {
        return !name.isEmpty
    }
    
}

#Preview {
    let project = Project(name: "Test", color: 0xff0000)
    EditProjectForm(project: project)
}
