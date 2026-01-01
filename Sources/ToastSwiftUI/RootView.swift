//
//  RootView.swift
//  ToastSwiftUI
//
//  Created by Telha Wasim on 01/01/2026.
//

import SwiftUI

public struct RootView<Content: View>: View {
    
    // MARK: - Properties
    @ViewBuilder public var content: Content
    @State private var overlayWindow: UIWindow?
    
    // MARK: - Init
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        self.content
            .onAppear {
                self.setupOverlayWindow()
            }
    }
    
    // MARK: - Private Methods
    private func setupOverlayWindow() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              self.overlayWindow == nil else {
            return
        }
        
        let window = PassThroughWindow(windowScene: windowScene)
        window.backgroundColor = .clear
        window.windowLevel = .alert + 1
        
        let rootController = UIHostingController(rootView: ToastGroup())
        rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
        rootController.view.backgroundColor = .clear
        
        window.rootViewController = rootController
        window.isHidden = false
        window.isUserInteractionEnabled = true
        window.tag = 1009
        
        self.overlayWindow = window
    }
}
