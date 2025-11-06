//
//  TabBarModel.swift
//  BizCapture
//
//  Created by Анна Яцун on 28.10.2025.
//


public enum ModelTabBar: Hashable, CaseIterable, Equatable {
    case home
    case chat
    case profile
    
    var name : String {
        switch self {
        case .home:
            return "Home"
        case .chat:
            return "Chat"
        case .profile:
            return "Profile"
        }
    }
    var symbol: String {
        switch self {
        case .home:
            return "house.fill"
        case .chat:
            return "message"
        case .profile:
            return "person"
        }
    }
}
