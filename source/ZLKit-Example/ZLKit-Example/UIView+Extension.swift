//
//  UIView+Extension.swift
//  ZLKit-Example
//
//  Created by zyf on 2020/12/16.
//

import SnapKit
import UIKit

extension UIView {
    @discardableResult public func constraint(_ closure: (ConstraintMaker) -> Void) -> Self {
        snp.makeConstraints(closure)
        return self
    }
}
