//
//  HomeTableViewCell.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 08/06/2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteImageView: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cellBody: UIView!
    
    weak var delegate: HomeTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBody.layer.cornerRadius = 20
        
        let deleteTapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteCell(_:)))
        deleteImageView.isUserInteractionEnabled = true
        deleteImageView.addGestureRecognizer(deleteTapGesture)
    }
    
    @objc func deleteCell(_ gesture: UITapGestureRecognizer) {
        delegate?.deleteButtonTapped(forCell: self)
        print("button tapped")
    }
}
