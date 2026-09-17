//
//  ProjectTests.swift
//  CnottaTests
//
//  Created by Colin Drake on 9/17/26.
//

import Foundation
import Testing
@testable import Cnotta

struct ProjectTests {
    
    // MARK: - Initializer Tests

    @Test func testInitializerWithProvidedValues() async throws {
        let uuid = UUID()
        let name = "Test"
        let created = Date(timeIntervalSince1970: 0)
        let modified = Date(timeIntervalSince1970: 1000)
        let count = 10
        let color = 0xff0000
        
        let project = Project(id: uuid, name: name, created: created, modified: modified, count: count, color: color)
        
        #expect(project.id == uuid)
        #expect(project.name == name)
        #expect(project.created == created)
        #expect(project.modified == modified)
        #expect(project.count == count)
        #expect(project.color == color)
    }

    @Test func testInitializerWithDefaultValues() async throws {
        let project = Project(name: "Test", color: 0xff0000)

        // (Somewhat hacky, but reasonable.)
        // Check that the UUID isn't empty, the dates
        // are "now"-ish, and the count is zero.
        #expect(!project.id.uuidString.isEmpty)
        #expect(project.created.timeIntervalSinceNow < 1)
        #expect(project.created.timeIntervalSinceNow < 1)
        #expect(project.count == 0)
    }
    
    // MARK: - updateCount() Tests
    
    @Test func testUpdateCount() async throws {
        let project = Project(name: "Test", color: 0xff0000)
        
        #expect(project.count == 0)
        
        project.updateCount(by: 1)
        #expect(project.count == 1)
        
        project.updateCount(by: 10)
        #expect(project.count == 11)
        
        project.updateCount(by: -1)
        #expect(project.count == 10)
        
        project.updateCount(by: -10)
        #expect(project.count == 0)
    }
    
    @Test func testUpdateCountBoundaryConditionZero() async throws {
        let project = Project(name: "Test", color: 0xff0000)
        
        #expect(project.count == 0)
        
        project.updateCount(by: -1)
        #expect(project.count == 0)
        
        project.updateCount(by: -10)
        #expect(project.count == 0)
    }
    
    @Test func testUpdateCountBoundaryConditionGreaterThanZero() async throws {
        let project = Project(name: "Test", count: 10, color: 0xff0000)
        
        #expect(project.count == 10)
        
        project.updateCount(by: -20)
        #expect(project.count == 10)
        
        project.updateCount(by: -10)
        #expect(project.count == 0)
    }

}
