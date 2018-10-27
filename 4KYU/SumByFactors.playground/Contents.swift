import XCTest

func geUniqueElements(of array: [Int]) -> [Int] {
    return Array(Set(array))
}

func getPrimeFactors(of number: Int) -> [Int] {
    let roundedSquareRoot = Int(Double(number).squareRoot())
    var primeFactors: [Int] = []
    var tempNumber = number
    
    for factor in 2...roundedSquareRoot {
        while tempNumber % factor == 0 {
            tempNumber /= factor
            primeFactors.append(factor)
        }
    }
    
    primeFactors = tempNumber == 1 ? primeFactors : primeFactors + [tempNumber]
    
    return geUniqueElements(of: primeFactors)
}

func sumOfDivided(_ l: [Int]) -> [(Int, Int)] {
    let primeFactors = l.map(abs).map(getPrimeFactors)
    let allPrimeFactors = geUniqueElements(of: primeFactors.flatMap { $0 }).sorted()
    let inputWithPrimeFactors = zip(l, primeFactors)
    var output: [(Int, Int)] = []
    
    allPrimeFactors.forEach { primeFactor in
        let sum = inputWithPrimeFactors
            .filter { $0.1.contains(primeFactor) }
            .map { $0.0 }
            .reduce(0, +)
        
        output.append((primeFactor, sum))
    }
    
    return output
}

class SolutionTest: XCTestCase {
    
    func testing(_ l: [Int], _ expected: [(Int, Int)]) {
        XCTAssertTrue(sumOfDivided(l).elementsEqual(expected, by: ==), "should return \(expected)")
    }
    
    func testExample() {
        testing([12, 15], [(2, 12), (3, 27), (5, 15)])
        testing([15,21,24,30,45], [(2, 54), (3, 135), (5, 90), (7, 21)])
    }
}

SolutionTest.defaultTestSuite.run()
