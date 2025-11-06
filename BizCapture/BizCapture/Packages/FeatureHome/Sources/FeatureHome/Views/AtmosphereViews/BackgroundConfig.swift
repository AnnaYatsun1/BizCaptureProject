//
//  BackgroundConfig.swift
//  FeatureHome
//
//  Created by Анна Яцун on 04.11.2025.
//
import SwiftUI

//public struct BackgroundConfig {
//    public enum Style {
//        case solid(Color)
//        case gradient([Color], start: UnitPoint, end: UnitPoint)
//        case dynamicGradient([Color])
//        case noice(Color, opacity: Double)
//    }
//    
//    var style: Style
//    var animationSpeed: Double
//    var brightnessRange: ClosedRange<Double>
//    
//    init(style: Style, animationSpeed: Double, brightnessRange: ClosedRange<Double>) {
//        self.style = style
//        self.animationSpeed = animationSpeed
//        self.brightnessRange = brightnessRange
//    }
//}
//
//
//public struct BagraundView: View {
//    @State var config: BackgroundConfig
//    
//    @State private var hue: Angle = .degrees(0)      // дрейф оттенка
//    @State private var breathe: CGFloat = 1.0        // “дыхание” яркости
//    @State private var tilt: Angle = .degrees(0)
//    
//    
//    public var body: some View {
//        
//        content.hueRotation(hue)
//            .brightness((Double(breathe) - 1.0) * 0.03)
//            .rotationEffect(tilt)
//            .ignoresSafeArea()
//            .onAppear {
//                          withAnimation(.linear(duration: 60).repeatForever(autoreverses: false)) {
//                              hue = .degrees(360)
//                          }
//                          withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
//                              breathe = 1.06
//                          }
//                          withAnimation(.easeInOut(duration: 18).repeatForever(autoreverses: true)) {
//                              tilt = .degrees(8)
//                          }
//                      }
//        }
//    
//    
//    @ViewBuilder
//    var content: some View {
//        switch config.style {
//        case .solid(let color):
//            color
//                .brightness(Double.random(in: config.brightnessRange))
//                .ignoresSafeArea()
//        case .gradient(let color, let start, let end):
//            LinearGradient(colors: color, startPoint: start, endPoint: end)
//                .brightness(Double.random(in:  config.brightnessRange))
//                .ignoresSafeArea()
//
//        case .dynamicGradient(let colors):
//            AnimationGradient(colors: colors, speed: config.animationSpeed)
//                .rotationEffect(Angle.degrees(0))
//        case .noice(let color, let opacity):
//            color.ignoresSafeArea()
//                .overlay(content: {
//                    NoiseTexture().opacity(opacity)
//                })
//        }
//    }
//}
//
//
//struct AnimationGradient: View {
//    let colors: [Color]
//    let speed: Double
//    @State private var move = false
//    
//    
//    var body: some View {
//        LinearGradient(colors: colors,
//                       startPoint: move ? .topLeading : .bottomTrailing,
//                       endPoint: move ? .bottomTrailing : .topLeading)
//        .animation(.easeOut(duration: speed * 60).repeatForever(autoreverses: true), value: move).onAppear {
//            move = true
//        }.ignoresSafeArea()
//    }
//}
//
//
//struct NoiseTexture: View {
//    var body: some View {
//        TimelineView(.animation) { _ in
//            Canvas { ctx, size in
//                for _ in 0..<2000 {
//                    let x = CGFloat.random(in: 0...size.width)
//                    let y = CGFloat.random(in: 0...size.height)
//                    ctx.fill(Path(ellipseIn: CGRect(x: x, y: y, width: 1.2, height: 1.2)),
//                             with: .color(.white.opacity(.random(in: 0...0.05))))
//                }
//            }
//        }
//    }
//}
//


