#!/usr/bin/swift sh
import Shared  // ../shared

extension Array where Element: Comparable {
    mutating func bubbleSort(verbose: Bool = false) {
        var passCount = 0
        self.preSortPrint(verbose)
        for i in (1...self.count).reversed() {
            passCount += self.onePass(startIndex: 1, endIndex: i)
        }
        self.postSortPrint(verbose, passCount: passCount)
    }
    private mutating func onePass(startIndex: Int, endIndex: Int) -> Int {
        var passCount = 0
        for i in startIndex..<endIndex {
            passCount += 1
            let lastVal = self[i-1]
            let curVal = self[i]

            if curVal < lastVal {
                swap(i-1, i)
            }
        }
        return passCount
    }
}

var a1 = [ 43,5 ,453,4, 63,42,4,3 ]
a1.bubbleSort(verbose: true)
a1.bubbleSort(verbose: true)

var b: [Int] = (0..<100).map { _ in  .random(in: 0...100) }
b.bubbleSort(verbose: true)

