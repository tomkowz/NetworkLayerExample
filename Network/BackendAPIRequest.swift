import Foundation

public protocol BackendAPIRequest {
    var endpoint: String { get }
    var method: Method { get }
    var query: Query { get }
    var parameters: Parameters? { get }
    var headers: [String: String]? { get }
}

extension BackendAPIRequest {
    
    func defaultJSONHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }
}
