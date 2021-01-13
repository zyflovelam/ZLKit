//
//  UIButton+Extensions.swift
//  ZLKit
//
//  Created by zyf on 2021/1/13.
//

import UIKit

extension UIButton {
    @discardableResult public func title(_ title: String, for states: [UIControl.State] = []) -> Self {
        if states.count == 0 {
            setTitle(title, for: .normal)
            setTitle(title, for: .disabled)
            setTitle(title, for: .highlighted)
            setTitle(title, for: .selected)
        } else {
            states.forEach { state in
                setTitle(title, for: state)
            }
        }
        return self
    }

    @discardableResult public func titleFont(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }

    @discardableResult public func titleColor(_ color: UIColor, for states: [UIControl.State] = []) -> Self {
        if states.count == 0 {
            setTitleColor(color, for: .normal)
            setTitleColor(color, for: .disabled)
            setTitleColor(color, for: .highlighted)
            setTitleColor(color, for: .selected)
        } else {
            states.forEach { state in
                setTitleColor(color, for: state)
            }
        }
        return self
    }

    @discardableResult func setImage(_ named: String, size: CGSize = .zero, for states: [UIControl.State]) -> Self {
        var image = UIImage(named: named)
        if size != .zero {
            image = image?.resizeImage(size)
        }
        if states.count == 0 {
            setImage(image, for: .normal)
            setImage(image, for: .disabled)
            setImage(image, for: .highlighted)
            setImage(image, for: .selected)
        } else {
            states.forEach { state in
                setImage(image, for: state)
            }
        }
        return self
    }
}

public typealias UIButtonOnTappedListener = (UIButton) -> Void

extension UIButton {
    private struct Keys {
        static var onTappedListener = "com.dev-zhang.zlkit:onUIButtonTappedListener"
    }

    private var onTappedListener: UIButtonOnTappedListener? {
        get {
            return objc_getAssociatedObject(self, &Keys.onTappedListener) as? UIButtonOnTappedListener
        }
        set(newValue) {
            objc_setAssociatedObject(self, &Keys.onTappedListener, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc public func onTapped(_ action: @escaping UIButtonOnTappedListener) {
        onTappedListener = action
        addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }

    @objc private func onButtonTapped() {
        if let listener = self.onTappedListener {
            listener(self)
        }
    }
}

