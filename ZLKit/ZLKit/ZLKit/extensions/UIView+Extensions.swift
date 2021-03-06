//
//  UIView+Extensions.swift
//  ZLKit
//
//  Created by zyf on 2021/1/13.
//
import SnapKit
import UIKit

public let defaultAnimationTime: TimeInterval = 0.2

extension UIView {
    @discardableResult public func addTo(_ superView: UIView, withConstraints: ((ConstraintMaker) -> Void)? = nil) -> Self {
        superView.addSubview(self)
        if let constraints = withConstraints {
            self.snp.makeConstraints(constraints)
        }
        return self
    }
    
    @discardableResult public func addSubview(_ subview: UIView, withConstraints: ((ConstraintMaker) -> Void)? = nil) -> Self {
        addSubview(subview)
        if let constraints = withConstraints {
            subview.snp.makeConstraints(constraints)
        }
        return self
    }
}

extension UIView {
    @discardableResult public func remakeConstraints(_ constraints: @escaping (ConstraintMaker) -> Void, animated: Bool = false) -> Self {
        if animated {
            UIView.animate(withDuration: defaultAnimationTime) {
                self.snp.remakeConstraints(constraints)
                self.superview?.layoutIfNeeded()
            }
        } else {
            self.snp.remakeConstraints(constraints)
        }
        return self
    }
    
    
    @discardableResult public func updateConstraints(_ constraints: @escaping (ConstraintMaker) -> Void, animated: Bool = false) -> Self {
        if animated {
            UIView.animate(withDuration: defaultAnimationTime) {
                self.snp.updateConstraints(constraints)
                self.superview?.layoutIfNeeded()
            }
        } else {
            self.snp.updateConstraints(constraints)
        }
        return self
    }
}

extension UIView {
    @discardableResult public func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult public func border(_ color: UIColor, width: CGFloat = 1) -> Self {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        return self
    }

    @discardableResult public func shadow(color: UIColor, opacity: Float = 0.4, radius: CGFloat = 4, offset: CGSize = CGSize(width: 0, height: 6)) -> UIView {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        return self
    }

    @discardableResult public func cornerRadius(_ size: CGFloat, masks: CACornerMask = []) -> Self {
        layer.cornerRadius = size
        if !masks.isEmpty {
            layer.maskedCorners = masks
        }
        return self
    }

    public func hideBorder() {
        layer.borderWidth = 0
    }
    
    public enum UIViewGradientBackgroundDirection {
        case leftToRight
        case topToBottom
    }
    
    @discardableResult public func gradientBackgroundColor(startColor: UIColor, endColor: UIColor, direction: UIViewGradientBackgroundDirection, size: CGSize, corner: CGFloat = 8) -> Self {
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
        gradientLayer.cornerRadius = corner
        layer.insertSublayer(gradientLayer, at: 0)
        return self
    }
}

public typealias UIViewOnTappedListener = (UIView) -> Void

extension UIView {
    private struct Keys {
        static var onUiViewTappedListener = "com.dev-zhang.zlkit:onUIViewTappedListener"
    }

    private var onTappedListener: ((UIView) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &Keys.onUiViewTappedListener) as? ((UIView) -> Void)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &Keys.onUiViewTappedListener, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult public func onTapped(_ closure: @escaping (UIView) -> Void) -> Self {
        isUserInteractionEnabled = true
        onTappedListener = closure
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onUiViewTapped)))
        return self
    }

    @objc private func onUiViewTapped() {
        if let listener = onTappedListener {
            listener(self)
        }
    }
}
