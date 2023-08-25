//  This file was automatically generated and should not be edited.

#if canImport(AWSAPIPlugin)
import Foundation

public protocol GraphQLInputValue {
}

public struct GraphQLVariable {
  let name: String
  
  public init(_ name: String) {
    self.name = name
  }
}

extension GraphQLVariable: GraphQLInputValue {
}

extension JSONEncodable {
  public func evaluate(with variables: [String: JSONEncodable]?) throws -> Any {
    return jsonValue
  }
}

public typealias GraphQLMap = [String: JSONEncodable?]

extension Dictionary where Key == String, Value == JSONEncodable? {
  public var withNilValuesRemoved: Dictionary<String, JSONEncodable> {
    var filtered = Dictionary<String, JSONEncodable>(minimumCapacity: count)
    for (key, value) in self {
      if value != nil {
        filtered[key] = value
      }
    }
    return filtered
  }
}

public protocol GraphQLMapConvertible: JSONEncodable {
  var graphQLMap: GraphQLMap { get }
}

public extension GraphQLMapConvertible {
  var jsonValue: Any {
    return graphQLMap.withNilValuesRemoved.jsonValue
  }
}

public typealias GraphQLID = String

public protocol APISwiftGraphQLOperation: AnyObject {
  
  static var operationString: String { get }
  static var requestString: String { get }
  static var operationIdentifier: String? { get }
  
  var variables: GraphQLMap? { get }
  
  associatedtype Data: GraphQLSelectionSet
}

public extension APISwiftGraphQLOperation {
  static var requestString: String {
    return operationString
  }

  static var operationIdentifier: String? {
    return nil
  }

  var variables: GraphQLMap? {
    return nil
  }
}

public protocol GraphQLQuery: APISwiftGraphQLOperation {}

public protocol GraphQLMutation: APISwiftGraphQLOperation {}

public protocol GraphQLSubscription: APISwiftGraphQLOperation {}

public protocol GraphQLFragment: GraphQLSelectionSet {
  static var possibleTypes: [String] { get }
}

public typealias Snapshot = [String: Any?]

public protocol GraphQLSelectionSet: Decodable {
  static var selections: [GraphQLSelection] { get }
  
  var snapshot: Snapshot { get }
  init(snapshot: Snapshot)
}

extension GraphQLSelectionSet {
    public init(from decoder: Decoder) throws {
        if let jsonObject = try? APISwiftJSONValue(from: decoder) {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(jsonObject)
            let decodedDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            let optionalDictionary = decodedDictionary.mapValues { $0 as Any? }

            self.init(snapshot: optionalDictionary)
        } else {
            self.init(snapshot: [:])
        }
    }
}

enum APISwiftJSONValue: Codable {
    case array([APISwiftJSONValue])
    case boolean(Bool)
    case number(Double)
    case object([String: APISwiftJSONValue])
    case string(String)
    case null
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode([String: APISwiftJSONValue].self) {
            self = .object(value)
        } else if let value = try? container.decode([APISwiftJSONValue].self) {
            self = .array(value)
        } else if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .boolean(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else {
            self = .null
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .array(let value):
            try container.encode(value)
        case .boolean(let value):
            try container.encode(value)
        case .number(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .null:
            try container.encodeNil()
        }
    }
}

public protocol GraphQLSelection {
}

public struct GraphQLField: GraphQLSelection {
  let name: String
  let alias: String?
  let arguments: [String: GraphQLInputValue]?
  
  var responseKey: String {
    return alias ?? name
  }
  
  let type: GraphQLOutputType
  
  public init(_ name: String, alias: String? = nil, arguments: [String: GraphQLInputValue]? = nil, type: GraphQLOutputType) {
    self.name = name
    self.alias = alias
    
    self.arguments = arguments
    
    self.type = type
  }
}

public indirect enum GraphQLOutputType {
  case scalar(JSONDecodable.Type)
  case object([GraphQLSelection])
  case nonNull(GraphQLOutputType)
  case list(GraphQLOutputType)
  
  var namedType: GraphQLOutputType {
    switch self {
    case .nonNull(let innerType), .list(let innerType):
      return innerType.namedType
    case .scalar, .object:
      return self
    }
  }
}

public struct GraphQLBooleanCondition: GraphQLSelection {
  let variableName: String
  let inverted: Bool
  let selections: [GraphQLSelection]
  
  public init(variableName: String, inverted: Bool, selections: [GraphQLSelection]) {
    self.variableName = variableName
    self.inverted = inverted;
    self.selections = selections;
  }
}

public struct GraphQLTypeCondition: GraphQLSelection {
  let possibleTypes: [String]
  let selections: [GraphQLSelection]
  
  public init(possibleTypes: [String], selections: [GraphQLSelection]) {
    self.possibleTypes = possibleTypes
    self.selections = selections;
  }
}

public struct GraphQLFragmentSpread: GraphQLSelection {
  let fragment: GraphQLFragment.Type
  
