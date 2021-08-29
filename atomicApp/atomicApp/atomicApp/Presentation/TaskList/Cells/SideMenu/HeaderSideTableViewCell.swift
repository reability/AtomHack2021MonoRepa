//
//  HeaderSideTableViewCell.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 29.08.2021.
//

import UIKit

protocol HeaderSideTableViewDelegate: AnyObject {
    func tapCloseButton()
}

class HeaderSideTableViewCell: UITableViewCell {
    
    weak var delegate: AnyObject?
    
    @IBAction func tapToClose(_ sender: Any) {
        guard let delegate = delegate as? HeaderSideTableViewDelegate else { return }
        delegate.tapCloseButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

struct HeaderSideTableViewCellEntity: CommonEntity {
    var identifier: String {
        return "HeaderSideTableViewCell"
    }
    
    var size: CGSize = CGSize(width: 0, height: 60)
}


extension HeaderSideTableViewCell: Delegatable {
    
    
     
    
}
