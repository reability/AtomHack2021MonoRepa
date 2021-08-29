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
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
