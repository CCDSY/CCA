import Foundation

extension Universe : CustomStringConvertible {
    
    public var description: String {
        var result = ""
        for column in grid {
            for cell in column {
                result += "\(cell)\t"
            }
            result += "\n"
        }
        return result
    }
    
}
