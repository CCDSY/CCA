import Cocoa

public struct MyDelegate : UniverseViewDelegate {
    
    private static let colorList = [NSColor.blue, NSColor.brown, NSColor.cyan, NSColor.gray, NSColor.green, NSColor.red, NSColor.magenta, NSColor.orange]
    
    public var borderColor: CGColor { return CGColor.white }
    
    public func color(for state: Int) -> CGColor {
        assert(state <= MyDelegate.colorList.count, "Inconsistent max state")
        return MyDelegate.colorList[state].cgColor
    }
    
    public init() {
    }
    
}
