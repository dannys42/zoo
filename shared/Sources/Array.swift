public extension Array where Element: Comparable {
    var isSorted: Bool {
        for i in 1..<self.count {
            let prevVal = self[i-1]
            let curVal = self[i]

            if curVal < prevVal {
                return false
            }
        }
        return true
    }
    mutating func swap(_ ndx1: Int, _ ndx2: Int) {
        guard ndx1 >= 0 && ndx2 >= 0 else {
            return
        }
        guard ndx1 < self.count && ndx2 < self.count else {
            return
        }
        let a = self[ndx1]
        self[ndx1] = self[ndx2]
        self[ndx2] = a
    }
}
