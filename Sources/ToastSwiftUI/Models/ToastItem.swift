//
//  ToastItem.swift
//  ToastSwiftUI
//
//  Created by Telha Wasim on 30/12/2025.
//

import SwiftUI

public struct ToastItem: Identifiable {
    public let id: UUID = .init()
    public var title: String
    public var symbol: String?
    public var tint: Color
    public var isUserInteractionEnabled: Bool
    public var timing: ToastTime
    public var position: ToastPosition
    
    public init(
        title: String,
        symbol: String? = nil,
        tint: Color = .primary,
        isUserInteractionEnabled: Bool = false,
        timing: ToastTime = .medium,
        position: ToastPosition = .bottom
    ) {
        self.title = title
        self.symbol = symbol
        self.tint = tint
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.timing = timing
        self.position = position
    }
}
