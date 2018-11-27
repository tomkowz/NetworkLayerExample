import Foundation

/// REST Methods
///
/// - get: GET
/// - post: POST
/// - put: PUT
/// - delete: DELETE
public enum Method: String {
    case get, post, put, delete
}


/// The differents types of query
///
/// - json: Add the parameters in a Json inside the HTTP body request
/// - path: Add the parameters as query in the URL
/// - jsonImage: Add the parameters and image bytes in a Json inside the HTTP body request
public enum Query {
    case json, path, jsonImage
}

public typealias Parameters = [String: Any]

class NetworkService {
    
    private var task: URLSessionDataTask?
    private var successCodes: CountableRange<Int> = 200..<299
    private var failureCodes: CountableRange<Int> = 400..<499
    
    func makeRequest(for url: URL, method: Method, query type: Query,
                     params: Parameters? = nil,
                     headers: [String: String]? = nil,
                     success: ((Data?) -> Void)? = nil,
                     failure: ((_ data: Data?, _ error: NSError?, _ responseCode: Int) -> Void)? = nil) {
        
        
        var mutableRequest = NetworkQueryGeneretor().makeQuery(for: url, params: params, type: type)
        
        mutableRequest.allHTTPHeaderFields = headers
        mutableRequest.httpMethod = method.rawValue
        
        let session = URLSession.shared
        
        task = session.dataTask(with: mutableRequest as URLRequest, completionHandler: { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data, error as NSError?, 0)
                return
            }
            
            if let error = error {
                // Request failed, might be internet connection issue
                failure?(data, error as NSError, httpResponse.statusCode)
                return
            }
            
            if self.successCodes.contains(httpResponse.statusCode) {
                print("Request finished with success.")
                success?(data)
            } else if self.failureCodes.contains(httpResponse.statusCode) {
                print("Request finished with failure.")
                failure?(data, error as NSError?, httpResponse.statusCode)
            } else {
                print("Request finished with serious failure.")
                // Server returned response with status code different than
                // expected `successCodes`.
                let info = [
                    NSLocalizedDescriptionKey: "Request failed with code \(httpResponse.statusCode)",
                    NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoing mapping or backend bug."
                ]
                let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
                failure?(data, error, httpResponse.statusCode)
            }
        })
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