  public init(_ fragment: GraphQLFragment.Type) {
    self.fragment = fragment
  }
}

public struct GraphQLTypeCase: GraphQLSelection {
  let variants: [String: [GraphQLSelection]]
  let `default`: [GraphQLSelection]
  
  public init(variants: [String: [GraphQLSelection]], default: [GraphQLSelection]) {
    self.variants = variants
    self.default = `default`;
  }
}

public typealias JSONObject = [String: Any]

public protocol JSONDecodable {
  init(jsonValue value: Any) throws
}

public protocol JSONEncodable: GraphQLInputValue {
  var jsonValue: Any { get }
}

public enum JSONDecodingError: Error, LocalizedError {
  case missingValue
  case nullValue
  case wrongType
  case couldNotConvert(value: Any, to: Any.Type)
  
  public var errorDescription: String? {
    switch self {
    case .missingValue:
      return "Missing value"
    case .nullValue:
      return "Unexpected null value"
    case .wrongType:
      return "Wrong type"
    case .couldNotConvert(let value, let expectedType):
      return "Could not convert \"\(value)\" to \(expectedType)"
    }
  }
}

extension String: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let string = value as? String else {
      throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
    }
    self = string
  }

  public var jsonValue: Any {
    return self
  }
}

extension Int: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let number = value as? NSNumber else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Int.self)
    }
    self = number.intValue
  }

  public var jsonValue: Any {
    return self
  }
}

extension Float: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let number = value as? NSNumber else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Float.self)
    }
    self = number.floatValue
  }

  public var jsonValue: Any {
    return self
  }
}

extension Double: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let number = value as? NSNumber else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Double.self)
    }
    self = number.doubleValue
  }

  public var jsonValue: Any {
    return self
  }
}

extension Bool: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let bool = value as? Bool else {
        throw JSONDecodingError.couldNotConvert(value: value, to: Bool.self)
    }
    self = bool
  }

  public var jsonValue: Any {
    return self
  }
}

extension RawRepresentable where RawValue: JSONDecodable {
  public init(jsonValue value: Any) throws {
    let rawValue = try RawValue(jsonValue: value)
    if let tempSelf = Self(rawValue: rawValue) {
      self = tempSelf
    } else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Self.self)
    }
  }
}

extension RawRepresentable where RawValue: JSONEncodable {
  public var jsonValue: Any {
    return rawValue.jsonValue
  }
}

extension Optional where Wrapped: JSONDecodable {
  public init(jsonValue value: Any) throws {
    if value is NSNull {
      self = .none
    } else {
      self = .some(try Wrapped(jsonValue: value))
    }
  }
}

extension Optional: JSONEncodable {
  public var jsonValue: Any {
    switch self {
    case .none:
      return NSNull()
    case .some(let wrapped as JSONEncodable):
      return wrapped.jsonValue
    default:
      fatalError("Optional is only JSONEncodable if Wrapped is")
    }
  }
}

extension Dictionary: JSONEncodable {
  public var jsonValue: Any {
    return jsonObject
  }
  
  public var jsonObject: JSONObject {
    var jsonObject = JSONObject(minimumCapacity: count)
    for (key, value) in self {
      if case let (key as String, value as JSONEncodable) = (key, value) {
        jsonObject[key] = value.jsonValue
      } else {
        fatalError("Dictionary is only JSONEncodable if Value is (and if Key is String)")
      }
    }
    return jsonObject
  }
}

extension Array: JSONEncodable {
  public var jsonValue: Any {
    return map() { element -> (Any) in
      if case let element as JSONEncodable = element {
        return element.jsonValue
      } else {
        fatalError("Array is only JSONEncodable if Element is")
      }
    }
  }
}

extension URL: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let string = value as? String else {
      throw JSONDecodingError.couldNotConvert(value: value, to: URL.self)
    }
    self.init(string: string)!
  }

  public var jsonValue: Any {
    return self.absoluteString
  }
}

extension Dictionary {
  static func += (lhs: inout Dictionary, rhs: Dictionary) {
    lhs.merge(rhs) { (_, new) in new }
  }
}

#elseif canImport(AWSAppSync)
import AWSAppSync
#endif

public struct CreateExperimentGraphQLInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID? = nil, title: String) {
    graphQLMap = ["id": id, "title": title]
  }

  public var id: GraphQLID? {
    get {
      return graphQLMap["id"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: String {
    get {
      return graphQLMap["title"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }
}

public struct ModelExperimentGraphQLConditionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(title: ModelStringInput? = nil, and: [ModelExperimentGraphQLConditionInput?]? = nil, or: [ModelExperimentGraphQLConditionInput?]? = nil, not: ModelExperimentGraphQLConditionInput? = nil) {
    graphQLMap = ["title": title, "and": and, "or": or, "not": not]
  }

  public var title: ModelStringInput? {
    get {
      return graphQLMap["title"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }

  public var and: [ModelExperimentGraphQLConditionInput?]? {
    get {
      return graphQLMap["and"] as! [ModelExperimentGraphQLConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelExperimentGraphQLConditionInput?]? {
    get {
      return graphQLMap["or"] as! [ModelExperimentGraphQLConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelExperimentGraphQLConditionInput? {
    get {
      return graphQLMap["not"] as! ModelExperimentGraphQLConditionInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct ModelStringInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: String? = nil, eq: String? = nil, le: String? = nil, lt: String? = nil, ge: String? = nil, gt: String? = nil, contains: String? = nil, notContains: String? = nil, between: [String?]? = nil, beginsWith: String? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil, size: ModelSizeInput? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "attributeExists": attributeExists, "attributeType": attributeType, "size": size]
  }

  public var ne: String? {
    get {
      return graphQLMap["ne"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: String? {
    get {
      return graphQLMap["eq"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: String? {
    get {
      return graphQLMap["le"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: String? {
    get {
      return graphQLMap["lt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: String? {
    get {
      return graphQLMap["ge"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: String? {
    get {
      return graphQLMap["gt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: String? {
    get {
      return graphQLMap["contains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: String? {
    get {
      return graphQLMap["notContains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [String?]? {
    get {
      return graphQLMap["between"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: String? {
    get {
      return graphQLMap["beginsWith"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var attributeExists: Bool? {
    get {
      return graphQLMap["attributeExists"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeExists")
    }
  }

  public var attributeType: ModelAttributeTypes? {
    get {
      return graphQLMap["attributeType"] as! ModelAttributeTypes?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeType")
    }
  }

  public var size: ModelSizeInput? {
    get {
      return graphQLMap["size"] as! ModelSizeInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
    }
  }
}

public enum ModelAttributeTypes: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  public typealias RawValue = String
  case binary
  case binarySet
  case bool
  case list
  case map
  case number
  case numberSet
  case string
  case stringSet
  case null
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "binary": self = .binary
      case "binarySet": self = .binarySet
      case "bool": self = .bool
      case "list": self = .list
      case "map": self = .map
      case "number": self = .number
      case "numberSet": self = .numberSet
      case "string": self = .string
      case "stringSet": self = .stringSet
      case "_null": self = .null
      default: self = .unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .binary: return "binary"
      case .binarySet: return "binarySet"
      case .bool: return "bool"
      case .list: return "list"
      case .map: return "map"
      case .number: return "number"
      case .numberSet: return "numberSet"
      case .string: return "string"
      case .stringSet: return "stringSet"
      case .null: return "_null"
      case .unknown(let value): return value
    }
  }

  public static func == (lhs: ModelAttributeTypes, rhs: ModelAttributeTypes) -> Bool {
    switch (lhs, rhs) {
      case (.binary, .binary): return true
      case (.binarySet, .binarySet): return true
      case (.bool, .bool): return true
      case (.list, .list): return true
      case (.map, .map): return true
      case (.number, .number): return true
      case (.numberSet, .numberSet): return true
      case (.string, .string): return true
      case (.stringSet, .stringSet): return true
      case (.null, .null): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public struct ModelSizeInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: Int? = nil, eq: Int? = nil, le: Int? = nil, lt: Int? = nil, ge: Int? = nil, gt: Int? = nil, between: [Int?]? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "between": between]
  }

  public var ne: Int? {
    get {
      return graphQLMap["ne"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: Int? {
    get {
      return graphQLMap["eq"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: Int? {
    get {
      return graphQLMap["le"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: Int? {
    get {
      return graphQLMap["lt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: Int? {
    get {
      return graphQLMap["ge"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: Int? {
    get {
      return graphQLMap["gt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var between: [Int?]? {
    get {
      return graphQLMap["between"] as! [Int?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }
}

public struct UpdateExperimentGraphQLInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID, title: String? = nil) {
    graphQLMap = ["id": id, "title": title]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: String? {
    get {
      return graphQLMap["title"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }
}

public struct DeleteExperimentGraphQLInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID) {
    graphQLMap = ["id": id]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }
}

public struct CreateSampleGraphQLInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID? = nil, content: String) {
    graphQLMap = ["id": id, "content": content]
  }

  public var id: GraphQLID? {
    get {
      return graphQLMap["id"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var content: String {
    get {
      return graphQLMap["content"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }
}

public struct ModelSampleGraphQLConditionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(content: ModelStringInput? = nil, and: [ModelSampleGraphQLConditionInput?]? = nil, or: [ModelSampleGraphQLConditionInput?]? = nil, not: ModelSampleGraphQLConditionInput? = nil) {
    graphQLMap = ["content": content, "and": and, "or": or, "not": not]
  }

  public var content: ModelStringInput? {
    get {
      return graphQLMap["content"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  public var and: [ModelSampleGraphQLConditionInput?]? {
    get {
      return graphQLMap["and"] as! [ModelSampleGraphQLConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelSampleGraphQLConditionInput?]? {
    get {
      return graphQLMap["or"] as! [ModelSampleGraphQLConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelSampleGraphQLConditionInput? {
    get {
      return graphQLMap["not"] as! ModelSampleGraphQLConditionInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct UpdateSampleGraphQLInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID, content: String? = nil) {
    graphQLMap = ["id": id, "content": content]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var content: String? {
    get {
      return graphQLMap["content"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }
}

public struct DeleteSampleGraphQLInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID) {
    graphQLMap = ["id": id]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }
}

public struct ModelExperimentGraphQLFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: ModelIDInput? = nil, title: ModelStringInput? = nil, and: [ModelExperimentGraphQLFilterInput?]? = nil, or: [ModelExperimentGraphQLFilterInput?]? = nil, not: ModelExperimentGraphQLFilterInput? = nil) {
    graphQLMap = ["id": id, "title": title, "and": and, "or": or, "not": not]
  }

  public var id: ModelIDInput? {
    get {
      return graphQLMap["id"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: ModelStringInput? {
    get {
      return graphQLMap["title"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }

  public var and: [ModelExperimentGraphQLFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelExperimentGraphQLFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelExperimentGraphQLFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelExperimentGraphQLFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelExperimentGraphQLFilterInput? {
    get {
      return graphQLMap["not"] as! ModelExperimentGraphQLFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct ModelIDInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: GraphQLID? = nil, eq: GraphQLID? = nil, le: GraphQLID? = nil, lt: GraphQLID? = nil, ge: GraphQLID? = nil, gt: GraphQLID? = nil, contains: GraphQLID? = nil, notContains: GraphQLID? = nil, between: [GraphQLID?]? = nil, beginsWith: GraphQLID? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil, size: ModelSizeInput? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "attributeExists": attributeExists, "attributeType": attributeType, "size": size]
  }

  public var ne: GraphQLID? {
    get {
      return graphQLMap["ne"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: GraphQLID? {
    get {
      return graphQLMap["eq"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: GraphQLID? {
    get {
      return graphQLMap["le"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: GraphQLID? {
    get {
      return graphQLMap["lt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: GraphQLID? {
    get {
      return graphQLMap["ge"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: GraphQLID? {
    get {
      return graphQLMap["gt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: GraphQLID? {
    get {
      return graphQLMap["contains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: GraphQLID? {
    get {
      return graphQLMap["notContains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [GraphQLID?]? {
    get {
      return graphQLMap["between"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: GraphQLID? {
    get {
      return graphQLMap["beginsWith"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var attributeExists: Bool? {
    get {
      return graphQLMap["attributeExists"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeExists")
    }
  }

  public var attributeType: ModelAttributeTypes? {
    get {
      return graphQLMap["attributeType"] as! ModelAttributeTypes?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeType")
    }
  }

  public var size: ModelSizeInput? {
    get {
      return graphQLMap["size"] as! ModelSizeInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
    }
  }
}

public struct ModelSampleGraphQLFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: ModelIDInput? = nil, content: ModelStringInput? = nil, and: [ModelSampleGraphQLFilterInput?]? = nil, or: [ModelSampleGraphQLFilterInput?]? = nil, not: ModelSampleGraphQLFilterInput? = nil) {
    graphQLMap = ["id": id, "content": content, "and": and, "or": or, "not": not]
  }

  public var id: ModelIDInput? {
    get {
      return graphQLMap["id"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var content: ModelStringInput? {
    get {
      return graphQLMap["content"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  public var and: [ModelSampleGraphQLFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelSampleGraphQLFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelSampleGraphQLFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelSampleGraphQLFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelSampleGraphQLFilterInput? {
    get {
      return graphQLMap["not"] as! ModelSampleGraphQLFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct ModelSubscriptionExperimentGraphQLFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: ModelSubscriptionIDInput? = nil, title: ModelSubscriptionStringInput? = nil, and: [ModelSubscriptionExperimentGraphQLFilterInput?]? = nil, or: [ModelSubscriptionExperimentGraphQLFilterInput?]? = nil) {
    graphQLMap = ["id": id, "title": title, "and": and, "or": or]
  }

  public var id: ModelSubscriptionIDInput? {
    get {
      return graphQLMap["id"] as! ModelSubscriptionIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: ModelSubscriptionStringInput? {
    get {
      return graphQLMap["title"] as! ModelSubscriptionStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }

  public var and: [ModelSubscriptionExperimentGraphQLFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelSubscriptionExperimentGraphQLFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelSubscriptionExperimentGraphQLFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelSubscriptionExperimentGraphQLFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }
}

public struct ModelSubscriptionIDInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: GraphQLID? = nil, eq: GraphQLID? = nil, le: GraphQLID? = nil, lt: GraphQLID? = nil, ge: GraphQLID? = nil, gt: GraphQLID? = nil, contains: GraphQLID? = nil, notContains: GraphQLID? = nil, between: [GraphQLID?]? = nil, beginsWith: GraphQLID? = nil, `in`: [GraphQLID?]? = nil, notIn: [GraphQLID?]? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "in": `in`, "notIn": notIn]
  }

  public var ne: GraphQLID? {
    get {
      return graphQLMap["ne"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: GraphQLID? {
    get {
      return graphQLMap["eq"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: GraphQLID? {
    get {
      return graphQLMap["le"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: GraphQLID? {
    get {
      return graphQLMap["lt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: GraphQLID? {
    get {
      return graphQLMap["ge"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: GraphQLID? {
    get {
      return graphQLMap["gt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: GraphQLID? {
    get {
      return graphQLMap["contains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: GraphQLID? {
    get {
      return graphQLMap["notContains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [GraphQLID?]? {
    get {
      return graphQLMap["between"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: GraphQLID? {
    get {
      return graphQLMap["beginsWith"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var `in`: [GraphQLID?]? {
    get {
      return graphQLMap["in"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "in")
    }
  }

  public var notIn: [GraphQLID?]? {
    get {
      return graphQLMap["notIn"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notIn")
    }
  }
}

public struct ModelSubscriptionStringInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: String? = nil, eq: String? = nil, le: String? = nil, lt: String? = nil, ge: String? = nil, gt: String? = nil, contains: String? = nil, notContains: String? = nil, between: [String?]? = nil, beginsWith: String? = nil, `in`: [String?]? = nil, notIn: [String?]? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "in": `in`, "notIn": notIn]
  }

  public var ne: String? {
    get {
      return graphQLMap["ne"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: String? {
    get {
      return graphQLMap["eq"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: String? {
    get {
      return graphQLMap["le"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: String? {
    get {
      return graphQLMap["lt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: String? {
    get {
      return graphQLMap["ge"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: String? {
    get {
      return graphQLMap["gt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: String? {
    get {
      return graphQLMap["contains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: String? {
    get {
      return graphQLMap["notContains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [String?]? {
    get {
      return graphQLMap["between"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: String? {
    get {
      return graphQLMap["beginsWith"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var `in`: [String?]? {
    get {
      return graphQLMap["in"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "in")
    }
  }

  public var notIn: [String?]? {
    get {
      return graphQLMap["notIn"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notIn")
    }
  }
}

public struct ModelSubscriptionSampleGraphQLFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: ModelSubscriptionIDInput? = nil, content: ModelSubscriptionStringInput? = nil, and: [ModelSubscriptionSampleGraphQLFilterInput?]? = nil, or: [ModelSubscriptionSampleGraphQLFilterInput?]? = nil) {
    graphQLMap = ["id": id, "content": content, "and": and, "or": or]
  }

  public var id: ModelSubscriptionIDInput? {
    get {
      return graphQLMap["id"] as! ModelSubscriptionIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var content: ModelSubscriptionStringInput? {
    get {
      return graphQLMap["content"] as! ModelSubscriptionStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  public var and: [ModelSubscriptionSampleGraphQLFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelSubscriptionSampleGraphQLFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelSubscriptionSampleGraphQLFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelSubscriptionSampleGraphQLFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }
}

public final class CreateExperimentGraphQlMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateExperimentGraphQL($input: CreateExperimentGraphQLInput!, $condition: ModelExperimentGraphQLConditionInput) {\n  createExperimentGraphQL(input: $input, condition: $condition) {\n    __typename\n    id\n    title\n    createdAt\n    updatedAt\n  }\n}"

  public var input: CreateExperimentGraphQLInput
  public var condition: ModelExperimentGraphQLConditionInput?

  public init(input: CreateExperimentGraphQLInput, condition: ModelExperimentGraphQLConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createExperimentGraphQL", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(CreateExperimentGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createExperimentGraphQl: CreateExperimentGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "createExperimentGraphQL": createExperimentGraphQl.flatMap { $0.snapshot }])
    }

    public var createExperimentGraphQl: CreateExperimentGraphQl? {
      get {
        return (snapshot["createExperimentGraphQL"] as? Snapshot).flatMap { CreateExperimentGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createExperimentGraphQL")
      }
    }

    public struct CreateExperimentGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ExperimentGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "ExperimentGraphQL", "id": id, "title": title, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class UpdateExperimentGraphQlMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdateExperimentGraphQL($input: UpdateExperimentGraphQLInput!, $condition: ModelExperimentGraphQLConditionInput) {\n  updateExperimentGraphQL(input: $input, condition: $condition) {\n    __typename\n    id\n    title\n    createdAt\n    updatedAt\n  }\n}"

  public var input: UpdateExperimentGraphQLInput
  public var condition: ModelExperimentGraphQLConditionInput?

  public init(input: UpdateExperimentGraphQLInput, condition: ModelExperimentGraphQLConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateExperimentGraphQL", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(UpdateExperimentGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updateExperimentGraphQl: UpdateExperimentGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "updateExperimentGraphQL": updateExperimentGraphQl.flatMap { $0.snapshot }])
    }

    public var updateExperimentGraphQl: UpdateExperimentGraphQl? {
      get {
        return (snapshot["updateExperimentGraphQL"] as? Snapshot).flatMap { UpdateExperimentGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "updateExperimentGraphQL")
      }
    }

    public struct UpdateExperimentGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ExperimentGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "ExperimentGraphQL", "id": id, "title": title, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class DeleteExperimentGraphQlMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteExperimentGraphQL($input: DeleteExperimentGraphQLInput!, $condition: ModelExperimentGraphQLConditionInput) {\n  deleteExperimentGraphQL(input: $input, condition: $condition) {\n    __typename\n    id\n    title\n    createdAt\n    updatedAt\n  }\n}"

  public var input: DeleteExperimentGraphQLInput
  public var condition: ModelExperimentGraphQLConditionInput?

  public init(input: DeleteExperimentGraphQLInput, condition: ModelExperimentGraphQLConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteExperimentGraphQL", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(DeleteExperimentGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deleteExperimentGraphQl: DeleteExperimentGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deleteExperimentGraphQL": deleteExperimentGraphQl.flatMap { $0.snapshot }])
    }

    public var deleteExperimentGraphQl: DeleteExperimentGraphQl? {
      get {
        return (snapshot["deleteExperimentGraphQL"] as? Snapshot).flatMap { DeleteExperimentGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deleteExperimentGraphQL")
      }
    }

    public struct DeleteExperimentGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ExperimentGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "ExperimentGraphQL", "id": id, "title": title, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class CreateSampleGraphQlMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateSampleGraphQL($input: CreateSampleGraphQLInput!, $condition: ModelSampleGraphQLConditionInput) {\n  createSampleGraphQL(input: $input, condition: $condition) {\n    __typename\n    id\n    content\n    createdAt\n    updatedAt\n  }\n}"

  public var input: CreateSampleGraphQLInput
  public var condition: ModelSampleGraphQLConditionInput?

  public init(input: CreateSampleGraphQLInput, condition: ModelSampleGraphQLConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createSampleGraphQL", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(CreateSampleGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createSampleGraphQl: CreateSampleGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "createSampleGraphQL": createSampleGraphQl.flatMap { $0.snapshot }])
    }

    public var createSampleGraphQl: CreateSampleGraphQl? {
      get {
        return (snapshot["createSampleGraphQL"] as? Snapshot).flatMap { CreateSampleGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createSampleGraphQL")
      }
    }

    public struct CreateSampleGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["SampleGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, content: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "SampleGraphQL", "id": id, "content": content, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var content: String {
        get {
          return snapshot["content"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class UpdateSampleGraphQlMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdateSampleGraphQL($input: UpdateSampleGraphQLInput!, $condition: ModelSampleGraphQLConditionInput) {\n  updateSampleGraphQL(input: $input, condition: $condition) {\n    __typename\n    id\n    content\n    createdAt\n    updatedAt\n  }\n}"

  public var input: UpdateSampleGraphQLInput
  public var condition: ModelSampleGraphQLConditionInput?

  public init(input: UpdateSampleGraphQLInput, condition: ModelSampleGraphQLConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateSampleGraphQL", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(UpdateSampleGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updateSampleGraphQl: UpdateSampleGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "updateSampleGraphQL": updateSampleGraphQl.flatMap { $0.snapshot }])
    }

    public var updateSampleGraphQl: UpdateSampleGraphQl? {
      get {
        return (snapshot["updateSampleGraphQL"] as? Snapshot).flatMap { UpdateSampleGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "updateSampleGraphQL")
      }
    }

    public struct UpdateSampleGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["SampleGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, content: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "SampleGraphQL", "id": id, "content": content, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var content: String {
        get {
          return snapshot["content"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class DeleteSampleGraphQlMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteSampleGraphQL($input: DeleteSampleGraphQLInput!, $condition: ModelSampleGraphQLConditionInput) {\n  deleteSampleGraphQL(input: $input, condition: $condition) {\n    __typename\n    id\n    content\n    createdAt\n    updatedAt\n  }\n}"

  public var input: DeleteSampleGraphQLInput
  public var condition: ModelSampleGraphQLConditionInput?

  public init(input: DeleteSampleGraphQLInput, condition: ModelSampleGraphQLConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteSampleGraphQL", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(DeleteSampleGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deleteSampleGraphQl: DeleteSampleGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deleteSampleGraphQL": deleteSampleGraphQl.flatMap { $0.snapshot }])
    }

    public var deleteSampleGraphQl: DeleteSampleGraphQl? {
      get {
        return (snapshot["deleteSampleGraphQL"] as? Snapshot).flatMap { DeleteSampleGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deleteSampleGraphQL")
      }
    }

    public struct DeleteSampleGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["SampleGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, content: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "SampleGraphQL", "id": id, "content": content, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var content: String {
        get {
          return snapshot["content"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class GetExperimentGraphQlQuery: GraphQLQuery {
  public static let operationString =
    "query GetExperimentGraphQL($id: ID!) {\n  getExperimentGraphQL(id: $id) {\n    __typename\n    id\n    title\n    createdAt\n    updatedAt\n  }\n}"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getExperimentGraphQL", arguments: ["id": GraphQLVariable("id")], type: .object(GetExperimentGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getExperimentGraphQl: GetExperimentGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Query", "getExperimentGraphQL": getExperimentGraphQl.flatMap { $0.snapshot }])
    }

    public var getExperimentGraphQl: GetExperimentGraphQl? {
      get {
        return (snapshot["getExperimentGraphQL"] as? Snapshot).flatMap { GetExperimentGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getExperimentGraphQL")
      }
    }

    public struct GetExperimentGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ExperimentGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "ExperimentGraphQL", "id": id, "title": title, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class ListExperimentGraphQlsQuery: GraphQLQuery {
  public static let operationString =
    "query ListExperimentGraphQLS($filter: ModelExperimentGraphQLFilterInput, $limit: Int, $nextToken: String) {\n  listExperimentGraphQLS(filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      title\n      createdAt\n      updatedAt\n    }\n    nextToken\n  }\n}"

  public var filter: ModelExperimentGraphQLFilterInput?
  public var limit: Int?
  public var nextToken: String?

  public init(filter: ModelExperimentGraphQLFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["filter": filter, "limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listExperimentGraphQLS", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(ListExperimentGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listExperimentGraphQls: ListExperimentGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Query", "listExperimentGraphQLS": listExperimentGraphQls.flatMap { $0.snapshot }])
    }

    public var listExperimentGraphQls: ListExperimentGraphQl? {
      get {
        return (snapshot["listExperimentGraphQLS"] as? Snapshot).flatMap { ListExperimentGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "listExperimentGraphQLS")
      }
    }

    public struct ListExperimentGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelExperimentGraphQLConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelExperimentGraphQLConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["ExperimentGraphQL"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, title: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "ExperimentGraphQL", "id": id, "title": title, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return snapshot["title"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "title")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class GetSampleGraphQlQuery: GraphQLQuery {
  public static let operationString =
    "query GetSampleGraphQL($id: ID!) {\n  getSampleGraphQL(id: $id) {\n    __typename\n    id\n    content\n    createdAt\n    updatedAt\n  }\n}"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getSampleGraphQL", arguments: ["id": GraphQLVariable("id")], type: .object(GetSampleGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getSampleGraphQl: GetSampleGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Query", "getSampleGraphQL": getSampleGraphQl.flatMap { $0.snapshot }])
    }

    public var getSampleGraphQl: GetSampleGraphQl? {
      get {
        return (snapshot["getSampleGraphQL"] as? Snapshot).flatMap { GetSampleGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getSampleGraphQL")
      }
    }

    public struct GetSampleGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["SampleGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, content: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "SampleGraphQL", "id": id, "content": content, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var content: String {
        get {
          return snapshot["content"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class ListSampleGraphQlsQuery: GraphQLQuery {
  public static let operationString =
    "query ListSampleGraphQLS($filter: ModelSampleGraphQLFilterInput, $limit: Int, $nextToken: String) {\n  listSampleGraphQLS(filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      content\n      createdAt\n      updatedAt\n    }\n    nextToken\n  }\n}"

  public var filter: ModelSampleGraphQLFilterInput?
  public var limit: Int?
  public var nextToken: String?

  public init(filter: ModelSampleGraphQLFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["filter": filter, "limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listSampleGraphQLS", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(ListSampleGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listSampleGraphQls: ListSampleGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Query", "listSampleGraphQLS": listSampleGraphQls.flatMap { $0.snapshot }])
    }

    public var listSampleGraphQls: ListSampleGraphQl? {
      get {
        return (snapshot["listSampleGraphQLS"] as? Snapshot).flatMap { ListSampleGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "listSampleGraphQLS")
      }
    }

    public struct ListSampleGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelSampleGraphQLConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelSampleGraphQLConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["SampleGraphQL"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("content", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, content: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "SampleGraphQL", "id": id, "content": content, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var content: String {
          get {
            return snapshot["content"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "content")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class OnCreateExperimentGraphQlSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreateExperimentGraphQL($filter: ModelSubscriptionExperimentGraphQLFilterInput) {\n  onCreateExperimentGraphQL(filter: $filter) {\n    __typename\n    id\n    title\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionExperimentGraphQLFilterInput?

  public init(filter: ModelSubscriptionExperimentGraphQLFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onCreateExperimentGraphQL", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnCreateExperimentGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onCreateExperimentGraphQl: OnCreateExperimentGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onCreateExperimentGraphQL": onCreateExperimentGraphQl.flatMap { $0.snapshot }])
    }

    public var onCreateExperimentGraphQl: OnCreateExperimentGraphQl? {
      get {
        return (snapshot["onCreateExperimentGraphQL"] as? Snapshot).flatMap { OnCreateExperimentGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onCreateExperimentGraphQL")
      }
    }

    public struct OnCreateExperimentGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ExperimentGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "ExperimentGraphQL", "id": id, "title": title, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnUpdateExperimentGraphQlSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdateExperimentGraphQL($filter: ModelSubscriptionExperimentGraphQLFilterInput) {\n  onUpdateExperimentGraphQL(filter: $filter) {\n    __typename\n    id\n    title\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionExperimentGraphQLFilterInput?

  public init(filter: ModelSubscriptionExperimentGraphQLFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdateExperimentGraphQL", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnUpdateExperimentGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdateExperimentGraphQl: OnUpdateExperimentGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdateExperimentGraphQL": onUpdateExperimentGraphQl.flatMap { $0.snapshot }])
    }

    public var onUpdateExperimentGraphQl: OnUpdateExperimentGraphQl? {
      get {
        return (snapshot["onUpdateExperimentGraphQL"] as? Snapshot).flatMap { OnUpdateExperimentGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdateExperimentGraphQL")
      }
    }

    public struct OnUpdateExperimentGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ExperimentGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "ExperimentGraphQL", "id": id, "title": title, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnDeleteExperimentGraphQlSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnDeleteExperimentGraphQL($filter: ModelSubscriptionExperimentGraphQLFilterInput) {\n  onDeleteExperimentGraphQL(filter: $filter) {\n    __typename\n    id\n    title\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionExperimentGraphQLFilterInput?

  public init(filter: ModelSubscriptionExperimentGraphQLFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onDeleteExperimentGraphQL", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnDeleteExperimentGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onDeleteExperimentGraphQl: OnDeleteExperimentGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onDeleteExperimentGraphQL": onDeleteExperimentGraphQl.flatMap { $0.snapshot }])
    }

    public var onDeleteExperimentGraphQl: OnDeleteExperimentGraphQl? {
      get {
        return (snapshot["onDeleteExperimentGraphQL"] as? Snapshot).flatMap { OnDeleteExperimentGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onDeleteExperimentGraphQL")
      }
    }

    public struct OnDeleteExperimentGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["ExperimentGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "ExperimentGraphQL", "id": id, "title": title, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnCreateSampleGraphQlSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreateSampleGraphQL($filter: ModelSubscriptionSampleGraphQLFilterInput) {\n  onCreateSampleGraphQL(filter: $filter) {\n    __typename\n    id\n    content\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionSampleGraphQLFilterInput?

  public init(filter: ModelSubscriptionSampleGraphQLFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onCreateSampleGraphQL", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnCreateSampleGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onCreateSampleGraphQl: OnCreateSampleGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onCreateSampleGraphQL": onCreateSampleGraphQl.flatMap { $0.snapshot }])
    }

    public var onCreateSampleGraphQl: OnCreateSampleGraphQl? {
      get {
        return (snapshot["onCreateSampleGraphQL"] as? Snapshot).flatMap { OnCreateSampleGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onCreateSampleGraphQL")
      }
    }

    public struct OnCreateSampleGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["SampleGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, content: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "SampleGraphQL", "id": id, "content": content, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var content: String {
        get {
          return snapshot["content"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnUpdateSampleGraphQlSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdateSampleGraphQL($filter: ModelSubscriptionSampleGraphQLFilterInput) {\n  onUpdateSampleGraphQL(filter: $filter) {\n    __typename\n    id\n    content\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionSampleGraphQLFilterInput?

  public init(filter: ModelSubscriptionSampleGraphQLFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdateSampleGraphQL", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnUpdateSampleGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdateSampleGraphQl: OnUpdateSampleGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdateSampleGraphQL": onUpdateSampleGraphQl.flatMap { $0.snapshot }])
    }

    public var onUpdateSampleGraphQl: OnUpdateSampleGraphQl? {
      get {
        return (snapshot["onUpdateSampleGraphQL"] as? Snapshot).flatMap { OnUpdateSampleGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdateSampleGraphQL")
      }
    }

    public struct OnUpdateSampleGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["SampleGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, content: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "SampleGraphQL", "id": id, "content": content, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var content: String {
        get {
          return snapshot["content"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnDeleteSampleGraphQlSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnDeleteSampleGraphQL($filter: ModelSubscriptionSampleGraphQLFilterInput) {\n  onDeleteSampleGraphQL(filter: $filter) {\n    __typename\n    id\n    content\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionSampleGraphQLFilterInput?

  public init(filter: ModelSubscriptionSampleGraphQLFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onDeleteSampleGraphQL", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnDeleteSampleGraphQl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onDeleteSampleGraphQl: OnDeleteSampleGraphQl? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onDeleteSampleGraphQL": onDeleteSampleGraphQl.flatMap { $0.snapshot }])
    }

    public var onDeleteSampleGraphQl: OnDeleteSampleGraphQl? {
      get {
        return (snapshot["onDeleteSampleGraphQL"] as? Snapshot).flatMap { OnDeleteSampleGraphQl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onDeleteSampleGraphQL")
      }
    }

    public struct OnDeleteSampleGraphQl: GraphQLSelectionSet {
      public static let possibleTypes = ["SampleGraphQL"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, content: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "SampleGraphQL", "id": id, "content": content, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var content: String {
        get {
          return snapshot["content"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}