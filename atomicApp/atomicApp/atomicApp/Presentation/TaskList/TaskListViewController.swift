//
//  TaskListViewController.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 28.08.2021.
//

import UIKit

final class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HeaderSideTableViewDelegate {
    
    var navigationView: NavigationView = NavigationView.fromNib()
    
    private lazy var tableView: UITableView = {
        
        let nib2 = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        let nib3 = UINib(nibName: "SubHeaderTableViewCell", bundle: nil)
        let nib4 = UINib(nibName: "BodyTableViewCell", bundle: nil)
        let nib5 = UINib(nibName: "SpaceTableViewCell", bundle: nil)
        
        $0.register(nib2, forCellReuseIdentifier: "HeaderTableViewCell")
        $0.register(nib3, forCellReuseIdentifier: "SubHeaderTableViewCell")
        $0.register(nib4, forCellReuseIdentifier: "BodyTableViewCell")
        $0.register(nib5, forCellReuseIdentifier: "SpaceTableViewCell")
        
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        $0.separatorStyle = .none
        
        return $0
    }(UITableView())
    
    private lazy var sideMenu: UITableView = {
        let nib2 = UINib(nibName: "SideMenuTableViewCell", bundle: nil)
        let nib3 = UINib(nibName: "HeaderSideTableViewCell", bundle: nil)
        
        $0.register(nib2, forCellReuseIdentifier: "SideMenuTableViewCell")
        $0.register(nib3, forCellReuseIdentifier: "HeaderSideTableViewCell")
        
        $0.delegate = self
        $0.dataSource = self
        
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    var widthConstraint: NSLayoutConstraint?
    
    var model: [CommonEntity] = []
    var sideModel: [CommonEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(navigationView)
        self.view.addSubview(tableView)
        self.view.addSubview(sideMenu)
        
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        sideMenu.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        
        navigationView.sideButton.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        navigationView.tapToAddNewCard.addTarget(self, action: #selector(goToNewCard), for: .touchUpInside)
        
        navigationView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        sideMenu.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sideMenu.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sideMenu.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        widthConstraint = sideMenu.widthAnchor.constraint(equalToConstant: 0)
        widthConstraint?.isActive = true
        
        let carouselModel: [CommonEntity] = [CarouselCollectionViewCellEntity(),
                                             CarouselCollectionViewCellEntity(),
                                             CarouselCollectionViewCellEntity(),
                                             CarouselCollectionViewCellEntity()]
        
        model.append(HeaderTableViewCellEntity())
        model.append(SubHeaderTableViewCellEntity(text: "Мои задачи"))
        model.append(BodyTableViewCellEntity(model: carouselModel))
        model.append(SubHeaderTableViewCellEntity(text: "Все задачи"))
        model.append(BodyTableViewCellEntity(model: carouselModel))
        
        sideModel.append(HeaderSideTableViewCellEntity())
        sideModel.append(SideMenuTableViewCellEntity())
    }

    @objc func showSideMenu() {
        widthConstraint?.constant = 600
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.sideMenu.layoutIfNeeded()
        }
        
    }
    
    @objc func goToNewCard() {
        let controller = NewTaskViewController(nibName: "NewTaskViewController", bundle: nil)
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func hideSideMenu() {
        widthConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.sideMenu.layoutIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sideMenu {
            return sideModel.count
        } else {
            return model.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == sideMenu {
            let row = sideModel[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
            
            (cell as? Setupable)?.setup(row)
            (cell as? Delegatable)?.delegate = self
            
            return cell
        } else {
            let row = model[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
            
            (cell as? Setupable)?.setup(row)
            (cell as? Delegatable)?.delegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == sideMenu {
            return sideModel[indexPath.row].size.height
        } else {
            return model[indexPath.row].size.height
        }
    }
    
    func tapCloseButton() {
        hideSideMenu()
    }
}


extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