public struct BackgroundConfig {
    public enum Style {
        case solid(Color)
        case gradient([Color])            // безопасный плавный линейный
        case angular([Color])             // круговой, тоже без hueRotation
        case noise(Color, opacity: Double)
    }
    public var style: Style
    public var animationSpeedc = 1.0   // чем больше — тем медленнее
    public var intensity = 1.0
    public var indicator = false// 0...1 — «громкость» движения
}

public struct BackgroundView: View {
    public let config: BackgroundConfig
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var phase: CGFloat = 0       // 0...1
    @State private var breathe: CGFloat = 1.0   // 1.0...1.03
    

    public init(config: BackgroundConfig) { self.config = config }

    public var body: some View {
        let speed = max(0.1, config.animationSpeedc)
        
        content
        // «дыхание» яркости очень тихое (±2–3%)
            .brightness(reduceMotion ? 0 : Double((breathe - 1.0) * 0.03 * config.intensity))
            .ignoresSafeArea()
            .onAppear {
                guard !reduceMotion else { return }
                withAnimation(.easeInOut(duration: 12 * speed).repeatForever(autoreverses: true)) {
                    breathe = 1.03
                }
                withAnimation(.easeInOut(duration: 22 * speed).repeatForever(autoreverses: true)) {
                    phase = 1
                }
            }
        
        if config.indicator {
            GeometryReader { geo in
                let w = geo.size.width
                let x = w * (0.15 + 0.7 * phase)
                LinearGradient(colors: [.white.opacity(0.22), .clear],
                               startPoint: .leading, endPoint: .trailing)
                .frame(width: 80, height: geo.size.height)
                .blur(radius: 24)
                .offset(x: x - 40) // центр полоски
                .allowsHitTesting(false)
                .transition(.opacity)
            }
            .ignoresSafeArea()
            .blendMode(.screen)
        }
 
    }

    @ViewBuilder
    private var content: some View {
        switch config.style {
        case .solid(let c):
            c

        case .gradient(let colors):
            // ДВИЖЕНИЕ ТОЛЬКО ТОЧЕК, БЕЗ ПОВОРОТА И HUE
            let start = UnitPoint(x: 0.2 + 0.08 * phase * config.intensity,
                                  y: 0.15)
            let end   = UnitPoint(x: 0.8 - 0.08 * phase * config.intensity,
                                  y: 0.95)
            LinearGradient(colors: colors, startPoint: start, endPoint: end)
                .scaleEffect(1.12) // чуть больше экрана, чтобы углы не «лезли»

        case .angular(let colors):
            // медленное «дыхание» угла, без полного оборота
            let base = Angle.degrees(-10)
            let delta = Angle.degrees(20 * config.intensity)
            AngularGradient(gradient: Gradient(colors: colors),
                            center: .center,
                            angle: base + delta * phase)
                .scaleEffect(1.12)

        case .noise(let base, let opacity):
            base.overlay(NoiseTexture().opacity(opacity))
        }
    }
}

// остался твой NoiseTexture
struct NoiseTexture: View {
    var body: some View {
        TimelineView(.animation) { _ in
            Canvas { ctx, size in
                for _ in 0..<1800 {
                    let x = CGFloat.random(in: 0...size.width)
                    let y = CGFloat.random(in: 0...size.height)
                    ctx.fill(Path(ellipseIn: CGRect(x: x, y: y, width: 1.2, height: 1.2)),
                             with: .color(.white.opacity(.random(in: 0...0.05))))
                }
            }
        }
    }
}



public struct LiveBackground: View {
    public enum Style {
        case gradient([Color])
        case angular([Color])
    }

    public let style: Style
    public var speed: Double = 0.8     // увеличь до 0.35, чтобы было ещё заметнее
    public var intensity: CGFloat = 0.8 // амплитуда смещения точек 0…0.4

    public init(style: Style, speed: Double = 0.8, intensity: CGFloat = 0.8) {
        self.style = style
        self.speed = speed
        self.intensity = intensity
    }

