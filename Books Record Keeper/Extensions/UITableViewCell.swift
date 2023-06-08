//
//  UITableViewCell.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 08/06/2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var nibName: String {
        return String(describing: self)
    }
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
