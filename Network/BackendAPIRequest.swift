import Foundation

protocol BackendAPIRequest {
    var endpoint: String { get }
    var method: NetworkService.Method { get }
    var query: NetworkService.QueryType { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension BackendAPIRequest {
    
    func defaultJSONHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }
}
