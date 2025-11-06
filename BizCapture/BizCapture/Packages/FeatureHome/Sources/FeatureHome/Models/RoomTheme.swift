//
//  RoomTheme.swift
//  FeatureHome
//
//  Created by Анна Яцун on 06.11.2025.
//

public enum RoomTheme: String, CaseIterable {
    case friend, family, coach, dating
    
    public var base: Color {
        switch self {
        case .friend: return Color(hue: 0.06, saturation: 1.0, brightness: 1.0)   // янтарь
        case .family: return Color(hue: 0.57, saturation: 0.90, brightness: 1.0)  // бирюза
        case .coach:  return Color(hue: 0.80, saturation: 0.85, brightness: 1.0)  // фуксия
        case .dating: return Color(hue: 0.98, saturation: 0.95, brightness: 1.0)  // коралл
        }
    }
    public var breathePeriod: Double {         // медленное дыхание
        switch self {
        case .friend: return 6.0
        case .family: return 7.0
        case .coach:  return 5.5
        case .dating: return 6.5
        }
    }
   public  var dustSpeed: Double {             // скорость частиц
        switch self {
        case .friend: return 14
        case .family: return 16
        case .coach:  return 12
        case .dating: return 15
        }
    }
}
