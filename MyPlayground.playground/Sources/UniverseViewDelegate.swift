import UIKit

public protocol UniverseViewDelegate {
    
    associatedtype State
    
    var borderColor: CGColor { get }
    
    func color(for state: State) -> CGColor
    
}
