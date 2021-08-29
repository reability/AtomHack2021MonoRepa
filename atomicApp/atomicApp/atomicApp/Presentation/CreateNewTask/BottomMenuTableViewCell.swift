//
//  BottomMenuTableViewCell.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 29.08.2021.
//

import UIKit

class BottomMenuTableViewCell: UITableViewCell, Setupable {
    
    @IBOutlet var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ object: Any) {
        guard let model = object as? BottomMenuTableViewCellEntity else { return }
        labelName.text = model.text
    }
    
}

struct BottomMenuTableViewCellEntity: CommonEntity {
    var identifier: String {
        return "BottomMenuTableViewCell"
    }
    
    let text: String
    
    var size: CGSize = CGSize(width: 0, height: 50)
}


