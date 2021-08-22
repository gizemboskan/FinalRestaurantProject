//
//  String+Extensions.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 22.08.2021.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
