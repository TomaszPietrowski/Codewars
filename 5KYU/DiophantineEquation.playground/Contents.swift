
import XCTest

func solequa(_ n: Int) -> [(Int, Int)] {
    let sqrtN = Int(Double(n).squareRoot())
    
    return Array(1...sqrtN)
        .filter { n % $0 == 0 }
        .map { ($0, n / $0) }
        .map { (a: Int, b: Int) -> (Double, Double) in
            let x = Double(a + b) / 2.0
            let y = (Double(b) - x) / 2.0
            return (x, y)
        }
        .filter { (x: Double, y: Double) -> Bool in
            x.truncatingRemainder(dividingBy: 1.0) == 0 && y.truncatingRemainder(dividingBy: 1.0) == 0
        }
        .map { (x: Double, y: Double) -> (Int, Int) in
            return (Int(x), Int(y))
        }
}

class SolutionTest: XCTestCase {
    
    static var allTests = [
        ("solequa", testExample),
    ]
    
    func testing(_ n: Int, _ expected: [(Int, Int)]) {
        let ans  = solequa(n)
        if ans.count == expected.count {
            for i in 0..<expected.count {
                XCTAssertTrue(ans[i] == expected[i], "Actual and Expected don't have same value at index \(i) -> expected \(expected[i])")
            }
        } else {
            XCTAssertEqual(ans.count, expected.count, "Actual and Expected don't have same length")
        }
    }
    
    func testExample() {
        testing(5, [(3, 1)])
        testing(12, [(4, 1)])
        testing(13, [(7, 3)])
        testing(9001, [(4501, 2250)])
        testing(9005, [(4503, 2251), (903, 449)])
    }
}

SolutionTest.defaultTestSuite.run()
