// swiftlint:disable all
import Amplify
import Foundation

extension ExperimentGraphQL {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let experimentGraphQL = ExperimentGraphQL.keys
    
    model.pluralName = "ExperimentGraphQLS"
    
    model.attributes(
      .primaryKey(fields: [experimentGraphQL.id])
    )
    
    model.fields(
      .field(experimentGraphQL.id, is: .required, ofType: .string),
      .field(experimentGraphQL.title, is: .required, ofType: .string),
      .field(experimentGraphQL.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(experimentGraphQL.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension ExperimentGraphQL: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}