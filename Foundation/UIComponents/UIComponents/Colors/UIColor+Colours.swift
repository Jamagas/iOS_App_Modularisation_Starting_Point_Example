import UIKit

public extension UIColor {

    static var background: UIColor { color(hex: "#FDFEFE") }
    static var buttonPrimaryBackground: UIColor { color(hex: "#ABEBC6") }
    static var buttonSecondaryBackground: UIColor { color(hex: "#E5E8E8") }
    static var link: UIColor { color(hex: "#85C1E9") }
}

extension UIColor {
    
    private static func color(hex: String) -> UIColor {
        
        var hex = hex
        
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }
        
        guard hex.count == 6, let value = Int(hex, radix: 16) else { return .clear }
        let red = value >> 16 & 0xFF
        let green = value >> 8 & 0xFF
        let blue = value & 0xFF
        
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
