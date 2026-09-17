//
//  Project.swift
//  Cnotta
//
//  Created by Colin Drake on 9/11/26.
//

import Foundation
import SwiftData

typealias Project = ProjectsSchemaV1.Project

enum ProjectsSchemaV1: VersionedSchema {
    
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Project.self]
    }

    @Model
    final class Project: Identifiable {
        
        // MARK: - Properties
        
        /// Unique identifier for the project.
        var id: UUID
        
        /// Project's name.
        var name: String
        
        /// Datetime the project was created.
        var created: Date
        
        /// Datetime the project was last updated.
        var modified: Date
        
        /// Count value of the project.
        var count: Int
        
        /// Color for the project.
        var color: Int
        
        // MARK: - Initialization

        init(id: UUID = UUID(), name: String, created: Date = Date(), modified: Date = Date(), count: Int = 0, color: Int) {
            // Sanity check for proper values.
            assert(count >= 0)
            assert(color >= 0x000000 && color <= 0xffffff)
            
            self.id = id
            self.name = name
            self.created = created
            self.modified = modified
            self.count = count
            self.color = color
        }
    }

}

extension Project {
    
    // MARK: - Public Interface
    
    func updateCount(by value: Int) {
        guard count + value >= 0 else {
            return
        }
        
        count += value
        updateModified()
    }
    
    func setCount(_ value: Int) {
        guard count >= 0 else {
            return
        }
        
        count = value
        updateModified()
    }
    
    // MARK: - Private
    
    private func updateModified() {
        modified = Date()
    }
}
