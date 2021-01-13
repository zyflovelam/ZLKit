//
//  Extensions.swift
//  ZLKit
//
//  Created by zyf on 2021/1/13.
//

import UIKit

extension UIImage {
    /// 图片大小重设
    ///
    /// - Parameter size: 重设的图片大小
    /// - Returns: 返回重设过后的图片
    func resizeImage(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizeImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if resizeImage == nil {
            return self
        }
        return resizeImage!
    }
}
