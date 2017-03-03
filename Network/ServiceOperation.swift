import Foundation

public class ServiceOperation: NetworkOperation {
    
    let service: BackendService
    
    init(service: BackendService? = nil) {
        self.service = service ?? MyBackendService(BackendConfiguration.shared)
        super.init()
    }
    
    override public func cancel() {
        service.cancel()
        super.cancel()
    }
}
