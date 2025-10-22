import Foundation
public struct HomeEntity: Identifiable, Equatable, Sendable {
  public let id: Int
  public var title: String
  public init(id: Int, title: String) { self.id = id; self.title = title }
}
