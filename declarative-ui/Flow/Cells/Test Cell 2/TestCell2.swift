//
//  TestCell2.swift
//  declarative-ui
//
//  Created by Russell Warwick on 02/04/2023.
//

import UIKit

final class TestCell2: UICollectionViewCell {
    
    // MARK: - UI
    
    private let titleLabel = UILabel()
        .font(18, weight: .semibold)
        .textColor(.white)
    
    private let subtitleLabel = UILabel()
        .font(12, weight: .medium)
        .textColor(.white)

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .orange
        setConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    // MARK: -
    
    private func setConstraints() {
        contentView.VStack {
            titleLabel
            subtitleLabel
        }
        .padding([.all(5)])
        .spacing(5)
    }
}

extension TestCell2: CellBinding {
    typealias Model = TestCellViewModel2
    func update(_ model: Model, indexPath: IndexPath) {
        titleLabel.text = model.titleText
        subtitleLabel.text = model.subtitleText
    }
}
