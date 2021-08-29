//
//  SubHeaderTableViewCell.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 29.08.2021.
//

import UIKit

class SubHeaderTableViewCell: UITableViewCell, Setupable {
    
    @IBOutlet var shokoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ object: Any) {
        guard let object = object as? SubHeaderTableViewCellEntity else { return }
        shokoLabel.text = object.text
    }
    
}

struct SubHeaderTableViewCellEntity: CommonEntity {
    var identifier: String {
        return "SubHeaderTableViewCell"
    }
    let text: String
    var size: CGSize = CGSize(width: 0, height: 50)
}