    public var body: some View {
        TimelineView(.animation) { ctx in
            let t = ctx.date.timeIntervalSinceReferenceDate * speed
            let p = 0.5 + 0.5 * sin(t) // 0…1

            switch style {
            case .gradient(let colors):
                let amp = max(0, min(0.4, intensity))
                let start = UnitPoint(x: 0.15 + amp * p, y: 0.0)
                let end   = UnitPoint(x: 0.85 - amp * p, y: 0.90)

                LinearGradient(colors: colors, startPoint: start, endPoint: end)
                    .scaleEffect(1.12)           // чтоб не «лезли» углы
                    .ignoresSafeArea()

            case .angular(let colors):
                let base  = Angle.degrees(-10)
                let delta = Angle.degrees(22 * intensity)
                AngularGradient(gradient: Gradient(colors: colors),
                                center: .center,
                                angle: base + delta * p)
                    .scaleEffect(1.12)
                    .ignoresSafeArea()
            }
        }
    }
}



extension LiveBackground {
    @ViewBuilder
    public func withProbe() -> some View {
        ZStack {
            self
            TimelineView(.animation) { ctx in
                let t = ctx.date.timeIntervalSinceReferenceDate * speed
                let p = 0.5 + 0.5 * sin(t)
                GeometryReader { geo in
                    let x = geo.size.width * (0.15 + 0.7 * p)
                    LinearGradient(colors: [.white.opacity(0.22), .clear],
                                   startPoint: .leading, endPoint: .trailing)
                        .frame(width: 80, height: geo.size.height)
                        .blur(radius: 24)
                        .offset(x: x - 40)
                        .blendMode(.screen)
                        .allowsHitTesting(false)
                }.ignoresSafeArea()
            }
        }
    }
}


//
//struct FogLayer: View {
//    var color: Color = .white
//    var maxOpacity: Double = 0.16   // верхняя граница «дымки»
//    var speed: Double = 0.22        // больше → медленнее
//    var vignette: Double = 0.22     // затемнение краёв
//
//    var body: some View {
//        TimelineView(.animation) { ctx in
//            let t = ctx.date.timeIntervalSinceReferenceDate
//            let p = 0.5 + 0.5 * sin(t * (1.0 / max(0.01, speed))) // 0…1
//
//            ZStack {
//                // мягкий дым (два широких RadialGradient)
//                RadialGradient(colors: [
//                    color.opacity(maxOpacity * 0.75 * p),
//                    .clear
//                ], center: .topLeading, startRadius: 60, endRadius: 600)
//                .blendMode(.screen)
//
//                RadialGradient(colors: [
//                    color.opacity(maxOpacity * 0.55 * (1 - p)),
//                    .clear
//                ], center: .bottomTrailing, startRadius: 80, endRadius: 720)
//                .blendMode(.screen)
//
//                // лёгкая виньетка по краям — глубина кадра
//                LinearGradient(
//                    colors: [.black.opacity(vignette), .clear, .black.opacity(vignette)],
//                    startPoint: .leading, endPoint: .trailing
//                )
//                .allowsHitTesting(false)
//                .blendMode(.multiply)
//                .opacity(0.9)
//            }
//            .ignoresSafeArea()
//        }
//    }
//}




//struct AtmosBackgroundPreset: View {
//    // Палитры А и B: остаёмся в теплых цветах, без hueRotation
//    var from: [UIColor]
//    var to:   [UIColor]
//
//    // "Громкость" эффектов
//    var speed: Double = 0.25      // больше → медленнее
//    var moveIntensity: CGFloat = 0.28   // 0…0.6
//    var morphIntensity: CGFloat = 0.55  // 0…1, насколько далеко между палитрами
//    var fogOpacity: Double = 0.14       // максимум тумана 0…0.25
//    var sweepOpacity: Double = 0.22     // яркость световой волны
//
//    var body: some View {
//        ZStack {
//            ColorMorphBackground(from: from, to: to,
//                                 speed: speed, intensity: morphIntensity, move: true)
//
//            LightSweepLayer(opacity: sweepOpacity, speed: speed * 0.9)
//
////            FogLayer(color: .white, maxOpacity: fogOpacity, speed: speed * 1.2, vignette: 0.18)
//        }
//        .ignoresSafeArea()
//    }
//}

