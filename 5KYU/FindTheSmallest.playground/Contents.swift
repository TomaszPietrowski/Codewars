
import XCTest

func smallest(_ n: Int) -> (Int, Int, Int) {
    let digits = "\(n)".compactMap{Int(String($0))}
    var output: (Int, Int, Int) = (n, digits.count, digits.count)
    
    
    for oldIndex in 0..<digits.count {
        for newIndex in 0..<digits.count {
            var tempDigits = digits
            tempDigits.insert(tempDigits.remove(at: oldIndex), at: newIndex)
            let number = tempDigits.reduce(0, { $0 * 10 + $1 })
            
            if number < output.0 || (number == output.0 && oldIndex < output.1) {
                output = (number, oldIndex, newIndex)
            }
        }
    }
    
    return output
}

class SolutionTest: XCTestCase {

    func dotest(_ n: Int, _ expected: (Int, Int, Int)) {
        let ans = smallest(n)
        XCTAssertTrue(ans == expected, "should return \(expected) but got \(ans)")
    }

    func testExample() {
        dotest(261235, (126235, 2, 0))
        dotest(209917, (29917, 0, 1))
        dotest(285365, (238565, 3, 1))
        dotest(269045, (26945, 3, 0))
        dotest(296837, (239687, 4, 1))
        dotest(161529384, (115269384, 1, 4))
    }
}

SolutionTest.defaultTestSuite.run()
