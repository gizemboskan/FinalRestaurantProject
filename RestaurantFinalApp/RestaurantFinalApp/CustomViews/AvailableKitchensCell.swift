//
//  AvailableKitchensCell.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 12.08.2021.
//

import UIKit

class AvailableKitchensCell: UITableViewCell, UINavigationControllerDelegate {
    
    
    @IBOutlet var availableKitchenNameLabel: UILabel!
    
    @IBOutlet var orderButton: UIButton!
    
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var deliveryTimeLabel: UILabel!
    @IBOutlet var offerLabel: UILabel!
    @IBOutlet var ratingCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
