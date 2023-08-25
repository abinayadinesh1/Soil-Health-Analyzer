// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "96d165c4336b99b8953c88b4a91fb665"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: ExperimentGraphQL.self)
    ModelRegistry.register(modelType: SampleGraphQL.self)
  }
}