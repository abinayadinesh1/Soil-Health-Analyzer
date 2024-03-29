// swiftlint:disable all
import Amplify
import Foundation

public struct ExperimentGraphQL: Model {
  public let id: String
  public var title: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      title: String) {
    self.init(id: id,
      title: title,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      title: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.title = title
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
