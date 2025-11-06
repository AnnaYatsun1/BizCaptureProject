//
//  GlassCardStyle.swift
//  FeatureHome
//
//  Created by Анна Яцун on 30.10.2025.
//
import SwiftUI

struct GlassCardStyle: ViewModifier {
    let corner: CGFloat
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .fill(.ultraThinMaterial) // iOS 15+
                    .opacity(0.18)
            )
            .overlay(
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [
                                .white.opacity(0.35),
                                .white.opacity(0.10)
                            ],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            ).clipShape(RoundedRectangle(cornerRadius: 23, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: corner - 1, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 0.5)
                    .blur(radius: 1.2)
                    .offset(y: 1)
                    .mask(
                        LinearGradient(
                            colors: [.white, .clear],
                            startPoint: .top, endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    )
            )
            // лёгкая тень под карточкой
            .shadow(color: .black.opacity(0.35), radius: 14, x: 0, y: 8)
    }
}

extension View {
    func glassCard(corner: CGFloat = 24) -> some View {
        modifier(GlassCardStyle(corner: corner))
    }
}
