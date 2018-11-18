import XCTest

func longestConsec(_ strarr: [String], _ k: Int) -> String {
    guard strarr.count >= k else {
        return ""
    }
    var concatenatedStrings = [String]()
    
    for index in 0...strarr.count - k {
        concatenatedStrings.append(
            strarr[index..<(index + k)].joined()
        )
    }
    
    return concatenatedStrings
        .sorted { $0.count > $1.count }
        .first ?? ""
}

class SolutionTest: XCTestCase {
    
    func testing(_ strarr: [String], _ k: Int, _ expected: String) {
        XCTAssertEqual(longestConsec(strarr, k), expected)
    }
    
    func testExample() {
        testing(["zone", "abigail", "theta", "form", "libe", "zas"], 2, "abigailtheta")
        testing(["ejjjjmmtthh", "zxxuueeg", "aanlljrrrxx", "dqqqaaabbb", "oocccffuucccjjjkkkjyyyeehh"], 1,
                "oocccffuucccjjjkkkjyyyeehh")
        testing([], 3, "")
        testing(["itvayloxrp","wkppqsztdkmvcuwvereiupccauycnjutlv","vweqilsfytihvrzlaodfixoyxvyuyvgpck"], 2,
                "wkppqsztdkmvcuwvereiupccauycnjutlvvweqilsfytihvrzlaodfixoyxvyuyvgpck")
    }
}

SolutionTest.defaultTestSuite.run()
