//
//  Toast.swift
//  ToastSwiftUI
//
//  Created by Telha Wasim on 30/12/2025.
//

import SwiftUI

@MainActor
@Observable
public class Toast {
    
    // MARK: - Shared Instance
    public static let shared = Toast()
    
    // MARK: - Properties
    internal var toasts: [ToastItem] = []
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Public Methods
    public func present(
        title: String,
        symbol: String? = nil,
        tint: Color = .primary,
        isUserInteractionEnabled: Bool = false,
        timing: ToastTime = .medium,
        position: ToastPosition = .bottom
    ) {
        withAnimation(.snappy) {
            self.toasts.append(
                ToastItem(
                    title: title,
                    symbol: symbol,
                    tint: tint,
                    isUserInteractionEnabled: isUserInteractionEnabled,
                    timing: timing,
                    position: position
                )
            )
        }
    }
    
    /// Dismiss all toasts
    public func dismissAll() {
        withAnimation(.snappy) {
            self.toasts.removeAll()
        }
    }
    
    /// Dismiss toast by ID
    public func dismiss(id: UUID) {
        withAnimation(.snappy) {
            self.toasts.removeAll(where: { $0.id == id })
        }
    }
    
    // MARK: - Internal Helpers
    internal var hasTopToast: Bool {
        self.toasts.contains(where: { $0.position == .top })
    }
    
    internal var hasBottomToast: Bool {
        self.toasts.contains(where: { $0.position == .bottom })
    }
}
