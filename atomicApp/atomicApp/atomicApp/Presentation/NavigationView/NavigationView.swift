//
//  NavigationView.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 28.08.2021.
//

import UIKit

enum NavigationViewStates {
    case taskList
    case detailTask
}

protocol NavigationViewProtocolable: AnyObject {
    func showNavigationView(with: NavigationViewStates)
}

extension NavigationViewProtocolable where Self: UIViewController {
    
    func showNavigationView(with: NavigationViewStates) {
        
    }
    
}

final class NavigationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        Bundle.main.loadNibNamed("NavigationView", owner: self, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        Bundle.main.loadNibNamed("NavigationView", owner: self, options: nil)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
