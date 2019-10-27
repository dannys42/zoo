#!/usr/bin/swift sh
import Shared  // ../shared

extension Array where Element == Int {
    func findN() -> Int {
        guard self.count > 0 else {
            return -1
        }

        var n = self.count-1
        var minVal = self[n]

        for i in (0..<(self.count-1)).reversed() {
            if self[i] < self[i+1] && self[i] < minVal {
                minVal = self[i]
                continue
            }
            n = i
        }
        return n
    }
    func findM() -> Int {
        guard self.count > 0 else {
            return -1
        }

        var n = 0
        var maxVal = self[n]

        for i in (1..<(self.count-1)) {
            if self[i] > self[i-1] && self[i] > maxVal {
                maxVal = self[i]
                continue
            }
            n = i
        }
        return n
    }
}

var v = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]
print("v: \(v)")

let n = v.findN()
let m = v.findM()

print("n: \(n)")
print("m: \(m)")
