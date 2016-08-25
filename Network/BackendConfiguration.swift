import Foundation

public final class BackendConfiguration {
    
    let baseURL: URL
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public static var shared: BackendConfiguration!
}
