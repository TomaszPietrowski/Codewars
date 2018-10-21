import Foundation
import XCTest

func spiral(_ n: Int) -> [[Int]] {
    var matrix = Array(repeating: Array(repeating: 0, count: n), count: n)
    var iterator = 0
    var startIndex = 0
    var endIndex = n - 1
    
    while endIndex - startIndex > 1 {
        switch iterator % 4 {
            case 0:
                for i in startIndex...endIndex {
                    matrix[iterator / 4 * 2][i] = 1
                }
            case 1:
                startIndex = iterator / 4 == 0 ? startIndex : startIndex + 2
                for i in startIndex...endIndex {
                    matrix[i][endIndex] = 1
                }
            case 2:
                for i in startIndex...endIndex {
                    matrix[endIndex][i] = 1
                }
            case 3:
                for i in startIndex + 2...endIndex {
                    matrix[i][startIndex] = 1
                }
                endIndex -= 2
            default:
                break
        }
        iterator += 1
    }
    
    return matrix
}

class SolutionTest: XCTestCase {
    
    func testSpiral5x5() {
        XCTAssertEqual(spiral(5), [
            [1, 1, 1, 1, 1],
            [0, 0, 0, 0, 1],
            [1, 1, 1, 0, 1],
            [1, 0, 0, 0, 1],
            [1, 1, 1, 1, 1],
        ])
    }
    
    func testSpiral6x6() {
        XCTAssertEqual(spiral(6), [
            [1, 1, 1, 1, 1, 1],
            [0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 0, 1],
            [1, 0, 0, 1, 0, 1],
            [1, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1],
        ])
    }
    
    func testSpiral7x7() {
        XCTAssertEqual(spiral(7), [
            [1, 1, 1, 1, 1, 1, 1],
            [0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 1, 0, 1],
            [1, 0, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 1],
        ])
    }
    
    func testSpiral8x8() {
        XCTAssertEqual(spiral(8), [
            [1, 1, 1, 1, 1, 1, 1, 1],
            [0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 1, 0, 1],
            [1, 0, 1, 0, 0, 1, 0, 1],
            [1, 0, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 1, 1],
        ])
    }
    
    func testSpiral9x9() {
        XCTAssertEqual(spiral(9), [
            [1, 1, 1, 1, 1, 1, 1, 1, 1],
            [0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 1, 0, 1],
            [1, 0, 1, 1, 1, 0, 1, 0, 1],
            [1, 0, 1, 0, 0, 0, 1, 0, 1],
            [1, 0, 1, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1],
        ])
    }
    
    func testSpiral10x10() {
        XCTAssertEqual(spiral(10), [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 1, 0, 1],
            [1, 0, 1, 1, 1, 1, 0, 1, 0, 1],
            [1, 0, 1, 0, 0, 1, 0, 1, 0, 1],
            [1, 0, 1, 0, 0, 0, 0, 1, 0, 1],
            [1, 0, 1, 1, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        ])
    }
}

SolutionTest.defaultTestSuite.run()
