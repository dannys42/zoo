#!/usr/bin/swift sh
// https://www.geeksforgeeks.org/min-cost-path-dp-6/

struct Matrix {
    let width: Int
    let height: Int
    let values: [Int]

    private var cache: [Int?] = []

    init(width: Int, height: Int, _ values: [Int]) {
        self.width = width
        self.height = height

        self.cache = Array(repeating: nil, count: width*height)

        var v: [Int] = []
        v += Array(values.prefix(width*height))
        for _ in v.count..<width*height {
            v.append(0)
        }
        self.values = v
    }

    func getValue(_ w: Int, _ h: Int) -> Int {
        guard w >= 0 && w < self.width else {
            return .max
        }
        guard h >= 0 && h < self.height else {
            return .max
        }
        return self.values[w + h*self.width]
    }


    mutating func minCostTo(x: Int, y: Int) -> Int {
        if x < 0 || y < 0 {
            return .max
        }
        if let cVal = self.cache[x+y*self.width] {
            return cVal
        }
        if x == 0 && y == 0 {
            return self.getValue(0, 0)
        }

        var cost = self.getValue(x, y)

        let costUp = self.minCostTo(x: x, y: y-1)
        let costLeft = self.minCostTo(x: x-1, y: y)
        let costDiag = self.minCostTo(x: x-1, y: y-1)

        let costMin = min(min(costUp, costLeft), costDiag)

        cost += costMin
        self.cache[x+y*self.width] = cost

        return cost
    }
}

var m = Matrix(width: 3, height: 3, [1, 2, 3, 4, 8, 2, 1, 5, 3])

print("minCost to 2,2: \(m.minCostTo(x: 2, y:2 ))")

