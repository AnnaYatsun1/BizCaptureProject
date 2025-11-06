//
//  FrieendRoomView.swift
//  FeatureHome
//
//  Created by Анна Яцун on 03.11.2025.
//

import SwiftUI
import ComposableArchitecture

public struct FrieendRoomView: View {
    public let store: StoreOf<FriendStore>
    @State private var theme: RoomTheme = .friend
    @State private var voiceAmp: CGFloat = 0.2
    
    public init(store: StoreOf<FriendStore>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            NightAtmosphere()
            DustBokeh(color: .white, speed: theme.dustSpeed)
            SilhouetteNeon(theme: .friend).padding(.horizontal, 36)

//            LightLayer(config: {
//                var c = LightConfig()
//                c.kind = .cone
//                c.intensity = 0.28
//                c.baseAngle = .degrees(-14)
//                c.swing = .degrees(9)
//                return c
//                // voiceAmplitude
//            }(), amplitude: CGFloat.init(1))
//
//            ParticleLayer(config: {
//                var p = ParticleConfig()
//                p.kind = .dust
//                p.count = 10
//                p.maxSize = 36
//                p.baseOpacity = 0.12
//                return p
//               // voiceAmplitude//
//            }(), amplitude: CGFloat.init(1))

//            AccentLayer(config: {
//                var a = AccentConfig()
//                a.kind = .horizonGlow
//                a.strength = 0.9
//                return a
//            }(), trigger: true)
//            AtmosBackgroundPreset(
//                from: [UIColor(red:1, green:0.80, blue:0.75, alpha:1),
//                       UIColor(red:1, green:0.42, blue:0.58, alpha:1)],
//                to:   [UIColor(red:1, green:0.72, blue:0.65, alpha:1),
//                       UIColor(red:1, green:0.35, blue:0.55, alpha:1)],
//                speed: 0.22,
////                moveIntensity: 0.28,
//                morphIntensity: 0.55
////                fogOpacity: 0.12,
////                sweepOpacity: 0.20
//            )
//            LiveBackground(style: .gradient([.white, .pink]), speed: 0.3, intensity: 0.35)
////                .withProbe()
//            FogLayer(color: .white, maxOpacity: 0.14, speed: 0.28, vignette: 0.18)
//            VStack {
      
                //            LiveBackground(
                //                style: .gradient([
                //                    Color(red: 1.00, green: 0.72, blue: 0.27),
                //                    Color(red: 1.00, green: 0.24, blue: 0.41)
                //                ]),
                //                speed: 0.8,        // сделай побольше, чтобы точно увидеть
                //                intensity: 0.30
                //            )
                //            BackgroundView(
                //              config: .init(
                //                style: .gradient([
                //                    Color.white,
                //                    Color.black
                //                ]),
                //                animationSpeedc: 0.9,   // медленно
                //                intensity: 1,
                //                indicator: true// очень тихо
                //              )
                //            )
                Button(action: {
                    store.send(.closeScreen)
                }, label: {
                    Text("Close")
                })
//            }
        }   .task {
            // демо: «дыхание» от голоса
            while true {
                withAnimation(.easeInOut(duration: 1.0)) {
                    voiceAmp = .random(in: 0.0...1.0)
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
        }
    }
}








//private extension CGRect { var center: CGPoint { CGPoint(x: midX, y: midY) } }

//struct NightAtmosphere: View {
//    var body: some View {
//        TimelineView(.animation) { ctx in
//            let t = ctx.date.timeIntervalSinceReferenceDate
//            let p = 0.5 + 0.5 * sin(t / 6.0) // очень медленно
//
//            ZStack {
//                // Глубокий ночной градиент
//                LinearGradient(
//                    colors: [Color(hue: 0.72, saturation: 0.55, brightness: 0.22),
//                             Color(hue: 0.90, saturation: 0.35, brightness: 0.10)],
//                    startPoint: .topTrailing, endPoint: .bottomLeading
//                )
//                .ignoresSafeArea()
//
//                // Мягкий “конус” света слева сверху
//                LinearGradient(colors: [.white.opacity(0.12 + 0.06 * p), .clear],
//                               startPoint: .center, endPoint: .bottom)
//                    .blur(radius: 48)
//                    .rotationEffect(.degrees(-16), anchor: .topLeading)
//                    .offset(x: 20, y: 120)
//                    .blendMode(.screen)
//                    .ignoresSafeArea()
//
//                // Два больших радиальных «облака» как дымка
//                RadialGradient(colors: [.white.opacity(0.10 * p), .clear],
//                               center: UnitPoint(x: 0.18 + 0.06 * p, y: 0.22),
//                               startRadius: 120, endRadius: 520)
//                    .blendMode(.screen)
//                RadialGradient(colors: [.white.opacity(0.08 * (1 - p)), .clear],
//                               center: UnitPoint(x: 0.82 - 0.04 * p, y: 0.86),
//                               startRadius: 80, endRadius: 600)
//                    .blendMode(.screen)
//
//                // Виньетка для глубины
//                Rectangle()
//                    .fill(
//                        RadialGradient(colors: [.black.opacity(0), .black.opacity(0.28)],
//                                       center: .center, startRadius: 0, endRadius: 900)
//                    )
//                    .blendMode(.multiply)
//                    .ignoresSafeArea()
//            }
//        }
//    }
//}




//struct DustBokeh: View {
//    var color: Color
//    var count: Int = 18
//    var speed: Double = 14.0
//
//    var body: some View {
//        TimelineView(.animation) { ctx in
//            Canvas { c, size in
//                let t = ctx.date.timeIntervalSinceReferenceDate / speed
//                for i in 0..<count {
//                    let r1 = Double((i &* 127 &+ 37) % 1000) / 1000.0
//                    let r2 = Double((i &* 233 &+ 71) % 1000) / 1000.0
//                    let phase = sin(t + r1 * .pi * 2) * 0.5 + 0.5
//                    let x = CGFloat(r1) * size.width
//                    let y = CGFloat(r2) * size.height - CGFloat(phase) * size.height * 0.18
//                    let s = CGFloat(4 + phase * 10)
//                    let alpha = 0.05 + 0.08 * phase
//
//                    let rect = CGRect(x: x, y: y, width: s, height: s)
//                    let shading = GraphicsContext.Shading.radialGradient(
//                        Gradient(colors: [color.opacity(alpha), .clear]),
//                        center: CGPoint(x: rect.midX, y: rect.midY),
//                        startRadius: 0, endRadius: s/2
//                    )
//                    c.fill(Path(ellipseIn: rect), with: shading)
//                }
//            }
//            .blendMode(.screen)
//            .ignoresSafeArea()
//        }
//    }
//}






// MARK: - Частицы/боке (дешёвый Canvas)


// MARK: - Ночной фон


// MARK: - Неоновый силуэт с кэшем масок
//struct SilhouetteNeon: View {
//    let theme: RoomTheme
//    var gain: CGFloat = 1.8
//    // 1.0 ... 2.0 — общая яркость
//    
//    @State private var maskSolidCG: CGImage?
//    @State private var maskSoftCG:  CGImage?
//    
//    var body: some View {
//        GeometryReader { geo in
//            let size = geo.size
//            
//            TimelineView(.animation) { ctx in
////                // дыхание + лёгкий фликер (если включено Reduce Motion — плавнее)
//                let reduce = UIAccessibility.isReduceMotionEnabled
//                let breathT = ctx.date.timeIntervalSinceReferenceDate / theme.breathePeriod
////                let breathe = 0.6 + 0.12 * breath
//                let breathe = 0.88 + 0.12 * gain
//                let flicker = 0.8 + 0.04 * sin(gain*6.28)
////                let flicker = reduce ? 1.0 : (0.98 + 0.02 * sin(breathT * 12.0))
//                
//                configure(w: size.width, breathe: breathe, flicker: flicker, t:  ctx.date.timeIntervalSinceReferenceDate)
////
////                ZStack {
////                    if let solid = maskSolidCG, let soft = maskSoftCG {
////                        let maskSolid = Image(decorative: solid, scale: UIScreen.main.scale)
////                        let maskSoft  = Image(decorative: soft,  scale: UIScreen.main.scale)
////                        let w = size.width
////                        // Дальний ореол
////                        RadialGradient(colors: [Color.black.opacity(0.12 * breathe), .clear],
////                                       center: .center, startRadius: w * 0.54, endRadius: w * 2.05)
////                            .blur(radius: 90)
////                            .blendMode(.plusLighter)
////                            .mask(maskSoft)
////                        Color.white.opacity(0.12 * breathe * flicker)
////                            .blur(radius: 120)
////                            .mask(maskSoft.scaleEffect(1.06))
////                            .blendMode(.plusLighter)
////                        // Кольцевая маска (для канта)
////                        let ringMask = maskSolid
////                            .overlay(maskSolid.blur(radius: 4.5).blendMode(.destinationOut))
////                            .compositingGroup()
////                        // Неоновый кант (тройной)
////                        theme.base.opacity(0.95 * breathe)
////                            .blur(radius: 4)
////                            .mask(ringMask)
////                            .blendMode(.plusLighter)
////                        theme.base.opacity(0.80 * breathe)
////                            .blur(radius: 1.4)
////                            .mask(ringMask)
////                            .blendMode(.plusLighter)
////                        theme.base.opacity(0.35 * breathe)
////                            .blur(radius: 0.7)
////                            .mask(ringMask)
////                            .blendMode(.plusLighter)
////                        // Тело
////                        LinearGradient(colors: [
////                            theme.base.opacity(min(0.95 * gain, 1.0)),
////                            theme.base.opacity(0.92)
////                        ], startPoint: .top, endPoint: .bottom)
////                        .opacity(reduce ? 1.0 : (0.98 + 0.02 * breathe))
////                        .blur(radius: reduce ? 2 : (2 + 1.0 * breathe))
////                        .mask(maskSolid)
////                        // Тёплое ядро
////                        RadialGradient(colors: [theme.base.opacity(0.55 * gain * breathe), .clear],
////                                       center: .center, startRadius: 0, endRadius: w * 0.52)
////                            .blendMode(.screen)
////                            .mask(maskSolid)
////                        // Глубина
////                        RadialGradient(colors: [Color.white.opacity(0.24), .clear],
////                                       center: .center, startRadius: w*0.12, endRadius: w*0.72)
////                            .blur(radius: 18)
////                            .blendMode(.softLight)
////                            .mask(maskSolid.blur(radius: 4))
////                    }
////                }
////                .compositingGroup()
////                .drawingGroup(opaque: false, colorMode: .linear)
////                .onAppear { makeMasks(for: size) }
////                .onChange(of: size) { makeMasks(for: $0) }
//            }
//        }
//        .aspectRatio(0.62, contentMode: .fit)
//    }
//    
//    // Маски рендерим один раз под текущий размер
//    private func makeMasks(for size: CGSize) {
//        guard size.width > 0 else { return }
//        let solid = Image.friendFill
//            .renderingMode(.original)
//            .resizable().scaledToFit()
//            .luminanceToAlpha()
//            .blur(radius: 0.5)
//            .frame(width: size.width, height: size.width / 0.62)
//        let soft  = Image.friendFill
//            .renderingMode(.original)
//            .resizable().scaledToFit()
//            .luminanceToAlpha()
//            .blur(radius: 8)
//            .frame(width: size.width, height: size.width / 0.62)
//        
//        let r1 = ImageRenderer(content: solid)
//        let r2 = ImageRenderer(content: soft)
//        r1.scale = UIScreen.main.scale
//        r2.scale = UIScreen.main.scale
//        maskSolidCG = r1.cgImage
//        maskSoftCG  = r2.cgImage
//    }
//    
//    @ViewBuilder
//    func configure(w: CGFloat, breathe: CGFloat, flicker: CGFloat, t: TimeInterval) -> some View {
//            let phase   = 0.5 + 0.5 * sin(t * 1.4)
//            let ringWidth = 2.0 + 5.0 * phase
//            let p = 0.5 + 0.5 * sin(t / 4.0)
//            let hueShift = Angle(degrees: p)
//            let maskSolid = Image.friendFill
//                .renderingMode(.original)
//                .resizable()
//                .scaledToFit()
//                .foregroundStyle(.white)
//                .luminanceToAlpha()     // чистая форма
//                .blur(radius: 0.5)
//    
//            let maskSoft = Image.friendFill
//                .renderingMode(.original)
//                .resizable()
//                .scaledToFit()
//                .luminanceToAlpha()
//                .blur(radius: 8)
//                .hueRotation(hueShift).opacity(0.70 * phase * flicker)
//    
//            ZStack {
//                // ДАЛЬНИЙ ОРЕОЛ (мягкий)
//                RadialGradient(
//                    colors: [Color.black.opacity(0.12 * gain), .clear],
//                    center: .center, startRadius: w * 0.38, endRadius: w * 0.72
//                )
//                .blur(radius: 90)
//                .blendMode(.plusLighter)
//                .mask(maskSoft)
//                Color.white.opacity(0.12 * breathe * flicker)
//                    .blur(radius: 120)
//                    .mask(maskSoft.scaleEffect(1.06))
//                    .blendMode(.plusLighter)
//    
//                let ringMask = maskSolid
//                    .overlay(maskSolid.blur(radius: ringWidth).blendMode(.destinationOut))
//                    .compositingGroup()
//    
//                theme.base.opacity(0.95 * breathe)
//                    .blur(radius: 4)
//                    .mask(ringMask)
//                    .blendMode(.plusLighter)
//                theme.base.opacity(0.90 * breathe)
//                    .blur(radius: 2)
//                    .mask(ringMask)
//                    .blendMode(.plusLighter)
//                    .offset(y: w * 0.02)
//    
//                // БЛИЖНИЙ ОРЕОЛ (сочная кайма)
//                RadialGradient(
//                    colors: [Color.white.opacity(0.24 * gain), .clear],
//                    center: .center, startRadius: w * 0.28, endRadius: w * 0.78
//                )
//                .blur(radius: 48)
//                .blendMode(.plusLighter)
//                .mask(maskSoft)
//    
//                // ТЕЛО (яркое, равномерное, управляемое gain)
//                LinearGradient(
//                    colors: [
//                        theme.base.opacity(min(0.95 * gain, 1.0)),
//                        theme.base.opacity(0.92)
//                    ],
//                    startPoint: .top, endPoint: .bottom
//                )
//                .opacity(0.98 + 0.02 * phase)
//                .blur(radius: 2 + 1.5 * phase)
//                .mask(maskSolid)
//    
//                // ТЁПЛОЕ ЯДРО (добавляет «жар»)
//                RadialGradient(
//                    colors: [theme.base.opacity(0.55 * gain * gain), .clear],
//                    center: .center, startRadius: 0, endRadius: w * 0.52
//                )
//                .blendMode(.screen)
//                .mask(maskSolid)
//    
//                // ЛЁГКАЯ ГЛУБИНА (чтобы не блин)
//                RadialGradient(
//                    colors: [Color.white.opacity(0.18), .clear],
//                    center: .center, startRadius: w * 0.12, endRadius: w * 0.72
//                )
//                .blur(radius: 16)
//                .blendMode(.softLight)
//                .mask(maskSolid.blur(radius: 4))
//    
//                // ДВОЙНОЙ КОНТУР (неон)
//    
//                theme.base.opacity(0.95 * gain)
//                    .blur(radius: 4)
//                    .blendMode(.plusLighter)
//                    .mask(maskSolid)
//    
//                theme.base.opacity(0.75 * gain)
//                    .blur(radius: 1.4)
//                    .blendMode(.plusLighter)
//                    .mask(maskSolid)
//            }       .compositingGroup()
//                .drawingGroup(opaque: false, colorMode: .linear)
//        }
//}





