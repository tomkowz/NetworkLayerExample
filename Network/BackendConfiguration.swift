import Foundation

public final class BackendConfiguration {
    
    let baseURL: NSURL
    
    public init(baseURL: NSURL) {
        self.baseURL = baseURL
    }
    
    public static var shared: BackendConfiguration!
}
