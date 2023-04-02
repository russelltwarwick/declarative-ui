//
//  TestCell.swift
//  declarative-ui
//
//  Created by Russell Warwick on 31/03/2023.
//

import UIKit

final class TestCell: UICollectionViewCell {
    
    // MARK: - UI
    
    private let titleLabel = UILabel()
        .alignment(.right)
        .font(16, weight: .semibold)
        .textColor(.red)
        .background(.cyan)
    
    private let imageView = UIImageView()
        .systemImage("moon")
        .background(.purple)
    
    private let button = ExpandedButton()
        .image("cloud.bolt.rain.fill")
        .text("This is a button")
        .background(.orange)
        .hitPadding(40)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setConstraints()
        style()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    // MARK: -
    
    private func style() {
        
    }
    
    private func setConstraints() {
        contentView.HStack {
            Spacer(width: 65)
            button
            Spacer(width: 65)
            Spacer()
            titleLabel
        }.alignment(.center)
        .padding([.all(5)])
    }
}

extension TestCell: CellBinding {
    typealias Model = TestCellViewModel
    func update(_ model: Model, indexPath: IndexPath) {
        titleLabel.text = model.titleText
    }
}

