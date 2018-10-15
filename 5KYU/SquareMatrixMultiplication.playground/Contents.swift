
import XCTest

func matrixMultiplication(_ a:[[Int]], _ b:[[Int]]) -> [[Int]] {
    var output: [[Int]] = []

    for i in 0..<a.count {
        output.append([])
        for j in 0..<a.count {
            output[i].append(
                zip(a[i], b.map{ $0[j] }).reduce(0) { (accumulator, elements) -> Int in
                    return accumulator + elements.0 * elements.1
                }
            )
        }
    }

    return output
}

class SolutionTest: XCTestCase {
    
    static var allTests = [
        ("testMatrixMultiplication", testMatrixMultiplication),
    ]

    func testMatrixMultiplication() {
        XCTAssertEqual(matrixMultiplication([[1, 2], [3, 2]], [[3, 2], [1, 1]]),[[5, 4], [11, 8]])
        XCTAssertEqual(matrixMultiplication([[9, 7], [0, 1]], [[1, 1], [4, 12]]),[[37, 93], [4, 12]])
        XCTAssertEqual(matrixMultiplication([[1, 2, 3], [3, 2, 1], [2, 1, 3]], [[4, 5, 6], [6, 5, 4], [4, 6, 5]]), [[28, 33, 29], [28, 31, 31], [26, 33, 31]])
    }
}

SolutionTest.defaultTestSuite.run()
