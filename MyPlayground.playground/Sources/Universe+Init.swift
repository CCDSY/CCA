import Foundation

public extension Universe {
    
    public init(maxStateValue: State, threshold: Int, neighborDistance: Int, width: Int, height: Int) {
        let initialValues = (0 ..< width).map { _ in (0 ..< height).map { _ in Int(arc4random_uniform(UInt32(maxStateValue))) } }
        
        self.init(maxStateValue: maxStateValue, threshold: threshold, neighborDistance: neighborDistance, initialValues: initialValues)
    }
    
}
