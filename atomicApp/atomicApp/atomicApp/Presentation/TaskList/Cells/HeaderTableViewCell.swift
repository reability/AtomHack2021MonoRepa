//
//  HeaderTableViewCell.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 29.08.2021.
//

import UIKit

final class HeaderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

struct HeaderTableViewCellEntity: CommonEntity {
    var identifier: String {
        return "HeaderTableViewCell"
    }
    
    var size: CGSize = CGSize(width: 0, height: 120)
}
