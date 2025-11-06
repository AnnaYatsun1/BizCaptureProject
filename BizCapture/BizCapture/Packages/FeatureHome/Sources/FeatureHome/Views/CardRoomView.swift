//
//  CardRoomView.swift
//  FeatureHome
//
//  Created by Анна Яцун on 04.11.2025.
//
import SwiftUI

public struct CardRoomView: View {
    let model: RomeCardRoomModel
    var onTap: () -> Void = {}
    public var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottom) {
                model.imageName
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .background()
                LinearGradient(
                    colors: [.clear, .black.opacity(0.6)],
                    startPoint: .center,
                    endPoint: .bottom
                ).clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                
                Text(model.title)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .foregroundColor(.white)
                    .padding(16)
                
                
            }
            .shadow(radius: 6)
            .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .glassCard(corner: 24)
        }
    }
}
