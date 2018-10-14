/*:
 ### Count the Digit
 Take an integer n (n >= 0) and a digit d (0 <= d <= 9) as an integer. Square all numbers k (0 <= k <= n) between 0 and n. Count the numbers of digits d used in the writing of all the k**2. Call nbDig the function taking n and d as parameters and returning this count.
 */
import Foundation
import XCTest

func nbDig(_ n: Int, _ d: Int) -> Int {
    return (0...n)
        .map { number -> Int in
            let digitCount = String(number * number).components(separatedBy: String(d)).count - 1
            return max(0, digitCount)
        }
        .reduce(0, +)
}

class SolutionTest: XCTestCase {
    
    func testExample() {
        XCTAssertEqual(nbDig(5750, 0), 4700)
        XCTAssertEqual(nbDig(11011, 2), 9481)
        XCTAssertEqual(nbDig(12224, 8), 7733)
        XCTAssertEqual(nbDig(11549, 1), 11905)
    }
}

SolutionTest.defaultTestSuite.run()
