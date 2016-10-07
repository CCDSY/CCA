import UIKit

public struct MyDelegate : UniverseViewDelegate {
    
    private static let colorList = [UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.gray, UIColor.green, UIColor.red, UIColor.magenta, UIColor.orange]
    
    public var borderColor: CGColor { return UIColor.white.cgColor }
    
    public func color(for state: Int) -> CGColor {
        assert(state <= MyDelegate.colorList.count, "Inconsistent max state")
        return MyDelegate.colorList[state].cgColor
    }
    
    public init() {
    }
    
}
