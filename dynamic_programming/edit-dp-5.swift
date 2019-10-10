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


/*

result[1..n]

result[n] = 


*/
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

func f3(src: String, tgt: String) -> ([Operation]) { // insert operations, delete operations
    print("Transforming \(src) -> \(tgt)")
    var sNdx = 0
    var tNdx = 0
    var sRemaining = src.count
    var tRemaining = tgt.count
    var ops: [Operation] = []

    while sRemaining > 0 || tRemaining > 0 {
        if sRemaining == 0 {
            let t = String(tgt.prefix(tNdx).suffix(1))
            ops += [ .insert(t) ]

            tNdx += 1
            tRemaining -= 1
        } else if tRemaining == 0 {
            let s = String(src.prefix(sNdx).suffix(1))
            ops += [ .delete(s) ]

            sNdx += 1
            sRemaining -= 1
        } else {
            let s = String(src.prefix(sNdx).suffix(1))
            let t = String(tgt.prefix(tNdx).suffix(1))

            if s == t {
                sNdx += 1
                sRemaining -= 1
                tNdx += 1
                tRemaining -= 1
            } else {
                if sRemaining > tRemaining {
                    ops += [ .delete(s) ]
                    sNdx += 1
                    sRemaining -= 1
                } else {
                    ops += [ .insert(t) ]
                    tNdx += 1
                    tRemaining -= 1
                }
            }
        }
    }

    print("Operations (\(ops.count)): \(ops)")
    print("")
    return (ops)
}


func f2(src: String, tgt: String) -> ([Operation],[Operation]) { // insert operations, delete operations
    print("Transforming \(src) -> \(tgt)")
    var sNdx = 0
    var tNdx = 0
    var sRemaining = src.count
    var tRemaining = tgt.count
    var inserts: [Operation] = []
    var deletes: [Operation] = []

    while sRemaining > 0 || tRemaining > 0 {
        if sRemaining == 0 {
            let t = String(tgt.prefix(tNdx).suffix(1))
            inserts += [ .insert(t) ]

            tNdx += 1
            tRemaining -= 1
        } else if tRemaining == 0 {
            let s = String(src.prefix(sNdx).suffix(1))
            deletes += [ .delete(s) ]

            sNdx += 1
            sRemaining -= 1
        } else {
            let s = String(src.prefix(sNdx).suffix(1))
            let t = String(tgt.prefix(tNdx).suffix(1))

            if s == t {
                sNdx += 1
                sRemaining -= 1
                tNdx += 1
                tRemaining -= 1
            } else {
                if sRemaining > tRemaining {
                    deletes += [ .delete(s) ]
                    sNdx += 1
                    sRemaining -= 1
                } else {
                    inserts += [ .insert(t) ]
                    tNdx += 1
                    tRemaining -= 1
                }
            }
        }
    }

    print("Inserts (\(inserts.count)): \(inserts)")
    print("Deletes (\(deletes.count)): \(deletes)")
    print("")
    return (inserts, deletes)
}

func f(src: String, tgt: String, result: String="") -> ([Operation],[Operation]) { // insert operations, delete operations
    if result == "" {
        return ([],[])
    }
    if result == tgt {
        return ([],[])
    }

    /*
    switch (src=="", tgt=="") {
    case (true, true):
        return ([], [])
    case (true, _):
    case (_, true):
    }
    */


    if src.count < tgt.count {
        let c = String(tgt.prefix(0))

        let (inserts, deletes) = f(src: "", tgt: String(tgt.suffix(tgt.count-1)), result: result + c)
        return (inserts + [.insert(c)], deletes)
    } else if src.count > tgt.count {
        let c = String(src.prefix(0))

        let (inserts, deletes) = f(src: "", tgt: String(tgt.suffix(tgt.count-1)), result: result + c)

        return ([], [.delete(c)])
    } else {
        let s = String(src.prefix(0))
        let t = String(tgt.prefix(0))



    }

    return ([], [])
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

// ref: https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language

/*
extension StringProtocol {
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    subscript(_ range: Range<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}
extension LosslessStringConvertible {
    var string: String { return .init(self) }
}
extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}
*/
