import Foundation

class NetworkService {
    
    private var task: URLSessionDataTask?
    private var successCodes: CountableRange<Int> = 200..<299
    private var failureCodes: CountableRange<Int> = 400..<499
    
    enum Method: String {
        case GET, POST, PUT, DELETE
    }
    
    enum QueryType {
        case JSON, PATH
    }
    
    func makeRequest(for url: URL, method: Method, query type: QueryType?,
                 params: [String: AnyObject]? = nil,
                 headers: [String: String]? = nil,
                 success: ((Data?) -> Void)? = nil,
                 failure: ((data: Data?, error: NSError?, responseCode: Int) -> Void)? = nil) {
        
        guard let params = params, let type = type else {
            failure?(data: nil, error: nil, responseCode: 499)
            return
        }
        
        guard let mutableRequest = makeQuery(for: url, params: params, type: type) else {
            failure?(data: nil, error: nil, responseCode: 499)
            return
        }
        
        mutableRequest.allHTTPHeaderFields = headers
        mutableRequest.httpMethod = method.rawValue
        
        let session = URLSession.shared

        task = session.dataTask(with: mutableRequest as URLRequest, completionHandler: { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data: data, error: error, responseCode: 0)
                return
            }
            
            if let error = error {
                // Request failed, might be internet connection issue
                failure?(data: data, error: error, responseCode: httpResponse.statusCode)
                return
            }
            
            if self.successCodes.contains(httpResponse.statusCode) {
                print("Request finished with success.")
                success?(data)
            } else if self.failureCodes.contains(httpResponse.statusCode) {
                print("Request finished with failure.")
                failure?(data: data, error: error, responseCode: httpResponse.statusCode)
            } else {
                print("Request finished with serious failure.")
                // Server returned response with status code different than
                // expected `successCodes`.
                let info = [
                    NSLocalizedDescriptionKey: "Request failed with code \(httpResponse.statusCode)",
                    NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoing mapping or backend bug."
                ]
                let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
                failure?(data: data, error: error, responseCode: httpResponse.statusCode)
            }
        })
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    
    //MARK: Private
    private func makeQuery(for url: URL, params: [String: AnyObject], type: QueryType) -> NSMutableURLRequest? {
        switch type {
        case .JSON:
            let mutableRequest = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                                     timeoutInterval: 10.0)
            mutableRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            
            return mutableRequest
        case .PATH:
            var query = ""
            
            for (key, value) in params {
                query = query + key + "=" + (value as! String) + "&"
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.query = "\(query)"
            
            guard let comp = components else {
                return nil
            }
            return NSMutableURLRequest(url: comp.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        }
        
    }
}


