//
//   Gradient+Theme.swift
//  CoreSPM
//
//  Created by Анна Яцун on 28.10.2025.
//

import SwiftUI


public enum DSStyle {
  public static let accent = AnyShapeStyle(LinearGradient(
    colors: [.accentPrimary, .accentSecondary],
    startPoint: .topLeading, endPoint: .bottomTrailing
  ))
  public static let textSecondary = AnyShapeStyle(Color.textSecondary)
}
