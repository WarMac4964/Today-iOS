//
//  ViewController.swift
//  Today
//
//  Created by Anurag Tyagi on 11/06/24.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list = listLayout()
        collectionView.collectionViewLayout = list
        
        let cellRegistration = UICollectionView.CellRegistration(handler: handleCellRegistration)
        
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

