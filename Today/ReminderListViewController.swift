//
//  ViewController.swift
//  Today
//
//  Created by Anurag Tyagi on 11/06/24.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int,String>
    typealias DataSnapshot = NSDiffableDataSourceSnapshot<Int,String>
    
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var list = listLayout()
        collectionView.collectionViewLayout = list
        
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = DataSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map({$0.title}))
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list( using: listConfiguration)
    }
}

