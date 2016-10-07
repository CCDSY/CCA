import UIKit
import CoreGraphics

public class UniverseView<DelegateType : UniverseViewDelegate> : UIView where DelegateType.State == Universe.State {
    
    public var universe: Universe? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var delegate: DelegateType?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        isOpaque = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        isOpaque = true
    }
    
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setFillColor((backgroundColor ?? UIColor.white).cgColor)
        context.fill(rect)
        
        actuallyDraw(bounds.insetBy(dx: 10, dy: 10), in: context)
    }
    
    private func actuallyDraw(_ rect: CGRect, in context: CGContext) {
        let borderOffset = borderWidth / 2
        
        context.setStrokeColor(delegate?.borderColor ?? UIColor.white.cgColor)
        context.stroke(rect.insetBy(dx: -borderOffset, dy: -borderOffset), width: borderWidth)
        
        guard let grid = self.universe?.grid else { return }
        
        let cellWidth = (rect.width - borderWidth * CGFloat(grid.count - 1)) / CGFloat(grid.count)
        let cellHeight = (rect.height - borderWidth * CGFloat(grid[0].count - 1)) / CGFloat(grid[0].count)
        
        for i in 1 ..< grid.count {
            let x = cellWidth * CGFloat(i) + borderWidth * CGFloat(i - 1) + borderOffset + rect.minX
            context.addLines(between: [CGPoint(x: x, y: rect.minY), CGPoint(x: x, y: rect.maxY)])
        }
        
        for i in 1 ..< grid[0].count {
            let y = cellHeight * CGFloat(i) + borderWidth * CGFloat(i - 1) + borderOffset + rect.minY
            context.addLines(between: [CGPoint(x: rect.minX, y: y), CGPoint(x: rect.maxX, y: y)])
        }
        
        context.setLineWidth(borderWidth)
        context.drawPath(using: .stroke)
        
        for x in 0 ..< grid.count {
            for y in 0 ..< grid[0].count {
                let color = delegate?.color(for: grid[x][y]) ?? UIColor.black.cgColor
                
                let x = cellWidth * CGFloat(x) + borderWidth * CGFloat(x - 1) + borderOffset + rect.minX
                let y = cellHeight * CGFloat(y) + borderWidth * CGFloat(y - 1) + borderOffset + rect.minY
                
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
            self.setNeedsDisplay()
        }
    }
    
    public func stopUpdate() {
        timer?.invalidate()
        timer = nil
    }
    
}
