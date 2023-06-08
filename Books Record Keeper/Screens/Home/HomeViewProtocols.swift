//
//  HomeViewProtocols.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 08/06/2023.
//

import Foundation

protocol HomeTableViewCellDelegate: AnyObject {
    func deleteButtonTapped(forCell cell: HomeTableViewCell)
}

