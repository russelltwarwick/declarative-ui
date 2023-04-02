import UIKit

enum PaddingEdges {
    case top(CGFloat)
    case bottom(CGFloat)
    case left(CGFloat)
    case right(CGFloat)
    case all(CGFloat)
    case vertical(CGFloat)
    case horizontal(CGFloat)
}

struct PaddingEdgesCalculator {
    let edges: [PaddingEdges]

    var edgeInset: UIEdgeInsets {
        var top: CGFloat = .zero
        var bottom: CGFloat = .zero
        var left: CGFloat = .zero
        var right: CGFloat = .zero

        edges.forEach { edge in
            switch edge {
            case let .top(value):
                top = value
            case let .bottom(value):
                bottom = value
            case let .left(value):
                left = value
            case let .right(value):
                right = value
            case let .all(value):
                top = value
                bottom = value
                left = value
                right = value
            case let .vertical(value):
                top = value
                bottom = value
            case let .horizontal(value):
                left = value
                right = value
            }
        }

        return .init(top: top, left: left, bottom: bottom, right: right)
    }
}

extension UIStackView {
    // MARK: Padding

    @discardableResult
    func padding(_ edges: [PaddingEdges]) -> Self {
        padding { edges }
        return self
    }

    @discardableResult
    func padding(
        @ResultBuilder<PaddingEdges> edges: () -> [PaddingEdges]) -> Self {
        layoutMargins = PaddingEdgesCalculator(edges: edges()).edgeInset
        isLayoutMarginsRelativeArrangement = true
        return self
    }
}

extension UIStackView {
    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }

    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

extension UIStackView {
    func addArrangedSubViews(_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
    }
}
