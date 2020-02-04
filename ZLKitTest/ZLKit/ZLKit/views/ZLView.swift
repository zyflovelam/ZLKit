//
//  ZLView.swift
//  ZLKit
//
//  Created by Zyf on 2019/9/17.
//  Copyright © 2019 dev-zhang. All rights reserved.
//

import UIKit

public class ZLView: UIView {
    private var _isScaleAtViewOnTapped: Bool = false

    private var _onTouchesBegan: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> Void)?
    private var _onTouchesMoved: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> Void)?
    private var _onTouchesEnded: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> Void)?
    private var _onViewTapped: ((_ view: ZLView) -> Void)?

    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZLView {
    public static func create(_ frame: CGRect = .zero) -> ZLView {
        return ZLView(frame: frame)
    }

    @discardableResult
    public func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    public func cornerRadius(_ size: CGFloat) -> Self {
        layer.cornerRadius = size
        return self
    }

    @discardableResult
    public func maskCorner(_ masks: CACornerMask) -> Self {
        layer.maskedCorners = masks
        return self
    }


    @discardableResult
    public func shadow(color: UIColor = UIColor.black.withAlphaComponent(0.6), opacity: Float = 0.7, radius: CGFloat = 4, offsetHeight: CGFloat = 6) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: offsetHeight)
        return self
    }

    public func hideShadow() {
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
    }

    @discardableResult
    public func border(color: UIColor = UIColor.black.withAlphaComponent(0.4), width: CGFloat = 1) -> Self {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        return self
    }

    @discardableResult
    public func hideBorder() -> Self {
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
        return self
    }

    @discardableResult
    public func enableScaleAtViewOnTapped(_ enabled: Bool) -> Self {
        _isScaleAtViewOnTapped = enabled
        return self
    }
}

extension ZLView {
    public enum GradientBackgroundDirection {
        case leftToRight
        case topToBottom
    }

    public func gradientBackgroundColor(startColor: UIColor, endColor: UIColor, direction: GradientBackgroundDirection, size: CGSize) -> ZLView {
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
        layer.insertSublayer(gradientLayer, at: 0)
        return self
    }
}

// MARK: - events

extension ZLView {
    
    @discardableResult
    public func onViewTapped(_ action: @escaping (ZLView) -> Void) -> ZLView {
        _onViewTapped = action
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewTappedWithGesture(_:))))
        isUserInteractionEnabled = true
        return self
    }

    @objc private func onViewTappedWithGesture(_ sender: UITapGestureRecognizer) {
        _onViewTapped?(self)
    }

    public func onTouchesBegan(action: @escaping (_ touches: Set<UITouch>, _ event: UIEvent?) -> Void) -> ZLView {
        _onTouchesBegan = action
        return self
    }

    public func onTouchesMoved(action: @escaping (_ touches: Set<UITouch>, _ event: UIEvent?) -> Void) -> ZLView {
        _onTouchesMoved = action
        return self
    }

    public func onTouchesEnded(action: @escaping (_ touches: Set<UITouch>, _ event: UIEvent?) -> Void) -> ZLView {
        _onTouchesEnded = action
        return self
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _onTouchesBegan?(touches, event)
        if _isScaleAtViewOnTapped {
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        _onTouchesEnded?(touches, event)
        if _isScaleAtViewOnTapped {
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        _onTouchesMoved?(touches, event)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        _onTouchesEnded?(touches, event)
        if _isScaleAtViewOnTapped {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
