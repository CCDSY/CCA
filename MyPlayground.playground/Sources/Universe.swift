import Foundation

public struct Universe {
    
    public typealias State = Int
    public typealias Snapshot = [[State]]
    private typealias Coordinate = (x: Int, y: Int)
    
    public var grid: Snapshot
    public private(set) var history: [Snapshot]
    
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
                
            }
        }
    }
    
    private func succeedingNeighborForCell(at coordinate: Coordinate) {
        neighboringIndicesForCell(at: coordinate).map(successor)
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
