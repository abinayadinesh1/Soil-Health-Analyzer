// swiftlint:disable all
import Amplify
import Foundation

public struct SampleGraphQL: Model {
  public let id: String
  public var content: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      content: String) {
    self.init(id: id,
      content: content,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      content: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.content = content
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}