#!/usr/bin/swift sh
// TODO: Not yet working
import Shared  // ../shared

extension Array where Element: Comparable {
    mutating func mergeSort(verbose: Bool = false) {
        self.preSortPrint(verbose)
        var passCount = self.doSort(start: 0, end: self.count-1)
        self.postSortPrint(verbose, passCount: passCount)
    }
    private mutating func doSort(start: Int, end: Int) -> Int {
        var passCount = 0
        guard start < end else { return passCount }
        guard end - start > 2 else { return passCount }

        print(" Sort orig: \(self)   start: \(start) end: \(end)")
        let midPoint = (end-start)/2 + start
        passCount += self.doSort(start: start, end: midPoint) + 1
        passCount += self.doSort(start: midPoint, end: end) + 1
        print(" Sort sort: \(self)   start: \(start) end: \(end)")
        self.doMerge(start: start, end: end)
        print(" Sort merge: \(self)   start: \(start) end: \(end)")
        print("")
        return passCount
    }
    mutating func doMerge(start: Int, end: Int) {
        var merged: [Element] = []
        var i = start
        let midPoint = (end-start+1)/2+start
        var j = midPoint

        print("merge input: \(self)  start: \(start)  midPoint: \(midPoint) j: \(j) end: \(end)")

        print("1. merged: \(merged)")
        while i < midPoint && j <= end {
            if self[i] < self[j] {
                merged.append(self[i])
                i += 1
            } else {
                merged.append(self[j])
                j += 1
            }
        }
        print("2. merged: \(merged)")
        while i < midPoint {
            merged.append(self[i])
            i += 1
        }
        print("3. merged: \(merged)")
        while j < end {
            merged.append(self[j])
            j += 1
        }
        print("4. merged: \(merged)")

        for k in start..<end {
            self[start+k] = merged[k]
        }
    }
}

var t1 = [ 1, 17, 65, /* */ 5, 10, 50 ]
print("pre merge: \(t1)")
t1.doMerge(start: 0, end: t1.count-1)
print("post merge: \(t1)  sorted: \(t1.isSortedText)")

var t2 = [ 1, 17, /* */ 5, 10, 50 ]
print("pre merge: \(t2)")
t2.doMerge(start: 0, end: t1.count-1)
print("post merge: \(t2)  sorted: \(t2.isSortedText)")

var a1 = [ 43,5 ,453,4, 63,42,4,3 ]
a1.mergeSort(verbose: true)

//var b: [Int] = (0..<100).map { _ in  .random(in: 0...100) }
//b.mergeSort(verbose: true)

