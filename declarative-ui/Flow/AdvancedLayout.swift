//
//  AdvancedLayout.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 11/07/2022.
//

import UIKit

@available(iOS 13.0, *)
final class AdvancedLayout: NSCollectionLayoutSection, LayoutProvider {
    convenience init() {

        let inset = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        // Full
        let fullPhotoItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3)),
          supplementaryItems: [])
        fullPhotoItem.contentInsets = inset

        // Main with pair
        let mainItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalHeight(1.0)))
        mainItem.contentInsets = inset

        let pairItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)))
        pairItem.contentInsets = inset
        
        let trailingGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)),
          subitem: pairItem,
          count: 3)

        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(4/9)),
          subitems: [mainItem, trailingGroup])

        // Triplet
        let tripletItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)))
        tripletItem.contentInsets = inset

        let tripletGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/9)),
          subitems: [tripletItem, tripletItem, tripletItem])

        // Reversed main with pair
        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(4/9)),
          subitems: [trailingGroup, mainItem])

        let nestedGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(16/9)),
          subitems: [fullPhotoItem, mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])
        
        nestedGroup.contentInsets = .horizontal(5)
        
        self.init(group: nestedGroup)
    }
    
    func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection { self }
}
