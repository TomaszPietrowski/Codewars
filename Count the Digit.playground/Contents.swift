
import Foundation

func nbDig(_ n: Int, _ d: Int) -> Int {
    return (0...n)
        .map { number -> Int in
            let dCount = String(number * number).components(separatedBy: String(d)).count - 1
            return dCount < 0 ? 0 : dCount
        }
        .reduce(0, +)
}

let result = nbDig(25, 1)
