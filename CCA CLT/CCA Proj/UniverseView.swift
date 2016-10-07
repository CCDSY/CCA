import Cocoa
import CoreGraphics

public class UniverseView<DelegateType : UniverseViewDelegate> : NSView where DelegateType.State == Universe.State {
    
    public var universe: Universe? {
        didSet {
            needsDisplay = true
        }
    }
    
    public var delegate: DelegateType? {
        didSet {
            needsDisplay = true
        }
    }
    
    public override var isOpaque: Bool { return true }
    
    public override func draw(_ rect: CGRect) {
        guard let context = NSGraphicsContext.current()?.cgContext else { return }
        
        context.setFillColor(CGColor.white)
        context.fill(rect)
        
        actuallyDraw(bounds.insetBy(dx: 10, dy: 10), in: context)
    }
    
    private func actuallyDraw(_ rect: CGRect, in context: CGContext) {
        guard let grid = self.universe?.grid else { return }
        
        let cellWidth = rect.width / CGFloat(grid.count)
        let cellHeight = rect.height / CGFloat(grid[0].count)
        
        for x in 0 ..< grid.count {
            for y in 0 ..< grid[0].count {
                let color = delegate?.color(for: grid[x][y]) ?? CGColor.black
                
                let x = cellWidth * CGFloat(x) + rect.minX
                let y = cellHeight * CGFloat(y) + rect.minY
                
                context.setFillColor(color)
                context.fill(CGRect(x: x, y: y, width: cellWidth, height: cellHeight))
            }
        }
    }
    
    public func iterate() {
        universe?.iterate()
    }
    
    private var timer: Timer?
    
    public func startUpdate(interval: TimeInterval) {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [unowned self] _ in
            self.iterate()
            self.needsDisplay = true
        }
    }
    
    public func stopUpdate() {
        timer?.invalidate()
        timer = nil
    }
    
}
