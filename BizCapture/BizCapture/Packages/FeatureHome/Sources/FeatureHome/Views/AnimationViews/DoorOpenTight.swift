//
//  DoorOpenTight.swift
//  FeatureHome
//
//  Created by Анна Яцун on 04.11.2025.
//
import SwiftUI

public struct DoorOpenTight<World: View>: View {
    let duration: Double
    let glowColor: Color
    let onFinished: () -> Void
    @ViewBuilder let world: (_ progress: CGFloat) -> World   // что за дверью (картинка/вью)

    @State private var p: CGFloat = 0 // 0...1

    public init(
        duration: Double = 1.0,
        glowColor: Color = .white,
        @ViewBuilder world: @escaping (CGFloat) -> World,
        onFinished: @escaping () -> Void
    ) {
        self.duration = duration
        self.glowColor = glowColor
        self.world = world
        self.onFinished = onFinished
    }

    public var body: some View {
        GeometryReader { geo in
            let screen = geo.size
            // Делаем дверь крупной, но внутри экрана
            let doorH = screen.height * 0.86
            let doorW = doorH * 0.6
            let doorX = (screen.width  - doorW) / 2
            let doorY = (screen.height - doorH) / 2
            let slitW = max(8, doorW * (0.05 + 0.95 * p)) // растущая «щель»

            ZStack {
                // лёгкое затемнение фона сцены
                Color.black.opacity(0.18 + 0.2 * p).ignoresSafeArea()

                // КОНТЕЙНЕР ДВЕРИ: всё внутри — обрезаем рамкой двери
                ZStack {
                    // 1) МИР ЗА ДВЕРЬЮ — ПОД ДВЕРЬЮ, только через щель
                    world(p)
                        .scaleEffect(1.04 - 0.02 * p)
                        .offset(x: -8 + 8 * p) // лёгкий параллакс
                        .mask(
                            // маска-щель внутри двери
                            HStack(spacing: 0) {
                                Rectangle()
                                    .frame(width: slitW)
                                Spacer(minLength: 0)
                            }
                        )

                    // 2) МЯГКИЙ ЛУЧ (только в области двери)
                    RadialGradient(
                        colors: [
                            glowColor.opacity(0.70 * p),
                            glowColor.opacity(0.18 * p),
                            .clear
                        ],
                        center: .leading, startRadius: 6, endRadius: max(doorW, doorH)
                    )
                    .blendMode(.screen)
                    .opacity(min(1, p * 1.05))

                    // 3) BLOOM вдоль щели
                    LinearGradient(
                        colors: [
                            glowColor.opacity(0.55 * p),
                            glowColor.opacity(0.18 * p),
                            .clear
                        ],
                        startPoint: .leading, endPoint: .trailing
                    )
                    .frame(width: slitW * 0.7, height: doorH * 0.9)
                    .blur(radius: 22 + 10 * p)
                    .opacity(0.9 * p)
                    .offset(x: slitW * 0.35 - doorW * 0.5)
                }
                .frame(width: doorW, height: doorH)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .position(x: doorX + doorW/2, y: doorY + doorH/2)

                // 4) ПОЛОТНО ДВЕРИ — поверх
                Image.roomDoor // твой ассет
                    .resizable()
                    .scaledToFill()
                    .frame(width: doorW, height: doorH)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .modifier(Door3DEffect(angle: -Double.pi * 0.6 * p)) // ~ -108°
                    .shadow(color: .black.opacity(0.35),
                            radius: 14 + 8 * p, x: 18 * p, y: 6)

                // 5) тонкий rim-light по кромке двери
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(glowColor.opacity(0.32 * p), lineWidth: 2)
                    .frame(width: doorW, height: doorH)
                    .blur(radius: 3 + 2 * p)
                    .blendMode(.screen)
            }
            .frame(width: screen.width, height: screen.height)
            .ignoresSafeArea()
            .onAppear {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                withAnimation(.easeInOut(duration: duration)) { p = 1 }
                DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.1) {
                    onFinished()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

