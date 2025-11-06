//
//  GlassTabBar.swift
//  BizCapture
//
//  Created by Анна Яцун on 28.10.2025.
//

import SwiftUI
import Core


public struct GlassTabBar: View {
  @Binding var selected: ModelTabBar
  @Namespace private var underlineNS

  public var body: some View {
    HStack(spacing: 0) {
        ForEach(ModelTabBar.allCases, id: \.self) { tab in
            tabButton(tab)
        }
    }
    .padding(.horizontal, 10)
    .padding(.vertical, 8)
    .background(Color.surface.opacity(0.35))
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .overlay(
      RoundedRectangle(cornerRadius: 20, style: .continuous)
        .stroke(Color.outline, lineWidth: 1)
    )
    .shadow(color: .black.opacity(0.18), radius: 20, y: 8)
    .padding(.horizontal, 16)
    .sensoryFeedback(.impact(weight: .light), trigger: selected)
  }

  @ViewBuilder
  private func tabButton(_ tab: ModelTabBar) -> some View {
    let isSelected = (selected == tab)

    Button {
      withAnimation(.spring(response: 0.28, dampingFraction: 0.88)) {
        selected = tab
      }
    } label: {
      VStack(spacing: 4) {
          Image(systemName: tab.symbol)
          .font(.system(size: 20, weight: .semibold))
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(isSelected ? DSStyle.accent : DSStyle.textSecondary)

          Text(tab.name)
          .font(.system(size: 12, weight: isSelected ? .semibold : .regular))
          .foregroundStyle(isSelected ? Color.textPrimary : Color.textSecondary)
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical, 8)
      // мягкая «пилюля» выделения
      .background(
        RoundedRectangle(cornerRadius: 12, style: .continuous)
          .fill(Color.accentPrimary.opacity(isSelected ? 0.18 : 0))
      )
      .contentShape(Rectangle())
      .accessibilityLabel(Text(tab.name))
      .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
    .buttonStyle(.plain)
  }
}
