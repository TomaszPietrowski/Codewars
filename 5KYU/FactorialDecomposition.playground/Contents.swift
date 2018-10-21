import Foundation
import XCTest

func decomp(_ m: Int) -> String {
    let histogram: [Int: Int] = (2...m)
        .flatMap(factorize)
        .reduce(into: [:]) { $0[$1, default: 0] += 1 }
    
    return histogram
        .sorted { $0.0 < $1.0 }
        .map { (number, count) in
            count == 1 ? "\(number)" : "\(number)^\(count)"
        }
        .joined(separator: " * ")
}

func factorize(number: Int) -> [Int] {
    guard number > 3 else {
        return [number]
    }
    
    let squareRoot = Int(Double(number).squareRoot())
    var currentNumber = number
    var factors: [Int] = []
    
    for factor in 2...squareRoot {
        while currentNumber % factor == 0 {
            factors.append(factor)
            currentNumber /= factor
        }
    }
    
    return currentNumber == 1 ? factors : factors + [currentNumber]
}

class SolutionTest: XCTestCase {
    
    func testing(_ nb: Int, _ exp: String) {
        let actu = decomp(nb)
        XCTAssertEqual(actu, exp)
    }
    
    func testExample() {
        testing(17, "2^15 * 3^6 * 5^3 * 7^2 * 11 * 13 * 17")
        testing(5, "2^3 * 3 * 5")
        testing(22, "2^19 * 3^9 * 5^4 * 7^3 * 11^2 * 13 * 17 * 19")
    }
}

SolutionTest.defaultTestSuite.run()
