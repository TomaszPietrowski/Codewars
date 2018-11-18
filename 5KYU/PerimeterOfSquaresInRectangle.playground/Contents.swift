import XCTest

func perimeter(_ n: UInt64) -> UInt64 {
    return getConsecutiveFibonacciNumbers(count: n)
        .map { $0 * 4 }
        .reduce(0, +)
}

func getConsecutiveFibonacciNumbers(count n: UInt64) -> [UInt64] {
    var output = [UInt64]()
    
    output.append(1)
    guard n != 1 else {
        return output
    }
    
    output.append(1)
    guard n != 2 else {
        return output
    }
    
    for _ in (1..<n) {
        output.append(output.last! + output.dropLast().last!)
    }
    
    return output
}

class SolutionTest: XCTestCase {
    
    func dotest(_ n: UInt64, _ expected: UInt64) {
        XCTAssertEqual(perimeter(n), expected)
    }
    
    func testExample() {
        dotest(5, 80);
        dotest(7, 216);
        dotest(20, 114624);
        dotest(30, 14098308);
    }
}

SolutionTest.defaultTestSuite.run()
