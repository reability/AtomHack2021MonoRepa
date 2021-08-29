//
//  CarouselCollectionViewCell.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 29.08.2021.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var brbr: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension CarouselCollectionViewCell: Setupable {
    func setup(_ object: Any) {
        guard let object = object as? CarouselCollectionViewCellEntity else { return }
    }
    
}

struct CarouselCollectionViewCellEntity: CommonEntity {
    var identifier: String {
        return "CarouselCollectionViewCell"
    }
    
    var size: CGSize = CGSize(width: 261, height: 350)
}

