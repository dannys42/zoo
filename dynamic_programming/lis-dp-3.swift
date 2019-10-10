#!/usr/bin/swift sh
// Longest Increasing Subsequence (non-continguous)
// https://www.geeksforgeeks.org/longest-increasing-subsequence-dp-3/

extension Array where Element == Int {
    @discardableResult
    func show(_ s: String) -> [Int] {
        let seq = self.map { "\($0)" }.joined(separator: ", ")
        print("\(s): " + seq)
        return self
    }
    func trunc(first: Int) -> [Int] {
        return self.suffix(self.count-first)
    }
}


func f(_ s: [Int], oldSeq: [Int] = []) -> [Int] {
    guard let sFirst = s.first else {
        return oldSeq
    }

    if let oLast = oldSeq.last {
        if oLast < sFirst {
            let includeSeq = f(s.trunc(first: 1), oldSeq:  oldSeq + [ s[0] ])
            let excludeSeq = f(s.trunc(first: 1), oldSeq: oldSeq)

            if includeSeq.count > excludeSeq.count {
                return includeSeq
            } else {
                return excludeSeq
            }
        } else {
            return f(s.trunc(first: 1))
        }
    } else {
        return f(s.trunc(first: 1), oldSeq: oldSeq + [ s[0] ])
    }

    return oldSeq
}


f([10, 5, 3, 6, 8, 20]).show("Sequence: ")
f([1, 2, 3, 2, 4, 9]).show("Sequence: ")


