//
//  Door3DEffect.swift
//  FeatureHome
//
//  Created by Анна Яцун on 04.11.2025.
//

import SwiftUI
import QuartzCore

struct Door3DEffect: GeometryEffect {
    var angle: Double
    var perspective: CGFloat = 1/700
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let toPivot   = CGAffineTransform(translationX: 0, y: -size.height/2)
        let fromPivot = CGAffineTransform(translationX: 0, y:  size.height/2)
        var t = CATransform3DIdentity
        t.m34 = -perspective
        t = CATransform3DRotate(t, CGFloat(angle), 0, 1, 0)
        return ProjectionTransform(fromPivot)
            .concatenating(ProjectionTransform(t))
            .concatenating(ProjectionTransform(toPivot))
    }
}
