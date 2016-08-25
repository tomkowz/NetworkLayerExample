import Foundation
import Network

class NetworkLayerConfiguration {
    
    class func setup() {
        // Backend Configuration
        let url = URL(string: "https://fake.url")!
        let conf = BackendConfiguration(baseURL: url)
        BackendConfiguration.shared = conf
        
        // Network Queue
        NetworkQueue.shared = NetworkQueue()
    }
}
