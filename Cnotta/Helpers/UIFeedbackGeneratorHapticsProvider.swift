//
//  UIFeedbackGeneratorHapticsProvider.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import UIKit

final class UIFeedbackGeneratorHapticsProvider: HapticsProvider {
    
    private let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    func buzz() {
        generator.impactOccurred(intensity: 1.0)
    }
}
