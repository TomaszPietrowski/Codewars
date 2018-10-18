//Solved thanks to the tutorial: "Swift Algorithm Club: Heap and Priority Queue Data Structure" by Ray Wenderlich

import XCTest

struct Heap<T> {
    
    private var nodes = [T]()
    private let priorityFunction: (T, T) -> Bool
    
    init(priorityFunction: @escaping (T, T) -> Bool) {
        self.priorityFunction = priorityFunction
    }
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    var count: Int {
        return nodes.count
    }
    
    var peek: T? {
        return nodes.first
    }
    
    func isRoot(index: Int) -> Bool {
        return index == 0
    }
    
    func leftChildIndex(of parentIndex: Int) -> Int? {
        let leftChildIndex = 2 * parentIndex + 1
        return leftChildIndex < count ? leftChildIndex : nil
    }
    
    func rightChildIndex(of parentIndex: Int) -> Int? {
        let rightChildIndex = 2 * parentIndex + 2
        return rightChildIndex < count ? rightChildIndex : nil
    }
    
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return priorityFunction(nodes[firstIndex], nodes[secondIndex])
    }
    
    func getHighestPriorityIndex(of firstIndex: Int, and secondIndex: Int) -> Int {
        return isHigherPriority(at: firstIndex, than: secondIndex)
            ? firstIndex
            : secondIndex
    }
    
    func getHighestPriorityIndex(for parentIndex: Int) -> Int {
        guard let leftChildIndex = leftChildIndex(of: parentIndex) else {
            return parentIndex
        }
        
        guard let righChildIndex = rightChildIndex(of: parentIndex) else {
            return getHighestPriorityIndex(of: parentIndex, and: leftChildIndex)
        }
        
        return getHighestPriorityIndex(
            of: getHighestPriorityIndex(of: parentIndex, and: leftChildIndex),
            and: righChildIndex
        )
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex else {
            return
        }
        return nodes.swapAt(firstIndex, secondIndex)
    }
    
    mutating func enqueue(_ element: T) {
        nodes.append(element)
        siftUpElement(at: count - 1)
    }
    
    mutating func siftUpElement(at index: Int) {
        let parentIndex = self.parentIndex(of: index)
        guard
            !isRoot(index: index),
            isHigherPriority(at: index, than: parentIndex)
        else {
            return
        }
        
        swapElement(at: parentIndex, with: index)
        siftUpElement(at: parentIndex)
    }
    
    mutating func dequeue() -> T? {
        guard !isEmpty else {
            return nil
        }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let elementToRemove = peek
            swapElement(at: 0, with: count - 1)
            nodes.removeLast()
            siftDownElement(at: 0)
            return elementToRemove
        }
    }
    
    mutating func siftDownElement(at index: Int) {
        let highestPriorityIndex = getHighestPriorityIndex(for: index)
        guard index != highestPriorityIndex else {
            return
        }
        swapElement(at: index, with: highestPriorityIndex)
        siftDownElement(at: highestPriorityIndex)
    }
}


func dblLinear(_ n: Int) -> Int {
    var heap: Heap<Int> = Heap(priorityFunction: <)
    heap.enqueue(1)
    
    for _ in 0..<n {
        guard let currentValue = heap.peek else {
            break
        }
        
        while !heap.isEmpty && heap.peek == currentValue {
            heap.dequeue()
        }
        
        heap.enqueue(2 * currentValue + 1)
        heap.enqueue(3 * currentValue + 1)
    }
    
    return heap.peek ?? 0
}

class SolutionTest: XCTestCase {
    
    func testing(_ n: Int, _ expected: Int) {
        XCTAssertEqual(dblLinear(n), expected)
    }
    
    func testExample() {
        testing(10, 22)
        testing(20, 57)
        testing(30, 91)
        testing(50, 175)
        testing(100, 447)
    }
}

SolutionTest.defaultTestSuite.run()
