//
//  DustBokeh.swift
//  FeatureHome
//
//  Created by Анна Яцун on 06.11.2025.
//
public struct DustBokeh: View {
    var color: Color
    var speed: Double = 14.0
    var density: CGFloat = 30000      // чем меньше — тем больше частиц
    public var body: some View {
        TimelineView(.animation) { ctx in
            Canvas { c, size in
                let t = ctx.date.timeIntervalSinceReferenceDate / speed
                let count = Int(max(8, size.width * size.height / density))
                for i in 0..<count {
                    let r1 = Double((i &* 127 &+ 37) % 1000) / 1000.0
                    let r2 = Double((i &* 233 &+ 71) % 1000) / 1000.0
                    let phase = sin(t + r1 * .pi * 2) * 0.5 + 0.5
                    let parallax = 0.75 + 0.5 * r2
                    let driftX = sin(t * 0.15 + r1 * 8) * 8
                    let x = CGFloat(r1) * size.width + CGFloat(driftX) * parallax
                    let y = CGFloat(r2) * size.height - CGFloat(phase) * size.height * 0.18 * parallax
                    let s = CGFloat(3 + phase * 8) * parallax
                    let alpha = (0.04 + 0.07 * phase) * (0.7 + 0.3 * parallax)
                    let rect = CGRect(x: x, y: y, width: s, height: s)
                    let shading = GraphicsContext.Shading.radialGradient(
                        Gradient(colors: [color.opacity(alpha), .clear]),
                        center: CGPoint(x: rect.midX, y: rect.midY),
                        startRadius: 0, endRadius: s / 2
                    )
                    c.fill(Path(ellipseIn: rect), with: shading)
                }
            }
            .blendMode(.screen)
            .allowsHitTesting(false)
        }
    }
}
