#!/usr/bin/swift sh
// Problem 130: Edit Distance DP-5  https://www.geeksforgeeks.org/edit-distance-dp-5/

enum Operation {
    case insert(String)
    case delete(String)
}
extension Operation: CustomStringConvertible {
    var description: String {
        switch self {
        case .insert(let s): return "i(\(s))"
        case .delete(let s): return "d(\(s))"
        }
    }
}
extension Array where Element == Operation {
    func printOps() {
        print("Operations (\(self.count)): \(self)")
        print("")
    }
}

public extension String {
    func truncating(first n: Int) -> String {
        return String(self.suffix(self.count-n))
    }
    func truncating(last n: Int) -> String {
        return String(self.prefix(self.count-n))
    }
}


var numOperations = 0
func f4(src: String, tgt: String, printTitle: Bool = false, cache: inout [String:[Operation]]) -> ([Operation]) { // insert operations, delete operations
    numOperations += 1
    if printTitle {
        print("Transforming \(src) -> \(tgt)")
    }
    var ops: [Operation] = []

    if src.count == 0 && tgt.count == 0 {
        return ops
    }
    if src.count == 0 {
        for (_,c) in tgt.enumerated() {
            ops += [ .insert(String(c)) ]
        }
        return ops
    } else if tgt.count == 0 {
        for (_,c) in src.enumerated() {
            ops += [ .delete(String(c)) ]
        }
        return ops
    } else {
        let s = String(src.prefix(1))
        let t = String(tgt.prefix(1))

        let cacheKey = "\(src)-\(tgt)"
        if let ops = cache[cacheKey] {
            return ops
        }

        if s == t {
            ops = f4(src: src.truncating(first: 1), tgt: tgt.truncating(first: 1), cache: &cache)
        } else {
            let iOp = [ .insert(t) ] + f4(src: src, tgt: tgt.truncating(first: 1), cache: &cache)
            let dOp = [ .delete(s) ] + f4(src: src.truncating(first: 1), tgt: tgt, cache: &cache)

            if iOp.count < dOp.count {
                ops = iOp
            } else {
                ops = dOp
            }
        }


        cache[cacheKey] = ops
    }

    return (ops)
}

var cache: [String:[Operation]]
numOperations = 0
cache = [:]
f4(src: "Heap", tgt: "Pea", printTitle: true, cache: &cache).printOps()
print("  \(numOperations) operations")

numOperations = 0
cache = [:]
f4(src: "geeksforgeeks", tgt: "geeks", printTitle: true, cache: &cache).printOps()
print("  \(numOperations) operations")

numOperations = 0
cache = [:]
f4(src: "Hello", tgt: "Hilo Byeo", printTitle: true, cache: &cache).printOps()
print("  \(numOperations) operations")