// MARK: - Building blocks

private func lerp(_ a: UIColor, _ b: UIColor, t: CGFloat) -> Color {
    var ar: CGFloat=0, ag: CGFloat=0, ab: CGFloat=0, aa: CGFloat=0
    var br: CGFloat=0, bg: CGFloat=0, bb: CGFloat=0, ba: CGFloat=0
    a.getRed(&ar, green: &ag, blue: &ab, alpha: &aa)
    b.getRed(&br, green: &bg, blue: &bb, alpha: &ba)
    return Color(red: Double(ar + (br - ar)*t),
                 green: Double(ag + (bg - ag)*t),
                 blue: Double(ab + (bb - ab)*t),
                 opacity: Double(aa + (ba - aa)*t))
}

struct ColorMorphBackground: View {
    let from: [UIColor]
    let to:   [UIColor]
    var speed: Double = 0.25
    var intensity: CGFloat = 0.6
    var move: Bool = true

    var body: some View {
        TimelineView(.animation) { ctx in
            let t  = ctx.date.timeIntervalSinceReferenceDate
            let p  = CGFloat(0.5 + 0.5 * sin(t / max(0.01, speed))) // 0…1
            let mx = p * intensity

            let c0 = lerp(from[0], to[0], t: mx)
            let c1 = lerp(from[1], to[1], t: mx)

            let shift = move ? 0.12 * p : 0
            let start = UnitPoint(x: 0.22 + shift, y: 0.10)
            let end   = UnitPoint(x: 0.78 - shift, y: 0.92)

            LinearGradient(colors: [c0, c1], startPoint: start, endPoint: end)
                .scaleEffect(1.12)
                .ignoresSafeArea()
        }
    }
}

public struct LightSweepLayer: View {
    var opacity: Double = 0.22
    var speed: Double = 0.22

    public var body: some View {
        TimelineView(.animation) { ctx in
            GeometryReader { geo in
                let t = ctx.date.timeIntervalSinceReferenceDate
                let p = 0.5 + 0.5 * sin(t / max(0.01, speed)) // 0…1
                let x = geo.size.width * (0.15 + 0.7 * p)

                LinearGradient(colors: [.white.opacity(opacity), .clear],
                               startPoint: .leading, endPoint: .trailing)
                    .frame(width: max(120, geo.size.width * 0.28), height: geo.size.height)
                    .blur(radius: 36)
                    .offset(x: x - geo.size.width * 0.14)
                    .blendMode(.screen)
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea()
        }
    }
}

struct FogLayer: View {
    var color: Color = .white
    var maxOpacity: Double = 0.14
    var speed: Double = 0.28
    var vignette: Double = 0.18

    var body: some View {
        TimelineView(.animation) { ctx in
            let t = ctx.date.timeIntervalSinceReferenceDate
            let p = 0.5 + 0.5 * sin(t / max(0.01, speed))

            ZStack {
                RadialGradient(colors: [color.opacity(maxOpacity * 0.7 * p), .clear],
                               center: .topLeading, startRadius: 60, endRadius: 620)
                    .blendMode(.screen)
                RadialGradient(colors: [color.opacity(maxOpacity * 0.55 * (1 - p)), .clear],
                               center: .bottomTrailing, startRadius: 80, endRadius: 700)
                    .blendMode(.screen)

                LinearGradient(colors: [.black.opacity(vignette), .clear, .black.opacity(vignette)],
                               startPoint: .leading, endPoint: .trailing)
                    .blendMode(.multiply)
                    .opacity(0.85)
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea()
        }
    }
}


struct SoftConeLightLayer: View {
    var opacity: Double = 0.20          // яркость света
    var baseAngle: Angle = .degrees(-18)
    var swing: Angle = .degrees(10)     // амплитуда раскачивания
    var speed: Double = 0.22            // больше → медленнее
    var widthFactor: CGFloat = 0.75     // ширина луча от ширины экрана
    var yOffset: CGFloat = -0.06        // смещение вверх/вниз (от высоты)

