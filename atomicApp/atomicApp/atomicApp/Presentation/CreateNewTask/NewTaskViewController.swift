//
//  NewTaskViewController.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 29.08.2021.
//

import UIKit

class NewTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var sideMenu: UITableView = {
        let nib2 = UINib(nibName: "BottomMenuTableViewCell", bundle: nil)
        
        $0.register(nib2, forCellReuseIdentifier: "BottomMenuTableViewCell")
        
        $0.delegate = self
        $0.dataSource = self
        
        return $0
    }(UITableView())
    
    var widthConstraint: NSLayoutConstraint?
    
    @IBOutlet var textFlow: UITextField!
    @IBOutlet var controlTap: UIControl!
    var isEnabledCOntrol: Bool = false
    
    var model: [CommonEntity] = []
    
    @IBAction func tapToCloseModule(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlTap.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        
        self.view.addSubview(sideMenu)
        sideMenu.translatesAutoresizingMaskIntoConstraints = false
        
        sideMenu.topAnchor.constraint(equalTo: self.controlTap.bottomAnchor).isActive = true
        sideMenu.trailingAnchor.constraint(equalTo: self.controlTap.trailingAnchor).isActive = true
        sideMenu.leadingAnchor.constraint(equalTo: self.controlTap.leadingAnchor).isActive = true
        
        widthConstraint = sideMenu.heightAnchor.constraint(equalToConstant: 0)
        widthConstraint?.isActive = true
        
        model.append(BottomMenuTableViewCellEntity(text: "Строительный"))
        model.append(BottomMenuTableViewCellEntity(text: "Молодежный"))
        model.append(BottomMenuTableViewCellEntity(text: "Медицинский"))
    }

@objc func showSideMenu() {
    if isEnabledCOntrol == false {
        widthConstraint?.constant = 150
        isEnabledCOntrol = true
    } else {
        widthConstraint?.constant = 0
        isEnabledCOntrol = false
    }

    UIView.animate(withDuration: 0.3) {
        self.view.layoutIfNeeded()
        self.sideMenu.layoutIfNeeded()
    }
    
}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let row = model[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
            
            (cell as? Setupable)?.setup(row)
            (cell as? Delegatable)?.delegate = self
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = model[indexPath.row] as? BottomMenuTableViewCellEntity
        textFlow.text = text?.text
        isEnabledCOntrol = true
        showSideMenu()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return model[indexPath.row].size.height
        
    }
    

}
