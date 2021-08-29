//
//  SpaceTableViewCell.swift
//  AREldocode
//
//  Created by Савченко Максим Олегович on 22.06.2021.
//

import UIKit

final class SpaceTableViewCell: UITableViewCell, Setupable {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(_ object: Any) {}
}

struct SpaceEntity: CommonEntity {
    var identifier: String {
        return "SpaceTableViewCell"
    }
    
    var size: CGSize
}
