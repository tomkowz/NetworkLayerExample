import Foundation

public class NetworkQueue {
    
    public static var shared: NetworkQueue!
    
    let queue = OperationQueue()
    
    public init() {}
    
    public func addOperation(_ op: Operation) {
        queue.addOperation(op)
    }
}
