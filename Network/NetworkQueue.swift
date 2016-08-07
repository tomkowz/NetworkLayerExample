import Foundation

public class NetworkQueue {
    
    public static var shared: NetworkQueue!
    
    let queue = NSOperationQueue()
    
    public init() {}
    
    public func addOperation(op: NSOperation) {
        queue.addOperation(op)
    }
}