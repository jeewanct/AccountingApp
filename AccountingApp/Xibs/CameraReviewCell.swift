//
//  CameraReviewCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class CameraReviewCell: UICollectionViewCell{
    
    @IBOutlet weak var image: UIImageView!
    var imageUrl: URL?{
        didSet{
            if let unwrappedUrl = imageUrl{
                image.image = UIImage(contentsOfFile: unwrappedUrl.path)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
