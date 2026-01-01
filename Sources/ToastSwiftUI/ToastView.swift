//
//  ToastView.swift
//  ToastSwiftUI
//
//  Created by Telha Wasim on 01/01/2026.
//

import SwiftUI

internal struct ToastView: View {
    
    // MARK: - Properties
    var size: CGSize
    var item: ToastItem
    
    @State private var delayTask: DispatchWorkItem?
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            if let symbol = self.item.symbol {
                Image(systemName: symbol)
                    .font(.title3)
                    .padding(.trailing, 10)
            }
            
            Text(self.item.title)
                .lineLimit(1)
        }
        .foregroundStyle(self.item.tint)
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(
            .background
                .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: 5, y: 5))
                .shadow(.drop(color: .primary.opacity(0.06), radius: 8, x: -5, y: -5)),
            in: .capsule
        )
        .contentShape(.capsule)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    self.handleDragEnd(value: value)
                }
        )
        .onAppear {
            self.setupAutoRemove()
        }
        .frame(maxWidth: self.size.width * 0.7)
        .transition(.move(edge: self.item.position == .top ? .top : .bottom).combined(with: .opacity))
    }
    
    // MARK: - Private Methods
    private func handleDragEnd(value: DragGesture.Value) {
        guard self.item.isUserInteractionEnabled else { return }
        
        let endY = value.translation.height
        let velocityY = value.velocity.height
        let threshold: CGFloat = 100
        let shouldDismiss: Bool
        
        if self.item.position == .top {
            shouldDismiss = (endY + velocityY) < -threshold
        } else {
            shouldDismiss = (endY + velocityY) > threshold
        }
        
        if shouldDismiss {
            self.removeToast()
        }
    }
    
    private func setupAutoRemove() {
        guard self.delayTask == nil else { return }
        
        self.delayTask = DispatchWorkItem {
            self.removeToast()
        }
        
        if let delayTask = self.delayTask {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + self.item.timing.rawValue,
                execute: delayTask
            )
        }
    }
    
    private func removeToast() {
        self.delayTask?.cancel()
        
        withAnimation(.snappy) {
            Toast.shared.toasts.removeAll(where: { $0.id == self.item.id })
        }
    }
}
