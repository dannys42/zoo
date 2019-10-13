import Rainbow

public extension Array where Element: Comparable {
    func preSortPrint(_ verbose: Bool) {
        guard verbose else { return }

        print("Array before sort: \(self)")
    }
    func postSortPrint(_ verbose: Bool, passCount: Int) {
        guard verbose else { return }

        print("Array after sort: \(self)")
        let isSorted = (self.isSorted ? "true".green : "false".red).bold
        print("isSorted: \(isSorted)")
        print("Performed: \(passCount) iterations for size \(self.count)")
        print("")
    }

    /*
    func verboseSort(sortFunc: (_ input: [Element]) -> ([Element], Int)) {
        print("Array before sort: \(self)")

        let (newArray, passCount) = sortFunc(self)

        print("Array after sort: \(newArray)")
        print("isSorted: \(self.isSorted)")
        print("Performed: \(passCount) iterations for size \(self.count)")
        print("")
    }
    */
}