    var body: some View {
        TimelineView(.animation) { ctx in
            GeometryReader { geo in
                let t = ctx.date.timeIntervalSinceReferenceDate
                let p = sin(t / max(0.01, speed)) // -1…1
                let angle = baseAngle + swing * p

                // широкий размазанный конус
                LinearGradient(colors: [.white.opacity(opacity), .clear],
                               startPoint: .top, endPoint: .bottom)
                    .frame(width: geo.size.width * widthFactor,
                           height: geo.size.height * 1.4)
                    .blur(radius: 50)
                    .rotationEffect(angle, anchor: .topLeading)
                    .offset(x: geo.size.width * 0.04,
                            y: geo.size.height * (0.2 + yOffset))
                    .blendMode(.screen)
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea()
        }
    }
}

struct MistFogLayer: View {
    var color: Color = .white
    var haze: Double = 0.18      // плотность дыма (0…0.3)
    var vignette: Double = 0.22  // затемнение краёв
    var speed: Double = 0.30

    var body: some View {
        TimelineView(.animation) { ctx in
            let t = ctx.date.timeIntervalSinceReferenceDate
            let p = 0.5 + 0.5 * sin(t / max(0.01, speed)) // 0…1

            ZStack {
                // дрейфующие облачка (два больших радиальных пятна)
                RadialGradient(colors: [color.opacity(haze * 0.8 * p), .clear],
                               center: UnitPoint(x: 0.15 + 0.1*p, y: 0.2),
                               startRadius: 60, endRadius: 640)
                    .blur(radius: 6)
                    .blendMode(.screen)

                RadialGradient(colors: [color.opacity(haze * 0.6 * (1 - p)), .clear],
                               center: UnitPoint(x: 0.85 - 0.1*p, y: 0.85),
                               startRadius: 80, endRadius: 740)
                    .blur(radius: 8)
                    .blendMode(.screen)

                // мягкий центральный glow — собирает картинку
                RadialGradient(colors: [.white.opacity(0.10), .clear],
                               center: .center, startRadius: 20, endRadius: 420)
                    .blendMode(.screen)

                // виньетка
                Rectangle()
                    .fill(
                        RadialGradient(colors: [.black.opacity(0), .black.opacity(vignette)],
                                       center: .center, startRadius: 0, endRadius: 900)
                    )
                    .blendMode(.multiply)
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea()
        }
    }
}


struct AtmosBackgroundPreset: View {
    var from: [UIColor]
    var to:   [UIColor]
    var speed: Double = 0.25
    var morphIntensity: CGFloat = 0.55

    var body: some View {
        ZStack {
            // плавный морфинг тёплой палитры
            ColorMorphBackground(from: from, to: to,
                                 speed: speed, intensity: morphIntensity, move: true)

            // 🔥 мягкий конусный свет вместо вертикальной полосы
            SoftConeLightLayer(opacity: 0.18,
                               baseAngle: .degrees(-16),
                               swing: .degrees(9),
                               speed: speed * 0.9,
                               widthFactor: 0.78,
                               yOffset: -0.04)

            // 🌫️ заметная дымка + виньетка + центр-glow
            MistFogLayer(color: .white, haze: 0.16, vignette: 0.20, speed: speed * 1.1)
        }
        .ignoresSafeArea()
    }
}




public struct AccentConfig {
    public enum Kind { case shimmerWave, pulseRing, horizonGlow }
    public var kind: Kind = .horizonGlow
    public var color: Color = .white
    public var interval: ClosedRange<Double> = 0...12  // раз в N секунд
    public var strength: CGFloat = 1.0                 // 0…1
    public init() {}
}

public struct AccentLayer: View {
    let config: AccentConfig
    let trigger: Bool   // можно включать извне (например, при старте/ответе)

