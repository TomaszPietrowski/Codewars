import XCTest

func revRot(_ s: String, _ c: Int) -> String {
    guard
        s.count >= c,
        s != "",
        c != 0
    else {
        return ""
    }
    
    let numbers = s.compactMap { Int(String($0)) }
    let chunkSize = c
    
    return stride(from: 0, to: s.count, by: chunkSize)
        .map {
            Array(numbers[$0..<min($0 + chunkSize, numbers.count)])
        }
        .filter { $0.count == chunkSize }
        .map { chunk -> [Int] in
            let sum: Int = chunk.reduce(into: 0, { $0 += $1 * $1 })
            
            if sum % 2 == 0 {
                return chunk.reversed()
            } else {
                var output = chunk
                output.append(output.remove(at: 0))
                return output
            }
        }
        .map { (array: [Int]) -> String in array.map(String.init).joined() }
        .joined()
}

class SolutionTest: XCTestCase {
    
    func testing(_ s: String, _ c: Int, _ expected: String) {
        XCTAssertEqual(revRot(s, c), expected)
    }
    
    func testExample() {
        testing("1234", 0, "")
        testing("", 0, "")
        testing("1234", 5, "")
        var s = "733049910872815764"
        testing(s, 5, "330479108928157")
        s = "73304991087281576455176044327690580265896"
        testing(s, 8, "1994033775182780067155464327690480265895")
        s = "73304991087281576455176044327690580265896896028"
        testing(s, 8, "1994033775182780067155464327690480265895")
    }
}

SolutionTest.defaultTestSuite.run()
