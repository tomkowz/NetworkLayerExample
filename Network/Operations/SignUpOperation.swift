import Foundation

public class SignUpOperation: ServiceOperation {
    
    private let request: SignUpRequest
    
    public var success: ((UserItem) -> Void)? = nil
    public var failure: ((NSError) -> Void)? = nil
    
    public init(user: UserItem, password: String, service: BackendService? = nil) {
        request = SignUpRequest(user: user, password: password)
        super.init(service: service)
    }
    
    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: Any?) {
        do {
            let item = try UserResponseMapper.process(response)
            self.success?(item)
            self.finish()
        } catch {
            handleFailure(NSError.cannotParseResponse())
        }
    }
    
    private func handleFailure(_ error: NSError) {
        self.failure?(error)
        self.finish()
    }
}
