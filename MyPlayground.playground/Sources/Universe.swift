import Foundation

public struct Universe {
    
    public typealias State = Int
    public typealias Snapshot = [[State]]
    private typealias Coordinate = (x: Int, y: Int)
    
    public private(set) var grid: Snapshot
    public private(set) var history: [Snapshot]
    
    private subscript(coordinate: Coordinate) -> State {
        return grid[coordinate.x][coordinate.y]
    }
    
    private let maxStateValue: State
    private let threshold: Int
    private let neighborDistance: Int
    
    public init(maxStateValue: State, threshold: Int, neighborDistance: Int, initialValues: [[State]]) {
        self.maxStateValue = maxStateValue
        self.threshold = threshold
        self.neighborDistance = neighborDistance
        
        self.grid = initialValues
        self.history = []
    }
    
    public mutating func iterate() {
        var newIteration = grid
        
        for x in 0 ..< grid.count {
            for y in 0 ..< grid[x].count {
                newIteration[x][y] = newStateForCell(at: (x, y))
            }
        }
        
        history.append(grid)
        grid = newIteration
    }
    
    private func newStateForCell(at coordinate: Coordinate) -> Int {
        if succeedingNeighborCountForCell(at: coordinate) > threshold {
            return successor(for: self[coordinate])
        } else {
            return self[coordinate]
        }
    }
    
    private func succeedingNeighborCountForCell(at coordinate: Coordinate) -> Int {
        let successorOfCell = successor(for: self[coordinate])
        return neighboringIndicesForCell(at: coordinate).filter { self[$0] == successorOfCell }.count
    }
    
    private func neighboringIndicesForCell(at coordinate: Coordinate) -> [Coordinate] {
        func offset(_ coordinate: Coordinate, byDx dx: Int, dy: Int) -> Coordinate? {
            let result = (x: coordinate.x + dx, y: coordinate.y + dy)
            guard result.y >= 0 else { return nil }
            guard result.y < grid.first?.count ?? 0 else { return nil }
            guard result.x >= 0 else { return nil }
            guard result.x < grid.count else { return nil }
            return result
        }
        
        return (-neighborDistance ... neighborDistance).flatMap { dx -> [Coordinate] in
            (-neighborDistance ... neighborDistance).flatMap { dy -> Coordinate? in
                guard dx != 0 || dy != 0 else { return nil }
                return offset(coordinate, byDx: dx, dy: dy)
            }
        }
    }
    
    private func successor(for state: State) -> State {
        return (state + 1) % maxStateValue
    }
    
}
