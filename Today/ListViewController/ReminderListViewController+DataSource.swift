//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by Anurag Tyagi on 16/06/24.
//

import UIKit

extension ReminderListViewController{
    typealias DataSource = UICollectionViewDiffableDataSource<Int,String>
    typealias DataSnapshot = NSDiffableDataSourceSnapshot<Int,String>
    
    func handleCellRegistration(cell: UICollectionViewListCell, indexPath: IndexPath, id: String){
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont
            .preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessories = [.customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]
        
        var backgroundConfiguration = cell.defaultBackgroundConfiguration()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(
            textStyle: .title1
        )
        let image = UIImage(
            systemName: symbolName,
            withConfiguration: symbolConfiguration
        )
        
        let button = UIButton()
        button.setImage(image, for: .normal)
        
        return UICellAccessory
            .CustomViewConfiguration(
                customView: button,
                placement: .leading(displayed: .always)
            )
    }
    
}
