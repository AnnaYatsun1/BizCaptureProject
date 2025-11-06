import SwiftUI

public struct RomeCardRoomModel: Identifiable, Equatable, Sendable {
    public let kind: Room
    public let id: UUID = UUID()
    public let imageName: Image
    public let title: String
}
