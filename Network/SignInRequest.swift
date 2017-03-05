import Foundation

struct SignInRequest: BackendAPIRequest {
    
    private let email: String
    private let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var endpoint: String {
        return "/users/sign_in"
    }
    
    var method: Method {
        return .post
    }
    
    var query: Query {
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
