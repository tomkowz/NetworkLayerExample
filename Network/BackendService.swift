import Foundation

public protocol BackendService {
    func request(_ request: BackendAPIRequest,
                 success: ((Any?) -> Void)?,
                 failure: ((NSError) -> Void)?)
    
    func cancel()
}
