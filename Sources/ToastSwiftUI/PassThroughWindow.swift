//
//  PassThroughWindow.swift
//  ToastSwiftUI
//
//  Created by Telha Wasim on 01/01/2026.
//

import UIKit

internal class PassThroughWindow: UIWindow {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        guard let rootView = rootViewController?.view else { return nil }
        
        if hitView == rootView {
            let toastAreaHeight: CGFloat = 150
            
            // Check top toast area
            if Toast.shared.hasTopToast {
                if point.y < toastAreaHeight {
                    return hitView
                }
            }
            
            // Check bottom toast area
            if Toast.shared.hasBottomToast {
                if point.y > (rootView.bounds.height - toastAreaHeight) {
                    return hitView
                }
            }
            
            return nil
        }
        
        return hitView
    }
}
