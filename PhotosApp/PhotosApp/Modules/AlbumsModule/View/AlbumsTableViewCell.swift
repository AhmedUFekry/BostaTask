//
//  AlbumsTableViewCell.swift
//  PhotosApp
//
//  Created by Ahmed Fekry on 09/09/2023.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    @IBOutlet weak var albumNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
