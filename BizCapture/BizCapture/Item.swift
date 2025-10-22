//
//  Item.swift
//  BizCapture
//
//  Created by Анна Яцун on 29.09.2025.
//

import Foundation
import SwiftData

@Model
final class Item: Equatable  {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
