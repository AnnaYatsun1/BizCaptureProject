import Foundation
import ComposableArchitecture

//public struct FeatureChatClient {
//  public var load: @Sendable () async throws -> [FeatureChatEntity]
//  public init(load: @escaping @Sendable () async throws -> [FeatureChatEntity]) { self.load = load }
//}
//private enum FeatureChatClientKey: DependencyKey {
//  static let liveValue   = FeatureChatClient { try await Task.sleep(nanoseconds: 150_000_000); return [FeatureChatEntity(id: 1, title: "FeatureChat #1")] }
//  static let testValue   = FeatureChatClient { [] }
//  static let previewValue= FeatureChatClient { [FeatureChatEntity(id: 42, title: "Preview")] }
//}
//public extension DependencyValues {
//  var featureChatClient: FeatureChatClient {
//    get { self[FeatureChatClientKey.self] }
//    set { self[FeatureChatClientKey.self] = newValue }
//  }
//}
