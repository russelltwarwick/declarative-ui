import UIKit

final class Spacer: UIView {
    static func auto() -> Spacer {
        let s = Spacer()
        s.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        s.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        s.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        s.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        return s
    }

    // MARK: Init

    init() {
        super.init(frame: .zero)
    }

    init(width: CGFloat) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    init(height: CGFloat) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    init(square: CGFloat) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: square).isActive = true
        heightAnchor.constraint(equalToConstant: square).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
 
}

extension Spacer {
    @discardableResult
    func color(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func interactionEnabled(_ value: Bool) -> Self {
        isUserInteractionEnabled = value
        return self
    }
}
