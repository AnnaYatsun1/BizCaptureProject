import Foundation
import ComposableArchitecture
import Core

//public struct HomeClient {
//  public var load: @Sendable () async throws -> [HomeEntity]
//  public init(load: @escaping @Sendable () async throws -> [HomeEntity]) { self.load = load }
//}
//private enum HomeClientKey: DependencyKey {
//  static let liveValue   = HomeClient { try await Task.sleep(nanoseconds: 150_000_000); return [HomeEntity(id: 1, title: "Home #1")] }
//  static let testValue   = HomeClient { [] }
//  static let previewValue= HomeClient { [HomeEntity(id: 42, title: "Preview")] }
//}
//public extension DependencyValues {
//  var homeClient: HomeClient {
//    get { self[HomeClientKey.self] }
//    set { self[HomeClientKey.self] = newValue }
//  }
//}
