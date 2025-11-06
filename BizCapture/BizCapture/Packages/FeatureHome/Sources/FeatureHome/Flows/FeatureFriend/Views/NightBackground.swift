//
//  NightBackground.swift
//  FeatureHome
//
//  Created by Анна Яцун on 06.11.2025.
//

public struct NightBackground: View {
   public  var body: some View {
        TimelineView(.animation) { ctx in
            let t = ctx.date.timeIntervalSinceReferenceDate
            let p = 0.5 + 0.5 * sin(t / 7.0)

            ZStack {
                LinearGradient(
                    colors: [
                        Color(hue: 0.72, saturation: 0.55, brightness: 0.22),
                        Color(hue: 0.90, saturation: 0.35, brightness: 0.10)
                    ],
                    startPoint: .topTrailing, endPoint: .bottomLeading
                )
                .ignoresSafeArea()

                LinearGradient(
                    colors: [.white.opacity(0.10 + 0.05*p), .clear],
                    startPoint: .top, endPoint: .bottom
                )
                .blur(radius: 48)
                .rotationEffect(.degrees(-14), anchor: .topLeading)
                .offset(x: 24, y: 120)
                .blendMode(.screen)
                .ignoresSafeArea()

                Rectangle()
                    .fill(
                        RadialGradient(colors: [.black.opacity(0), .black.opacity(0.28)],
                                       center: .center, startRadius: 0, endRadius: 900)
                    )
                    .blendMode(.multiply)
                    .ignoresSafeArea()
            }
        }
    }
}
