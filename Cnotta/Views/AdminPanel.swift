//
//  AdminPanel.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI

struct AdminPanel: View {
    
    var body: some View {
        Form {
            List {
                Section("Actions") {
                    Button("Reset Onboarding") {
                        OnboardingManager.shared.setHasSeenOnboarding(false)
                    }
                }
            }
        }
        .navigationTitle("Admin")
    }
}

#Preview {
    AdminPanel()
}
