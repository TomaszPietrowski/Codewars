import XCTest

func listSquared(_ m: Int, _ n: Int) -> [(Int, Int)] {
    return (m...n).map { number -> (Int, Int) in
        let sumOfSquaredDivisors = getDivisors(of: number)
            .reduce(into: 0) { $0 += $1 * $1 }
        
        return (number, sumOfSquaredDivisors)
    }.filter {
        return Double($0.1).squareRoot().truncatingRemainder(dividingBy: 1) == 0
    }
}

func getDivisors(of number: Int) -> [Int] {
    let squareRoot = Int(Double(number).squareRoot())
    var divisors: [Int] = []
    
    for n in 1...squareRoot {
        if number % n == 0 {
            let result = number / n
            divisors += result == n
                ? [n]
                : [n, result]
        }
    }
    
    return divisors
}


class SolutionTest: XCTestCase {
   
    func testing(_ m: Int, _ n: Int, _ expected: [(Int, Int)]) {
        let ans  = listSquared(m, n)
        if ans.count == expected.count {
            for i in 0..<expected.count {
                XCTAssertTrue(ans[i] == expected[i], "Actual and Expected don't have same value at index \(i) -> expected \(expected[i])")
            }
        }
        else { XCTAssertEqual(ans.count, expected.count, "Actual and Expected don't have same length") }
    }
    
    func testExample() {
        testing(1, 250, [(1, 1), (42, 2500), (246, 84100)])
        testing(1, 250, [(1, 1), (42, 2500), (246, 84100)])
        testing(42, 250, [(42, 2500), (246, 84100)])
        testing(250, 500, [(287, 84100)])
        testing(300, 600, [])
    }
}

SolutionTest.defaultTestSuite.run()
