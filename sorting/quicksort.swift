#!/usr/bin/swift sh
import Shared  // ../shared

extension Array where Element: Comparable {
    mutating func quickSort(low: Int?=nil, high: Int?=nil) {
        let low = low ?? 0
        let high = high ?? self.count-1
        guard self.count > 0 else { return }
        guard high-low >= 1 else { return }
        let pNdx = self.partition(low: 0, high: high)
        
        print("quick left \(low) - \(pNdx-1) begin")
        self.quickSort(low: low, high: pNdx-1)
        print("quick left \(low) - \(pNdx-1)  end")

        print("quick right \(pNdx+1) - \(high) begin")
        self.quickSort(low: pNdx+1, high: high)
        print("quick right \(pNdx+1) - \(high) end")
    }
    internal mutating func partition(low: Int, high: Int) -> Int {
        print("partition: \(low) - \(high)")
        guard low >= 0 else { return -1 }
        guard high >= 0 else { return -1 }
        guard low < self.count else { return -1 }
        guard high < self.count else { return -1 }

        let pivotVal = self[high]
        var j = high
        var i = low

        while i < j {
            print("i = \(i)  j = \(j)")
            print("self[\(i)] begin")
            if self[i] < pivotVal {
                print("self[\(i)] end in if")
                i += 1
                print("   i++  \(i)")
                continue
            }
            print("self[\(i)] end out if")

            print("as1 beg")
            self[j] = self[i]
            print("as1 end")
            if (j-1) > i {
                print("as2 beg")
                self[i] = self[j-1]
                print("as2 end")
            }
            j -= 1
            print("   j--  \(j)")
        }
        self[j] = pivotVal
        return j
    }
}

var a = [5, 20, 7, 19, 8, 1]
print("Unsorted: \(a)")

//a.partition(low: 0, high: a.count-1)
//print("Partition: \(a)")

a.quickSort()
print("Sorted: \(a)")

for r in 0..<10 {
    print("--- run \(r) -----")
    var b: [Int] = (0..<20).map { _ in  .random(in: 0...100) }
    print("unsorted b: \(b)   isSorted: \(b.isSorted)")
    b.quickSort()
    print("  sorted b: \(b)   isSorted: \(b.isSorted)")
    print("")
}
