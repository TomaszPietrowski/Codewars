
import XCTest

func orderWeight(_ s: String) -> String {
    return s
        .split(separator: " ")
        .compactMap { input -> (String, Int) in
            let weight = input
                    .compactMap { Int(String($0)) }
                    .reduce(0, +)
            
            return (String(input), weight)
        }
        .sorted {
            if $0.1 == $1.1 {
                return $0.0 < $1.0
            } else {
                return $0.1 < $1.1
            }
        }
        .map { $0.0 }
        .joined(separator: " ")
}

class SolutionTest: XCTestCase {
    
    func testing(_ s: String, _ expected: String) {
        XCTAssertEqual(orderWeight(s), expected)
    }
    
    func testExample() {
        testing("103 123 4444 99 2000", "2000 103 123 4444 99")
        testing("2000 10003 1234000 44444444 9999 11 11 22 123",
                "11 11 2000 10003 22 123 1234000 44444444 9999")
        testing("", "")
        testing("10003 1234000 44444444 9999 2000 123456789",
                "2000 10003 1234000 44444444 9999 123456789")
    }
}

SolutionTest.defaultTestSuite.run()
