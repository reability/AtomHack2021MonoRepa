//
//  CommonServiceProtocol.swift
//  atomicApp
//
//  Created by Савченко Максим Олегович on 28.08.2021.
//

import Foundation
import UIKit

// MARK: - Common Entity for size and model

protocol CommonEntity {
    var identifier: String { get }
    var size: CGSize { get }
}

// MARK: - Send info from tableview to cells and taps

protocol Setupable: AnyObject {
    func setup(_ object: Any)
}

protocol Delegatable: AnyObject {
    var delegate: AnyObject? { get set }
}

protocol ViewState: AnyObject {
    func viewDidLoad()
}

extension ViewState {
    func viewDidLoad() {}
}

// MARK: - Extension UIView for corners

extension UIView {

    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
