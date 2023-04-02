//
//  ViewController.swift
//  declarative-ui
//
//  Created by Russell Warwick on 31/03/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: UI
    
    private let collectionView = DeclarativeCollectionView()
    
    // MARK: Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setConstraints()
        buildCollectionView()
    }
    
    private func setConstraints() {
        view.VStack(useSafeArea: false) {
            collectionView
                
        }
    }
    
    private func buildCollectionView() {
        collectionView.updateSnapshot {
            
            Section(id: "test",
                    header: Header<TitleHeaderView>.init(data: "Header", height: .absolute(100)),
                    footer: Footer<FooterTitleView>.init(data: "Footer", height: .absolute(100)),
                    layout: .list(height: .absolute(120)),
                    items: {
                
                Cell<TestCell>(data: .init(title: "1"))
                Cell<TestCell2>(data: .init(title: "Title 1", subtitle: "Lorem nins bjfgiu jhdfbuf"))
                Cell<TestCell>(data: .init(title: "1"))
                Cell<TestCell2>(data: .init(title: "Title 2", subtitle: "Lorem nins bjfgiu jhdfbuf"))
            })
            
            Section(id: "test2",
                    header: Header<TitleHeaderView>.init(data: "Header", height: .absolute(100)),
                    footer: Footer<FooterTitleView>.init(data: "Footer", height: .absolute(100)),
                    layout: .list(height: .estimated(50)),
                    items: {
                
                Cell<TestCell>(data: .init(title: "1"))
                Cell<TestCell2>(data: .init(title: "Title 1", subtitle: "Lorem nins bjfgiu jhdfbuf"))
                Cell<TestCell>(data: .init(title: "1"))
                Cell<TestCell2>(data: .init(title: "Title 2", subtitle: "Lorem nins bjfgiu jhdfbuf"))
            })
            
            Section(id: "test3",
                    header: Header<TitleHeaderView>.init(data: "Header", height: .absolute(100)),
                    footer: Footer<FooterTitleView>.init(data: "Footer", height: .absolute(100)),
                    layout: .custom(AdvancedLayout()),
                    items: {
                
                (0...20).map { (id: Int) in
                    Cell<TestCell2>(data: .init(title: "Title \(id)", subtitle: "Lorem nins bjfgiu jhdfbuf"))
                }
            })
        }
    }
}
