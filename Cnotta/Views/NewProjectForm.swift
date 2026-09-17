//
//  NewProjectForm.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI
import SwiftData

struct NewProjectForm: View {
    
    private enum FocusedField {
        case name
    }
    
    private var colors = Color.projectColors
    private var projectNamePlaceholders = [
        "Sweater", "Beanie", "Scarf", "Sock"
    ]
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var name: String = ""
    @State private var color = Color.projectColors.randomElement()!
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField(projectNamePlaceholders.randomElement() ?? "", text: $name)
                        .accessibilityLabel(Text("Project name"))
                        .focused($focusedField, equals: .name)
                }
                Section("Color") {
                    ColorPicker(selectedColor: $color, colors: colors)
                        .listRowBackground(Color.clear)
                }
            }
            .onAppear {
                focusedField = .name
            }
            .navigationTitle(Text("New Project"))
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
                        insertNewProject()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(!canCreateProject())
                }
            }
        }
    }
    
    private func insertNewProject() {
        let hex = color.toHexCode()
        let project = Project(name: name, color: hex)
        
        modelContext.insert(project)
    }
    
    private func canCreateProject() -> Bool {
        return !name.isEmpty
    }
    
}

#Preview {
    NewProjectForm()
}
