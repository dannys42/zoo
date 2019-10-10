#!/usr/bin/swift sh
// https://www.geeksforgeeks.org/ugly-numbers/
// "simple" solution

func isOnlyDivisible(_ n: Int, primeList: [Int]) -> Bool {
    var remaining: Int = n
    for prime in primeList {
        while (remaining % prime) == 0 {
            remaining /= prime
        }
    }
    if remaining == 1 {
        return true
    }
    return false
}

var cache: [Int:Int] = [:]
func ugly(_ n: Int) -> Int {
    if n == 0 {
        return 1
    }

    if let v = cache[n] {
        return v
    }
    let prev = ugly(n-1)

    var k=0
    while true {
        k += 1
        let next = prev + k
        if isOnlyDivisible(next, primeList: [2, 3, 5]) {
            cache[n] = next
            return next
        }
    }
}

for n in 0..<150 {
    let u = ugly(n)

    print("\(n+1): \(u)")
}