    @State private var seed: Int = Int.random(in: 0...9999)
    @State private var localTrigger: Bool = false

    public init(config: AccentConfig, trigger: Bool) {
        self.config = config; self.trigger = trigger
    }

    public var body: some View {
        TimelineView(.animation) { ctx in
            ZStack {
                switch config.kind {
                case .shimmerWave:
                    shimmerWave(ctx.date)

                case .pulseRing:
                    pulseRing(ctx.date)

                case .horizonGlow:
                    LinearGradient(colors: [config.color.opacity(0.14 * config.strength), .clear],
                                   startPoint: .bottom, endPoint: .center)
                        .blur(radius: 22)
                        .blendMode(.screen)
                }
            }
            .ignoresSafeArea()
            .task {
                // редкие случайные триггеры
                while true {
                    let wait = Double.random(in: config.interval)
                    try? await Task.sleep(nanoseconds: UInt64(wait * 1_000_000_000))
                    withAnimation(.easeInOut(duration: 0.8)) { localTrigger.toggle() }
                }
            }
        }
        .onChange(of: trigger) { _ in
            // внешний импульс (например, ассистент закончил фразу)
            withAnimation(.easeInOut(duration: 0.6)) { localTrigger.toggle() }
        }
    }

    // — волна отблеска, проходящая сверху вниз
    @ViewBuilder private func shimmerWave(_ date: Date) -> some View {
        GeometryReader { geo in
            let t = date.timeIntervalSinceReferenceDate
            let p = (sin(t * 0.6) * 0.5 + 0.5) + (localTrigger ? 0.6 : 0)
            LinearGradient(colors: [config.color.opacity(0.18 * Double(config.strength)), .clear],
                           startPoint: .top, endPoint: .bottom)
                .frame(height: max(120, geo.size.height * 0.25))
                .blur(radius: 28)
                .offset(y: -geo.size.height * 0.2 + p * geo.size.height * 0.6)
                .blendMode(.screen)
                .allowsHitTesting(false)
        }
    }

    // — мягкое расширяющееся кольцо из центра
    @ViewBuilder private func pulseRing(_ date: Date) -> some View {
        GeometryReader { geo in
            let t = date.timeIntervalSinceReferenceDate
            let p = (sin(t * 0.8) * 0.5 + 0.5) + (localTrigger ? 0.6 : 0)
            Circle()
                .strokeBorder(config.color.opacity(0.22 * Double(config.strength)), lineWidth: 2)
                .frame(width: 40 + p * geo.size.width * 0.6,
                       height: 40 + p * geo.size.width * 0.6)
                .blur(radius: 10)
                .blendMode(.screen)
                .position(x: geo.size.width/2, y: geo.size.height*0.55)
        }
    }
}
public struct ParticleConfig {
    public enum Kind { case dust, bokeh, sparks }
    public var kind: Kind = .dust
    public var count: Int = 18
    public var maxSize: CGFloat = 28
    public var baseOpacity: Double = 0.12
    public var speed: Double = 0.54        // больше → медленнее
    public var color: Color = .white
    public init() {}
}

public struct ParticleLayer: View {
    let config: ParticleConfig
    let amplitude: CGFloat   // 0…1

    public init(config: ParticleConfig, amplitude: CGFloat) {
        self.config = config; self.amplitude = amplitude
    }

