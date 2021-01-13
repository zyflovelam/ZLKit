//
//  UIImageView+Extensions.swift
//  ZLKit
//
//  Created by zyf on 2021/1/13.
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
