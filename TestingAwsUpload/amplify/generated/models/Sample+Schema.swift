// swiftlint:disable all
import Amplify
import Foundation

extension Sample {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case content
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let sample = Sample.keys
    
    model.pluralName = "Samples"
    
    model.attributes(
      .primaryKey(fields: [sample.id])
    )
    
    model.fields(
      .field(sample.id, is: .required, ofType: .string),
      .field(sample.content, is: .required, ofType: .string),
      .field(sample.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(sample.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Sample: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}