    public var body: some View {
        TimelineView(.animation) { ctx in
            Canvas { ctx2, size in
                let t = ctx.date.timeIntervalSinceReferenceDate / max(0.01, config.speed)
                for i in 0..<config.count {
                    // псевдослучайные сиды
                    let r1 = Double((i * 127 + 31) % 1000) / 1000.0
                    let r2 = Double((i * 233 + 73) % 1000) / 1000.0
                    let phase = sin(t + r1 * .pi * 2) * 0.5 + 0.5   // 0…1
                    let x = CGFloat(r1) * size.width
                    var y = CGFloat(r2) * size.height
                    let boost = 1 + 0.7 * amplitude

                    switch config.kind {
                    case .dust:
                        y -= CGFloat(phase) * size.height * 0.18 * boost
                    case .bokeh:
                        y -= CGFloat(phase) * size.height * 0.12 * boost
                    case .sparks:
                        y -= CGFloat(phase) * size.height * 0.28 * boost
                    }

                    let sFactor: CGFloat
                    switch config.kind {
                    case .dust:  sFactor = 0.6
                    case .bokeh: sFactor = 1.4
                    case .sparks:sFactor = 0.8
                    }
                    let s = CGFloat(10 + phase * Double(config.maxSize) * Double(sFactor))
                    let alpha = config.baseOpacity * (0.6 + 0.4 * Double(phase)) * Double(boost)

                    let rect = CGRect(x: x, y: y, width: s, height: s)
//                    let gradient: GraphicsGradient = .radialGradient(
//                        .init(colors: [config.color.opacity(alpha), .clear]),
//                        center: rect.center, startRadius: 0, endRadius: s/2
//                    )
//                    ctx2.fill(Path(ellipseIn: rect), with: .gradient(gradient))
                }
            }
        }
        .blendMode(.screen)
        .ignoresSafeArea()
    }
}
private extension CGRect { var center: CGPoint { CGPoint(x: midX, y: midY) } }


public struct LightConfig {
    public enum Kind { case cone, halo, stripe }
    public var kind: Kind = .cone
    public var color: Color = .white
    public var baseAngle: Angle = .degrees(-16)
    public var swing: Angle = .degrees(8)      // амплитуда покачивания
    public var speed: Double = 0.22            // больше → медленнее
    public var intensity: CGFloat = 0.18       // базовая яркость (0…1)
    public init() {}
}

public struct LightLayer: View {
    let config: LightConfig
    let amplitude: CGFloat   // 0…1

    public init(config: LightConfig, amplitude: CGFloat) {
        self.config = config; self.amplitude = amplitude
    }

    public var body: some View {
        TimelineView(.animation) { ctx in
            GeometryReader { geo in
                let t = ctx.date.timeIntervalSinceReferenceDate
                let p = sin(t / max(0.01, config.speed)) // -1…1
                let boost = 1 + 0.8 * amplitude          // реакция на голос

                switch config.kind {
                case .cone:
                    LinearGradient(colors: [config.color.opacity(Double(config.intensity) * 0.9 * boost),
                                            .clear],
                                   startPoint: .top, endPoint: .bottom)
                        .frame(width: geo.size.width * 0.78, height: geo.size.height * 1.4)
                        .blur(radius: 50)
                        .rotationEffect(config.baseAngle + config.swing * p, anchor: .topLeading)
                        .offset(x: geo.size.width * 0.04, y: geo.size.height * 0.16)
                        .blendMode(.screen)

                case .halo:
                    RadialGradient(colors: [config.color.opacity(Double(config.intensity) * 0.7 * boost), .clear],
                                   center: .center, startRadius: 40, endRadius: 480)
                        .blur(radius: 12)
                        .blendMode(.screen)

                case .stripe:
                    LinearGradient(colors: [config.color.opacity(Double(config.intensity) * 0.8 * boost), .clear],
                                   startPoint: .leading, endPoint: .trailing)
                        .frame(width: geo.size.width * 0.28, height: geo.size.height)
                        .blur(radius: 34)
                        .offset(x: geo.size.width * (0.15 + 0.35 * (p * 0.5 + 0.5)))
                        .blendMode(.screen)
                }
            }.ignoresSafeArea()
        }
    }
}
