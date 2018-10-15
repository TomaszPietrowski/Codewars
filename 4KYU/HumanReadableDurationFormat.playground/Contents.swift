
import XCTest

enum DateComponent: String {
    case second
    case minute
    case hour
    case day
    case year
    
    var durationInSeconds: Int {
        switch self {
            case .second:
                return 1
            case .minute:
                return 60 * DateComponent.second.durationInSeconds
            case .hour:
                return 60 * DateComponent.minute.durationInSeconds
            case .day:
                return 24 * DateComponent.hour.durationInSeconds
            case .year:
                return 365 * DateComponent.day.durationInSeconds
        }
    }
    
    static var allComponents: [DateComponent] {
        return [.second, .minute, .hour, .day, .year]
    }
}

func formatDuration(_ seconds: Int) -> String {
    guard seconds > 0 else {
        return "now"
    }
    
    var secondsToFormat = seconds
    
    let components = DateComponent.allComponents
        .reversed()
        .map { component -> (DateComponent, Int) in
            let count = secondsToFormat / component.durationInSeconds
            secondsToFormat = secondsToFormat - count * component.durationInSeconds
            return (component, count)
        }
        .filter { $0.1 > 0 }
        .map { item -> String in
            return "\(item.1) \(item.0.rawValue)" + (item.1 == 1 ? "" : "s")
        }
    
    return components
        .enumerated()
        .reduce("") { (output, item) -> String in
            var separator: String
            
            if item.offset == components.count - 1 {
                separator = ""
            } else if item.offset == components.count - 2 {
                separator = " and "
            } else {
                separator = ", "
            }
            
            return output + item.element + separator
        }
}

class SolutionTest: XCTestCase {
    
    func testBasic() {
        XCTAssertEqual(formatDuration(1), "1 second")
        XCTAssertEqual(formatDuration(62), "1 minute and 2 seconds")
        XCTAssertEqual(formatDuration(120), "2 minutes")
        XCTAssertEqual(formatDuration(3600), "1 hour")
        XCTAssertEqual(formatDuration(3662), "1 hour, 1 minute and 2 seconds")
    }
}

SolutionTest.defaultTestSuite.run()
