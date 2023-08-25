// swiftlint:disable all
import Amplify
import Foundation

extension SampleGraphQL {
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
    let sampleGraphQL = SampleGraphQL.keys
    
    model.pluralName = "SampleGraphQLS"
    
    model.attributes(
      .primaryKey(fields: [sampleGraphQL.id])
    )
    
    model.fields(
      .field(sampleGraphQL.id, is: .required, ofType: .string),
      .field(sampleGraphQL.content, is: .required, ofType: .string),
      .field(sampleGraphQL.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(sampleGraphQL.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension SampleGraphQL: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}