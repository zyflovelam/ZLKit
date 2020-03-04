//
//  UIView+Extensions.swift
//  ZLKit
//
//  Created by zyf on 2020/3/2.
//  Copyright © 2020 zyf. All rights reserved.
//

import SnapKit
import UIKit

extension UIView {
    @discardableResult
    @objc public func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    @objc public func cornerRadius(_ corderRadius: CGFloat) -> Self {
        layer.cornerRadius = corderRadius
        return self
    }

    @discardableResult
    @objc public func maskCorner(_ maskCorners: CACornerMask) -> Self {
        layer.maskedCorners = maskCorners
        return self
    }

    @discardableResult
    @objc public func border(width: CGFloat = 1, color: UIColor = .black) -> Self {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        return self
    }

    @discardableResult
    @objc public func background(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    @objc public func shadow(color: UIColor = UIColor.black.withAlphaComponent(0.4), opacity: Float = 0.7, radius: CGFloat = 4, offset: CGSize = CGSize(width: 0, height: 6)) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        return self
    }

    public enum GradientBackgroundDirection {
        case leftToRight
        case topToBottom
    }

    /// 渐变色背景
    /// - Parameters:
    ///   - startColor: 开始颜色
    ///   - endColor: 结束颜色
    ///   - direction: 方向:左->右 | 上->下
    ///   - size: 晕染大小
    @discardableResult
    public func gradientBackgroundColor(startColor: UIColor, endColor: UIColor, direction: GradientBackgroundDirection, size: CGSize, advance: ((CAGradientLayer) -> Void)? = nil) -> Self {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0, 1]
        switch direction {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.maskedCorners = layer.maskedCorners
        layer.insertSublayer(gradientLayer, at: 0)
        advance?(gradientLayer)
        return self
    }
}

extension UIView {
    private struct AssociatedKey {
        static var onTapped: String = "onTapped"
        static var builder: String = "builder"
        static var builderConfig: String = "builderConfig"
    }

    private var _onTapped: () -> Void {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.onTapped) as? (() -> Void) ?? {}
        }

        set {
            objc_setAssociatedObject(self, &AssociatedKey.onTapped, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    @discardableResult
    public func onTapGesture(_ closure: @escaping () -> Void) -> UIView {
        _onTapped = closure
        return self
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        _onTapped()
    }
}

extension UIView {
    public class Builder {
        private var parentView: UIView?

        fileprivate init(_ parentView: UIView) {
            self.parentView = parentView
        }

        public var backgroundColor: UIColor? {
            set {
                parentView?.backgroundColor = newValue
            }
            get {
                return parentView?.backgroundColor
            }
        }

        public var frame: CGRect {
            get {
                return parentView?.frame ?? .zero
            }
            set {
                parentView?.frame = newValue
            }
        }

        public func build() -> UIView {
            parentView?.config?(self)
            return parentView!
        }
    }

    private var builder: Builder {
        return Builder(self)
    }

    fileprivate var config: ((Builder) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.builderConfig) as? ((Builder) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.builderConfig, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    public func config(_ closure: @escaping (Builder) -> Void) -> Builder {
        config = closure
        return builder
    }

    public func build() -> UIView {
        config?(builder)
        return self
    }

    public convenience init(_ closure: @escaping (Builder) -> Void) {
        self.init()
        config = closure
    }
}
