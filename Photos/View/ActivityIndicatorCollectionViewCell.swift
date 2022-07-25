//
//  ActivityIndicatorCollectionViewCell.swift
//  DemoPhotoApp
//

import UIKit

class ActivityIndicatorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        self.loader.style = .gray
        self.loader.tintColor = .red
    }

}
