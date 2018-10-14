import XCTest

let alphabet = (0..<26).map { Character(UnicodeScalar("a".unicodeScalars.first!.value + $0)!) }

enum Mode {
    case encryption, decryption
}

func movingShift(_ s: String, _ shift: Int) -> [String] {
    let messages =  process(input: s, shift: shift, type: .encryption)
        .components(withLength: Int((Double(s.count) / 5.0).rounded(.up)))
    
    return messages.count == 5
        ? messages
        : messages + Array(repeating: "", count: 5 - messages.count)
}

func demovingShift(_ arr: [String], _ shift: Int) -> String {
    return process(input: arr.reduce("", +), shift: shift, type: .decryption)
}

func process(input: String, shift: Int, type: Mode) -> String {
    var output = ""
    
    zip(input, input.lowercased())
        .enumerated()
        .forEach { index, characters in
            guard let alphabetIndex = alphabet.index(of: characters.1) else {
                output.append(characters.0)
                return
            }
            
            var outputCharacter: String
            switch type {
                case .encryption:
                    outputCharacter = String(alphabet[(alphabetIndex + index + shift) % alphabet.count])
                case .decryption:
                    let decodedIndex = (alphabetIndex - index - shift) % alphabet.count
                    outputCharacter = String(alphabet[decodedIndex >= 0 ? decodedIndex : alphabet.count + decodedIndex])
            }
            
            output.append(characters.0 == characters.1 ? outputCharacter : outputCharacter.uppercased())
        }
    
    return output
}

extension String {
    
    func components(withLength length: Int) -> [String] {
        return stride(from: 0, to: count, by: length)
            .map {
                let start = index(startIndex, offsetBy: $0)
                let end = index(start, offsetBy: length, limitedBy: endIndex) ?? endIndex
                return String(self[start..<end])
        }
    }
}

class SolutionTest: XCTestCase {
    static var allTests = [
        ("movingShift", testExample1),
        ("demovingShift", testExample2),
    ]
    
    func dotest1(_ s: String, _ shift: Int, _ expected: [String]) {
        XCTAssertEqual(movingShift(s, shift), expected, "should return \(expected)")
    }
    
    func dotest2(_ arr: [String], _ shift: Int, _ expected: String) {
        XCTAssertTrue(demovingShift(arr, shift) == expected, "should return \(expected)")
    }
    
    func dotest3(_ s: String, _ shift: Int) {
        XCTAssertTrue(demovingShift(movingShift(s, shift), shift) == s, "should return \(s)")
    }
    
    func testExample1() {
        let u = "I should have known that you would have a perfect answer for me!!!"
        let sol = ["J vltasl rlhr ", "zdfog odxr ypw", " atasl rlhr p ", "gwkzzyq zntyhv", " lvz wp!!!"]
        dotest1(u, 1, sol)
    }
    
    func testExample2() {
        let u = "O CAPTAIN! my Captain! our fearful trip is done;"
        let sol = ["Y ONDIQZF!", " hu Azpucl", "r! vca qqn", "fukc mldl ", "gr eqqi;"]
        dotest2(sol, 10, u)
    }
}

SolutionTest.defaultTestSuite.run()
