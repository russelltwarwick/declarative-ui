import UIKit

// MARK: UIView Extension Variants

extension UIView {
    @discardableResult
    func VScroll(
        useSafeArea: Bool = true,
        padding: [PaddingEdges] = [],
        @ResultBuilder<UIView> views: () -> [UIView]
    ) -> ScrollViewBuilder {
        let scrollView = ScrollViewBuilder(axis: .vertical, views: views)
        VStack(useSafeArea: useSafeArea) { scrollView }.padding(padding)
        return scrollView
        // Note here. We can return the ScrollViewBuilder here because this is an extension of UIView.
        // Therefore the return type wont be added to the stack.
    }

    @discardableResult
    func HScroll(
        useSafeArea: Bool = true,
        padding: [PaddingEdges] = [],
        @ResultBuilder<UIView> views: () -> [UIView]
    ) -> ScrollViewBuilder {
        let scrollView = ScrollViewBuilder(axis: .horizontal, views: views)
        VStack(useSafeArea: useSafeArea) { scrollView }.padding(padding)
        return scrollView
        // Note here. We can return the ScrollViewBuilder here because this is an extension of UIView.
        // Therefore the return type wont be added to the stack.
    }
}

// MARK: Class Variants

final class HScrollView: ScrollViewBuilder {
    init(@ResultBuilder<UIView> views: () -> [UIView]) {
        super.init(axis: .horizontal, views: views)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

final class VScrollView: ScrollViewBuilder {
    init(@ResultBuilder<UIView> views: () -> [UIView]) {
        super.init(axis: .vertical, views: views)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
