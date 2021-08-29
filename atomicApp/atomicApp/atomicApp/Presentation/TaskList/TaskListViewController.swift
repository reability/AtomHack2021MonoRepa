//
//  TaskListViewController.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 28.08.2021.
//

import UIKit

final class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var navigationView: NavigationView = NavigationView.fromNib()
    
    private lazy var tableView: UITableView = {
        
        let nib2 = UINib(nibName: "SpaceTableViewCell", bundle: nil)
        let nib3 = UINib(nibName: "GoodInfoCell", bundle: nil)
        let nib4 = UINib(nibName: "PopUpTitleCell", bundle: nil)
        let nib5 = UINib(nibName: "InfoDetailCell", bundle: nil)
        let nib6 = UINib(nibName: "BuyButtonCell", bundle: nil)
        
        $0.register(nib2, forCellReuseIdentifier: "SpaceTableViewCell")
        $0.register(nib3, forCellReuseIdentifier: "GoodInfoCell")
        $0.register(nib4, forCellReuseIdentifier: "PopUpTitleCell")
        $0.register(nib5, forCellReuseIdentifier: "InfoDetailCell")
        $0.register(nib6, forCellReuseIdentifier: "BuyButtonCell")
        
        $0.delegate = self
        $0.dataSource = self
        
        $0.separatorStyle = .none
        
        return $0
    }(UITableView())
    
    var model: [CommonEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(navigationView)
        self.view.addSubview(tableView)
        
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
    

}


extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
