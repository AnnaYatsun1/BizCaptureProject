//
//  SilhouetteNeon.swift
//  FeatureHome
//
//  Created by Анна Яцун on 06.11.2025.
//

import SwiftUI


public struct SilhouetteNeon: View {

    let base = Color(hue: 0.06, saturation: 1.0, brightness: 1.0) // янтарь
    var gain: CGFloat = 2                                    // крутилка яркости 1.0...2.0
    var breath: CGFloat = 1.0

    let theme: RoomTheme
    public var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { ctx in
                let w = geo.size.width
                let t = ctx.date.timeIntervalSinceReferenceDate
                let breathe = 0.6 + 0.12 * breath      // 0.88…1.0
                let flicker = 0.8 + 0.04 * sin(breath*6.28)
                configure(w: w, breathe: breathe, flicker: flicker, t: t)
            }
        }
        .aspectRatio(0.62, contentMode: .fit)
    }
    @ViewBuilder
    func configure(w: CGFloat, breathe: CGFloat, flicker: CGFloat, t: TimeInterval) -> some View {
        let phase   = 0.5 + 0.5 * sin(t * 1.4)
        let ringWidth = 2.0 + 5.0 * phase
        let p = 0.5 + 0.5 * sin(t / 4.0)
        let hueShift = Angle(degrees: p)
        let maskSolid = Image.friendFill
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .foregroundStyle(.white)
            .luminanceToAlpha()     // чистая форма
            .blur(radius: 0.5)

        let maskSoft = Image.friendFill
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .luminanceToAlpha()
            .blur(radius: 8)
            .hueRotation(hueShift).opacity(0.70 * phase * flicker)

        ZStack {
            // ДАЛЬНИЙ ОРЕОЛ (мягкий)
            RadialGradient(
                colors: [Color.black.opacity(0.12 * breath), .clear],
                center: .center, startRadius: w * 0.38, endRadius: w * 0.72
            )
            .blur(radius: 90)
            .blendMode(.plusLighter)
            .mask(maskSoft)
            Color.white.opacity(0.12 * breathe * flicker)
                .blur(radius: 120)
                .mask(maskSoft.scaleEffect(1.06))
                .blendMode(.plusLighter)

            let ringMask = maskSolid
                .overlay(maskSolid.blur(radius: ringWidth).blendMode(.destinationOut))
                .compositingGroup()

            theme.base.opacity(0.95 * breathe)
                .blur(radius: 4)
                .mask(ringMask)
                .blendMode(.plusLighter)
            theme.base.opacity(0.90 * breathe)
                .blur(radius: 2)
                .mask(ringMask)
                .blendMode(.plusLighter)
                .offset(y: w * 0.02)
            
            // БЛИЖНИЙ ОРЕОЛ (сочная кайма)
            RadialGradient(
                colors: [Color.white.opacity(0.24 * breath), .clear],
                center: .center, startRadius: w * 0.28, endRadius: w * 0.78
            )
            .blur(radius: 48)
            .blendMode(.plusLighter)
            .mask(maskSoft)

            // ТЕЛО (яркое, равномерное, управляемое gain)
            LinearGradient(
                colors: [
                    theme.base.opacity(min(0.95 * gain, 1.0)),
                    theme.base.opacity(0.92)
                ],
                startPoint: .top, endPoint: .bottom
            )
            .opacity(0.98 + 0.02 * phase)
            .blur(radius: 2 + 1.5 * phase)
            .mask(maskSolid)

            // ТЁПЛОЕ ЯДРО (добавляет «жар»)
            RadialGradient(
                colors: [theme.base.opacity(0.55 * gain * breath), .clear],
                center: .center, startRadius: 0, endRadius: w * 0.52
            )
            .blendMode(.screen)
            .mask(maskSolid)

            // ЛЁГКАЯ ГЛУБИНА (чтобы не блин)
            RadialGradient(
                colors: [Color.white.opacity(0.18), .clear],
                center: .center, startRadius: w * 0.12, endRadius: w * 0.72
            )
            .blur(radius: 16)
            .blendMode(.softLight)
            .mask(maskSolid.blur(radius: 4))

            // ДВОЙНОЙ КОНТУР (неон)
            
            theme.base.opacity(0.95 * breath)
                .blur(radius: 4)
                .blendMode(.plusLighter)
                .mask(maskSolid)

            theme.base.opacity(0.75 * breath)
                .blur(radius: 1.4)
                .blendMode(.plusLighter)
                .mask(maskSolid)
        }       .compositingGroup()
            .drawingGroup(opaque: false, colorMode: .linear)
    }
    
    private func makeMasks(for size: CGSize) {
        guard size.width > 0 else { return }
        let solid = Image.friendFill
            .renderingMode(.original)
            .resizable().scaledToFit()
            .luminanceToAlpha()
            .blur(radius: 0.5)
            .frame(width: size.width, height: size.width / 0.62)
        let soft  = Image.friendFill
            .renderingMode(.original)
            .resizable().scaledToFit()
            .luminanceToAlpha()
            .blur(radius: 8)
            .frame(width: size.width, height: size.width / 0.62)

        let r1 = ImageRenderer(content: solid)
        let r2 = ImageRenderer(content: soft)
        r1.scale = UIScreen.main.scale
        r2.scale = UIScreen.main.scale
//        maskSolidCG = r1.cgImage
//        maskSoftCG  = r2.cgImage
    }
}

