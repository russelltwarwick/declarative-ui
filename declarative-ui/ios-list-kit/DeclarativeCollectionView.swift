//
//  ListViewController.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 13/06/2022.
//

import UIKit

@available(iOS 13.0, *)
final class DeclarativeCollectionView: UICollectionView {
    
    // MARK: Callbacks
    
    public var didScroll: ((CGFloat) -> Void)?
    public var willDisplayItemAtIndex: ((IndexPath) -> Void)?
    
    // MARK: UI

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private lazy var genericDataSource = makeDataSource()
    
    private func makeDataSource() -> DataSource {
        DataSource(collectionView: self) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else { return UICollectionViewCell() }
            return self.sections[indexPath.section].items[indexPath.row]
                .cell(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    // MARK: Properties
    
    private var sections: [Section] = []
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        delegate = self
        configureLayout()
        alwaysBounceVertical = true
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configureLayout() {
        collectionViewLayout = UICollectionViewCompositionalLayout { [unowned self] section, environment in
            let section = self.genericDataSource.snapshot().sectionIdentifiers[section]
            let layoutSection = section.layoutType.provider.layout(environment: environment)

            layoutSection.boundarySupplementaryItems = section.boundarySupplementaryItems

            layoutSection.decorationItems = [
                section.background?.decoration(layout: self.collectionViewLayout)
            ].compactMap({ $0 })

            // Pager config

            layoutSection.visibleItemsInvalidationHandler = { [weak self] items, offset, env in
                guard let self else { return }
                let page = Int(round(offset.x / self.bounds.width))
                section.setPage(page)
            }

            return layoutSection
        }
        
        genericDataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            let section = self.genericDataSource.snapshot().sectionIdentifiers[indexPath.section]
            if kind == UICollectionView.elementKindSectionHeader {
                return section.header?.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
            } else {
                return section.footer?.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
            }
        }
    }
         
    // MARK: Update
    
    func updateSnapshot(@ResultBuilder<Section> newSections: () -> [Section]) {
        sections = newSections()
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems($0.items, toSection: $0) }
        genericDataSource.apply(snapshot, animatingDifferences: true)
    }
}

@available(iOS 13.0, *)
extension DeclarativeCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sections[indexPath.section].items[indexPath.row].didSelect(indexPath: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView.contentOffset.y)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplayItemAtIndex?(indexPath)
    }
}

