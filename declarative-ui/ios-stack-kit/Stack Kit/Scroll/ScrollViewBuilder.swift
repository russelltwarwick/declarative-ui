import UIKit

class ScrollViewBuilder: UIView {
    // MARK: UI

    private let scrollView = build(UIScrollView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }

    private let stackView = build(UIStackView()) {
        $0.alignment = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Init

    init(
        axis: NSLayoutConstraint.Axis,
        @ResultBuilder<UIView> views: () -> [UIView]
    ) {
        super.init(frame: .zero)
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        if axis == .vertical {
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        } else {
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .center
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        }

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        ])

        stackView.addArrangedSubViews(views())
    }

    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: Scroll Extensions

extension ScrollViewBuilder {
    @discardableResult
    func spacing(_ spacing: CGFloat) -> Self {
        stackView.spacing = spacing
        return self
    }

    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> Self {
        stackView.alignment = alignment
        return self
    }

    @discardableResult
    func showsIndicator(_ value: Bool) -> Self {
        scrollView.showsVerticalScrollIndicator = value
        scrollView.showsHorizontalScrollIndicator = value
        return self
    }

    @discardableResult
    func alwaysBounceHorizontal(_ value: Bool) -> Self {
        scrollView.alwaysBounceHorizontal = value
        return self
    }

    @discardableResult
    func alwaysBounceVertical(_ value: Bool) -> Self {
        scrollView.alwaysBounceVertical = value
        return self
    }

    @discardableResult
    func scrollDelegate(_ delegate: UIScrollViewDelegate) -> Self {
        scrollView.delegate = delegate
        return self
    }

    // MARK: Padding

    @discardableResult
    func scrollMargin(_ edges: [PaddingEdges]) -> Self {
        stackView.padding(edges)
        return self
    }

    @discardableResult
    func scrollMargin(
        @ResultBuilder<PaddingEdges> edges: () -> [PaddingEdges]) -> Self {
        stackView.padding(edges: edges)
        return self
    }
}
