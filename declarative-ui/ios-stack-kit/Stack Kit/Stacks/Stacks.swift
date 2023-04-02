import UIKit

extension UIView {
    @discardableResult
    func ZStack(
        useSafeArea: Bool = true,
        @ResultBuilder<UIView> views: () -> [UIView]
    ) -> UIStackView {
        let container = UIView()

        views().forEach { view in
            container.VStack { view }
        }

        return VStack(useSafeArea: useSafeArea) { container }
    }

    @discardableResult
    func VStack(
        useSafeArea: Bool = true,
        @ResultBuilder<UIView> views: () -> [UIView]
    ) -> UIStackView {
        createStack(.vertical, views: views(), spacing: .zero, alignment: .fill, distribution: .fill, useSafeArea: useSafeArea)
    }

    @discardableResult
    func HStack(
        useSafeArea: Bool = true,
        @ResultBuilder<UIView> views: () -> [UIView]
    ) -> UIStackView {
        createStack(.horizontal, views: views(), spacing: .zero, alignment: .fill, distribution: .fill, useSafeArea: useSafeArea)
    }
}

// MARK: Class Variants

final class ZStackView: UIStackView {
    init(@ResultBuilder<UIView> views: () -> [UIView]) {
        super.init(frame: .zero)
        let container = UIView()

        views().forEach { view in container.VStack { view } }

        addArrangedSubview(container)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

final class VStackView: UIStackView {
    init(@ResultBuilder<UIView> views: () -> [UIView]) {
        super.init(frame: .zero)
        self.axis = .vertical
        addArrangedSubViews(views())
    }

    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

final class HStackView: UIStackView {
    init(@ResultBuilder<UIView> views: () -> [UIView]) {
        super.init(frame: .zero)
        self.axis = .horizontal
        addArrangedSubViews(views())
    }

    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
