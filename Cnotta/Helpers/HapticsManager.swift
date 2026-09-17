//
//  UIFeedbackGeneratorHapticsProvider.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import UIKit

protocol HapticsProvider {
    func generateHapticEvent()
}

final class HapticsManager: HapticsProvider {
    
    private let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    func generateHapticEvent() {
        generator.impactOccurred(intensity: 1.0)
    }
}
