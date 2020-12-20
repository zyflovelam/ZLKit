//
//  UIImageView+Extension.swift
//  ZLKit
//
//  Created by zyf on 2020/12/16.
//

import UIKit

extension UIImageView {
    convenience public init(_ named: String) {
        self.init()
        if let image = UIImage(named: named) {
            self.image = image
        }
    }
}
