//
//  AppNavigator.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI
import Combine

enum AppDestination: Hashable {
    case detail(project: Project)
    case adminPanel
}

@MainActor
final class AppNavigator: ObservableObject {
    
    @Published var path = [AppDestination]()
    
    func navigate(to destination: AppDestination) {
        path.append(destination)
    }
    
    func navigateBack() {
        guard !path.isEmpty else {
            return
        }
        
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeAll()
    }
    
}
