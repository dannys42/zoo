#!/usr/bin/swift sh
// Edit Distance DP-5  https://www.geeksforgeeks.org/edit-distance-dp-5/

enum Operation {
    case insert(String)
    case delete(String)
    case replace(String, String)
}

extension Operation: CustomStringConvertible {
    var description: String {
        switch self {
            case .insert(let s): return "i(\(s))"
            case .delete(let s): return "i(\(s))"
            case .replace(let s): return "i(\(s))"
        }
    }
}


func ops(_ s1: String, _ s2: String) -> [Operation] {
    let m = s1.count-1
    let n = s2.count-1

    return []
}

extension String {
    func skipping(first: Int) -> String {
        return String(self.suffix(self.count-first))
    }
    func skipping(last: Int) -> String {
        return String(self.prefix(self.count-last))
    }
}

let h = "Hello World!"
print(" skipping first: '\(h.skipping(first: 5))'")
print(" skipping last: '\(h.skipping(last: 7))'")
