//
//  OnboardingManager.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import Foundation

final class OnboardingManager {
    
    private let onboardingKey = "hasSeenOnboarding"
    
    func shouldShowOnboarding() -> Bool {
        return UserDefaults.standard.bool(forKey: onboardingKey) == false
    }
    
    func setHasSeenOnboarding(_ hasSeen: Bool) {
        return UserDefaults.standard.set(hasSeen, forKey: onboardingKey)
    }
    
}
