//
//  Colors.swift
//  CoreSPM
//
//  Created by Анна Яцун on 28.10.2025.
//

import SwiftUI


public extension Color {
  // Иф/baground
  static let appBackground = Color("Background",      bundle: .module)
  static let surface = Color("Surface",         bundle: .module)
  static let surfaceElevated = Color("SurfaceElevated", bundle: .module)

  // Accent
  static let accentPrimary = Color("AccentPrimary",   bundle: .module)   // #6D7CFF
  static let accentSecondary = Color("AccentSecondary", bundle: .module)   // #22D3EE

  // Test/status
  static let textPrimary = Color("TextPrimary",     bundle: .module)
  static let textSecondary = Color("TextSecondary",   bundle: .module)
  static let outline = Color("Outline",         bundle: .module)
  static let success = Color("Success",         bundle: .module)
  static let warning = Color("Warning",         bundle: .module)
  static let error = Color("Error",           bundle: .module)
}


public extension Image {
    static let homeFriend = Image("Friend", bundle: .module)
    static let roomBackground = Image("door_back", bundle: .module)
    static let roomDoor = Image("door_front", bundle: .module)
    static let friendOutline = Image("friend_fill2", bundle: .module)
    static let friendFill = Image("testPerson2", bundle: .module)
//    Image("room_background")
}
