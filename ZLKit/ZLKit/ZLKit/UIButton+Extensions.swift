//
//  UIButton+Extensions.swift
//  ZLKit
//
//  Created by zyf on 2020/3/4.
//  Copyright © 2020 zyf. All rights reserved.
//

import UIKit

extension UIButton {
    @discardableResult
    public func title(_ title: String) -> UIButton {
        setTitle(title, for: .normal)
        setTitle(title, for: .disabled)
        setTitle(title, for: .highlighted)
        setTitle(title, for: .selected)
        return self
    }

    @discardableResult
    public func title(_ title: String, for state: UIControl.State) -> UIButton {
        setTitle(title, for: state)
        return self
    }

    @discardableResult
    public func titleFont(_ font: UIFont) -> UIButton {
        titleLabel?.font = font
        return self
    }

    @discardableResult
    public func titleColor(_ color: UIColor) -> UIButton {
        setTitleColor(color, for: .normal)
        setTitleColor(color, for: .disabled)
        setTitleColor(color, for: .highlighted)
        setTitleColor(color, for: .selected)
        return self
    }

    @discardableResult
    public func titleColor(_ color: UIColor, for state: UIControl.State) -> UIButton {
        setTitleColor(color, for: state)
        return self
    }

    @discardableResult
    public func image(_ name: String, size: CGSize = .zero) -> UIButton {
        var image = UIImage(named: name)
        if size != .zero {
            image = image?.resizeImage(size)
        }
        setImage(image, for: .normal)
        setImage(image, for: .disabled)
        setImage(image, for: .highlighted)
        setImage(image, for: .selected)
        return self
    }

    @discardableResult
    public func image(_ name: String, size: CGSize = .zero, for state: UIControl.State) -> UIButton {
        var image = UIImage(named: name)
        if size != .zero {
            image = image?.resizeImage(size)
        }
        setImage(image, for: state)
        return self
    }

    @discardableResult
    public func image(_ image: UIImage) -> UIButton {
        setImage(image, for: .normal)
        setImage(image, for: .disabled)
        setImage(image, for: .highlighted)
        setImage(image, for: .selected)
        return self
    }

    @discardableResult
    public func image(_ image: UIImage, for state: UIControl.State) -> UIButton {
        setImage(image, for: state)
        return self
    }
    
    
    
}

extension UIButton {
    @discardableResult
    public override func frame(_ frame: CGRect) -> Self {
        super.frame(frame)
        return self
    }
    
    @discardableResult
    public override func cornerRadius(_ corderRadius: CGFloat) -> Self {
        super.cornerRadius(corderRadius)
        return self
    }
    
    @discardableResult
    public override func maskCorner(_ maskCorners: CACornerMask) -> Self {
        super.maskCorner(maskCorners)
        return self
    }
    
    @discardableResult
    public override func border(width: CGFloat = 1, color: UIColor = .black) -> Self {
        super.border(width: width, color: color)
        return self
    }
    
    @discardableResult
    public override func background(_ color: UIColor) -> Self {
        super.background(color)
        return self
    }
    
    @discardableResult
    public override func shadow(color: UIColor = UIColor.black.withAlphaComponent(0.4), opacity: Float = 0.7, radius: CGFloat = 4, offset: CGSize = CGSize(width: 0, height: 6)) -> Self {
        super.shadow(color: color, opacity: opacity, radius: radius, offset: offset)
        return self
    }
}


extension UIButton {
    private struct AssociatedKey {
        static var onTapped: String = "onTapped"
    }

    private var _onTapped: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.onTapped) as? (() -> Void)
        }

        set {
            objc_setAssociatedObject(self, &AssociatedKey.onTapped, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    @discardableResult
    public func onTapped(_ closure: @escaping () -> Void) -> UIButton {
        _onTapped = closure
        addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        return self
    }

    @objc private func onButtonTapped() {
        _onTapped?()
    }
}
