//
//  MasterViewController.swift
//  atomicApp
//
//  Created by Ванурин Алексей Максимович on 28.08.2021.
//

import Foundation
import SwiftUI
import UIKit

final class MasterViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigateToList()
    }

    private func navigateToList() {
        let view = TaskListView()
        self.present(UIHostingController(rootView: view), animated: false, completion: nil)
    }
    
    
}
