//
//  SideMenuTableViewCell.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 29.08.2021.
//

import UIKit

final class SideMenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

struct SideMenuTableViewCellEntity: CommonEntity {
    var identifier: String {
        return "SideMenuTableViewCell"
    }
    
    var size: CGSize = CGSize(width: 0, height: 1440)
}
