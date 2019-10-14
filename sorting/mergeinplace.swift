#!/usr/bin/swift sh
import Shared  // ../shared
// https://www.geeksforgeeks.org/merge-two-sorted-arrays-o1-extra-space/
// Given 2 sorted arrays, merged them such that the array1 is in sequence and all elements occur before array2 (both arrays maintain their original sizes)

func merge(_ a: inout [Int], _ b: inout [Int]) {
    for i in (0..<b.count).reversed() {
        var lastVal = a[a.count-1]
        guard a[a.count-1] <= b[i] else { continue }
        var j = a.count-1

        lastVal = b[i]
        b[i] = a[a.count-1]

        while j>0, lastVal < a[j-1] {
            a[j] = a[j-1]
            j -= 1
        }
        a[j] = lastVal
    }

    /*
    var i = b.count-1
    while i >= 0 {
        var j=a.count-2
        var lastVal = a[a.count-1]
        var didMove = false
        while j>=0, a[j] > b[i] {
            a[j+1] = a[j]
            j -= 1
            didMove = true
        }
        if didMove {
            a[j+1] = b[i]
            b[i] = lastVal
        }
        i -= 1
    }
    */
}

var a: [Int] = (0..<5).map { _ in .random(in: 0...100) }
var b: [Int] = (0..<8).map { _ in .random(in: 0...100) }

a.sort()
b.sort()

print("a: \(a)  isSorted: \(a.isSortedText)")
print("b: \(b)  isSorted: \(b.isSortedText)")
print("merge")
merge(&a, &b)
print("a: \(a)  isSorted: \(a.isSortedText)")
print("b: \(b)  isSorted: \(b.isSortedText)")
