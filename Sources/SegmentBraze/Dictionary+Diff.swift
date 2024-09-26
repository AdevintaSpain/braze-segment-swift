import Foundation
import Segment

extension Dictionary where Key == String, Value == Any {
    func newOrDifferentEntries(from dictionary: [String: Any]) -> [String: Any] {
        guard let selfJSON = try? JSON(self),
              let otherJSON = try? JSON(dictionary)
        else {
            return dictionary
        }

        var output = dictionary
        dictionary.forEach { key, value in
            guard let lhs = selfJSON[key],
                  let rhs = otherJSON[key] else {
                return
            }
            if lhs == rhs {
                output.removeValue(forKey: key)
            }
        }

        return output
    }
}
