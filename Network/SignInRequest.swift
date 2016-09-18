import Foundation

final class SignInRequest: BackendAPIRequest {
    
    private let email: String
    private let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var endpoint: String {
        return "/users/sign_in"
    }
    
    var method: NetworkService.Method {
        return .post
    }
    
    var query: NetworkService.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return [
            "email": email,
            "password": password
        ]
    }
    
    var headers: [String : String]? {
        return defaultJSONHeaders()
    }
}
