import Foundation

open class ArrayResponseMapper<A: ParsedItem> {
    static func process(_ obj: Any?, mapper: ((Any?) throws -> A)) throws -> [A] {
        guard let json = obj as? [[String: Any]] else { throw ResponseMapperError.invalid }
        
        var items = [A]()
        for jsonNode in json {
            let item = try mapper(jsonNode)
            items.append(item)
        }
        return items
    }
}
