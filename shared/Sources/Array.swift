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
}
