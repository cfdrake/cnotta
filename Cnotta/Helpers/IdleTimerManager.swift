//
//  IdleTimerController.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import UIKit

protocol IdleTimerProvider: AnyObject {
    var isIdleTimerDisabled: Bool { get set }
}

final class IdleTimerManager: IdleTimerProvider {
    
    var isIdleTimerDisabled: Bool {
        get {
            UIApplication.shared.isIdleTimerDisabled
        }
        set {
            UIApplication.shared.isIdleTimerDisabled = newValue
        }
    }
    
}
