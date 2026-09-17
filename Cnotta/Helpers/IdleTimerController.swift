//
//  IdleTimerController.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import UIKit

/// A type which manages the application idle timer.
protocol IdleTimerController: AnyObject {
    var isIdleTimerDisabled: Bool { get set }
}

extension UIApplication: IdleTimerController {
    // no-op: already defined!
}
