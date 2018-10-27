import XCTest

let alphabet = (97...122).map { Character(UnicodeScalar($0)) }

func mix(_ s1: String, _ s2: String) -> String {
    let l1 = process(input: s1)
    let l2 = process(input: s2)
    
    let charactersWIthFrequencies = Set((l1 + l2).map{ $0.0 })
        .map { character -> (Character, Int, Int) in
            return (character, getFrequency(of: character, in: l1), getFrequency(of: character, in: l2))
        }
    
    return Set(charactersWIthFrequencies.map { max($0.1, $0.2) })
        .map { frequency in
            charactersWIthFrequencies.filter { frequency == max($0.1, $0.2) }
        }
        .flatMap { subset -> [(Character, Int, String)] in
            let first = subset.filter { $0.1 > $0.2 }.map { ($0.0, $0.1, "1:") }
            let second = subset.filter { $0.1 < $0.2 }.map { ($0.0, $0.2, "2:") }
            let equal = subset.filter { $0.1 == $0.2 }.map { ($0.0, $0.1, "E:") }
            return [first, second, equal]
                .flatMap { $0.sorted { $0.0 < $1.0 } }
        }
        .sorted  { $0.1 > $1.1 }
        .map(getString)
        .joined(separator: "/")
}

func getString(character: Character, count: Int, prefix: String) -> String {
    let characters = (0..<count).map { _ in String(character) }.joined()
    return prefix + characters
}

func getFrequency(of character: Character, in array: [(Character, Int)]) -> Int {
    return array.first{ $0.0 == character }?.1 ?? 0
}

func process(input: String) -> [(Character, Int)] {
    let inputLetters = input.filter(alphabet.contains)
    return Array(Set(inputLetters))
        .map { character in (character, inputLetters.filter{ $0 == character }.count) }
        .filter { $0.1 > 1 }
}

class SolutionTest: XCTestCase {
    
    func testing(_ s1: String, _ s2: String, _ expected: String) {
        XCTAssertEqual(mix(s1, s2), expected)
    }
    
    func testExample() {
        testing("Are they here", "yes, they are here",
                "2:eeeee/2:yy/E:hh/E:rr")
        testing("looping is fun but dangerous", "less dangerous than coding",
                "1:ooo/1:uuu/2:sss/E:nnn/1:ii/2:aa/2:dd/2:ee/E:gg")
        testing(" In many languages", " there's a pair of functions",
                "1:aaa/1:nnn/1:gg/2:ee/2:ff/2:ii/2:oo/2:rr/2:ss/2:tt")
        testing("Lords of the Fallen", "gamekult", "1:ee/1:ll/1:oo")
        testing("codewars", "codewars", "")
        testing("A generation must confront the looming ",
                "codewarrs", "1:nnnnn/1:ooooo/1:tttt/1:eee/1:gg/1:ii/1:mm/E:rr")
    }
}

SolutionTest.defaultTestSuite.run()
