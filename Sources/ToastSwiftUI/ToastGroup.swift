//
//  ToastGroup.swift
//  ToastSwiftUI
//
//  Created by Telha Wasim on 01/01/2026.
//

import SwiftUI

internal struct ToastGroup: View {
    
    // MARK: - Properties
    var model: Toast = Toast.shared
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            
            ZStack {
                self.topToasts(size: size, safeArea: safeArea)
                self.bottomToasts(size: size, safeArea: safeArea)
            }
        }
    }
    
    // MARK: - Top Toasts
    @ViewBuilder
    private func topToasts(size: CGSize, safeArea: EdgeInsets) -> some View {
        let topToasts = self.model.toasts.filter { $0.position == .top }
        
        ZStack {
            ForEach(topToasts) { toast in
                ToastView(size: size, item: toast)
                    .scaleEffect(self.scale(toast, in: topToasts))
                    .offset(y: self.offsetY(toast, in: topToasts, position: .top))
                    .zIndex(Double(topToasts.firstIndex(where: { $0.id == toast.id }) ?? 0))
            }
        }
        .padding(.top, safeArea.top == .zero ? 15 : 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: - Bottom Toasts
    @ViewBuilder
    private func bottomToasts(size: CGSize, safeArea: EdgeInsets) -> some View {
        let bottomToasts = self.model.toasts.filter { $0.position == .bottom }
        
        ZStack {
            ForEach(bottomToasts) { toast in
                ToastView(size: size, item: toast)
                    .scaleEffect(self.scale(toast, in: bottomToasts))
                    .offset(y: self.offsetY(toast, in: bottomToasts, position: .bottom))
                    .zIndex(Double(bottomToasts.firstIndex(where: { $0.id == toast.id }) ?? 0))
            }
        }
        .padding(.bottom, safeArea.bottom == .zero ? 15 : 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
    
    // MARK: - Offset Calculation
    private func offsetY(_ item: ToastItem, in toasts: [ToastItem], position: ToastPosition) -> CGFloat {
        let index = CGFloat(toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
        let totalCount = CGFloat(toasts.count) - 1
        let offset = (totalCount - index) >= 2 ? 20 : ((totalCount - index) * 10)
        
        return position == .top ? offset : -offset
    }
    
    // MARK: - Scale Calculation
    private func scale(_ item: ToastItem, in toasts: [ToastItem]) -> CGFloat {
        let index = CGFloat(toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
        let totalCount = CGFloat(toasts.count) - 1
        
        return 1.0 - ((totalCount - index) >= 2 ? 0.2 : ((totalCount - index) * 0.1))
    }
}
