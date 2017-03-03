import Foundation

final class SignUpRequest: BackendAPIRequest {
    
    private let user: UserItem
    private let password: String
    
    init(user: UserItem, password: String) {
        self.user = user
        self.password = password
    }
    
    var endpoint: String {
        return "/users"
    }
    
    var method: Method {
        return .post
    }
    
    var query: Query {
        return .json
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        params["first_name"] = user.firstName
        params["last_name"] = user.lastName
        params["email"] = user.email
        params["phone_number"] = user.phoneNumber ?? NSNull()
        params["password"] = password
        return params
    }
    
    var headers: [String: String]? {
        return defaultJSONHeaders()
    }
}
