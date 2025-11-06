//
//  NightAtmosphere.swift
//  FeatureHome
//
//  Created by Анна Яцун on 06.11.2025.
//

public struct NightAtmosphere: View {
    public var body: some View {
        TimelineView(.animation) { ctx in
            let t = ctx.date.timeIntervalSinceReferenceDate
            let p = 0.5 + 0.5 * sin(t / 8.0)
            ZStack {
                LinearGradient(
                    colors: [
                        Color(hue: 0.72, saturation: 0.55, brightness: 0.22),
                        Color(hue: 0.90, saturation: 0.35, brightness: 0.10)
                    ],
                    startPoint: .topTrailing, endPoint: .bottomLeading
                )
                // мягкий конус
                LinearGradient(colors: [.white.opacity(0.12 + 0.06 * p), .clear],
                               startPoint: .center, endPoint: .bottom)
                    .blur(radius: 48)
                    .rotationEffect(.degrees(-16), anchor: .topLeading)
                    .offset(x: 20, y: 120)
                    .blendMode(.screen)
                // дымка
                RadialGradient(colors: [.white.opacity(0.10 * p), .clear],
                               center: UnitPoint(x: 0.18 + 0.06 * p, y: 0.22),
                               startRadius: 120, endRadius: 520)
                    .blendMode(.screen)
                RadialGradient(colors: [.white.opacity(0.08 * (1 - p)), .clear],
                               center: UnitPoint(x: 0.82 - 0.04 * p, y: 0.86),
                               startRadius: 80, endRadius: 600)
                    .blendMode(.screen)
                // виньетка
                Rectangle()
                    .fill(
                        RadialGradient(colors: [.black.opacity(0), .black.opacity(0.28)],
                                       center: .center, startRadius: 0, endRadius: 900)
                    )
                    .blendMode(.multiply)
            }
            .ignoresSafeArea()
        }
    }
}
