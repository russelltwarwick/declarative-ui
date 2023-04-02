//
//  FooterTitleView.swift
//  declarative-ui
//
//  Created by Russell Warwick on 31/03/2023.
//

import UIKit

final class FooterTitleView: UICollectionReusableView {
    
    // MARK: UI
    
    private var label = build(UILabel()) {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        VStack {
            label
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: ViewBinding

extension FooterTitleView: SupplementaryViewBinding {
    typealias Model = String
    func update(_ model: Model) {
        label.text = model
    }
}
