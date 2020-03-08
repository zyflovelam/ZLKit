//
//  UIImage+Extensions.swift
//  ZLKit
//
//  Created by zyf on 2020/3/4.
//  Copyright © 2020 zyf. All rights reserved.
//

import UIKit


extension UIImage {
    /// 图片大小重设
    ///
    /// - Parameter size: 重设的图片大小
    /// - Returns: 返回重设过后的图片
    func resizeImage(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let resizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return resizeImage
        } else {
            return self
        }
    }
}
