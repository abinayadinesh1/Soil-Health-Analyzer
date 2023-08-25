// swiftlint:disable all
import Amplify
import Foundation

extension Experiment {
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
    let experiment = Experiment.keys
    
    model.pluralName = "Experiments"
    
    model.attributes(
      .primaryKey(fields: [experiment.id])
    )
    
    model.fields(
      .field(experiment.id, is: .required, ofType: .string),
      .field(experiment.title, is: .required, ofType: .string),
      .field(experiment.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(experiment.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Experiment: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
