#!/usr/bin/swift sh
// Longest Increasing Subsequence
// https://www.geeksforgeeks.org/longest-increasing-subsequence-dp-3/
//

func lis(_ array: [Int]) -> Int {
    struct Record {
        var len: Int
        var curMin: Int
        var startIndex: Int
        var endIndex: Int
    }
    var record: Record?
    var current: Record?
    for (ndx,val) in array.enumerated() {
        print("array[\(ndx)] = \(val)")
        defer {
            if record == nil {
                record = current
            }
            if var r = record,
                val > r.curMin
            {
                r.len += 1
                r.curMin = val
                r.endIndex = ndx
            }
        }
        guard let cur = current else {
            current = Record(len: 1, curMin: val, startIndex: ndx, endIndex: ndx)
            continue
        }
        if let r = record {
            if val < r.curMin {
            
            } else {
                record = nil
            }
        } else {
            record = Record(len: 1, curMin: val, startIndex: ndx, endIndex: ndx)
        }

    }

    return record?.len ?? 0
}


let r = lis([10, 22, 9, 33, 21, 50, 41, 60, 80])
print("result: \(r)")
