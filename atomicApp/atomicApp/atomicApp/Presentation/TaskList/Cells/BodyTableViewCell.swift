//
//  BodyTableViewCell.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 29.08.2021.
//

import UIKit

final class BodyTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    
    var model: [CommonEntity] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "CarouselCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = model[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.identifier, for: indexPath)
        
        (cell as? Setupable)?.setup(row)
        (cell as? Delegatable)?.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 261, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}

struct BodyTableViewCellEntity: CommonEntity {
    var identifier: String {
        return "BodyTableViewCell"
    }
    
    let model: [CommonEntity]
    
    var size: CGSize = CGSize(width: 0, height: 350)
}


extension BodyTableViewCell: Setupable {
    
    func setup(_ object: Any) {
        guard let model = object as? BodyTableViewCellEntity else { return }
        self.model = model.model
        collectionView.reloadData()
    }
    
}
