//
//  ZLView.swift
//  ZLKit
//
//  Created by Zyf on 2019/9/17.
//  Copyright © 2019 dev-zhang. All rights reserved.
//

import UIKit

public class ZLView: UIView {
    
    public var isScaleAtViewOnTapped: Bool = false

    private var _onTouchesBegan: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> Void)?
    private var _onTouchesMoved: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> Void)?
    private var _onTouchesEnded: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> Void)?
    private var _onViewTapped: ((_ view: ZLView) -> Void)?
    
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZLView {
    public static func create(frame: CGRect = .zero) -> ZLView {
        return ZLView(frame: frame)
    }
    
    public func frame(frame: CGRect) -> ZLView {
        self.frame = frame
        return self
    }
    
    public func backgroundColor(color: UIColor) -> ZLView {
        self.backgroundColor = color
        return self
    }
    
    public func cornerRadius(size: CGFloat) -> ZLView {
        self.layer.cornerRadius = size
        return self
    }
    
    public func maskCorner(masks: CACornerMask) -> ZLView {
        self.layer.maskedCorners = masks
        return self
    }
    
    public func showShadow(color: UIColor = UIColor.black.withAlphaComponent(0.6), opacity: Float = 0.7, radius: CGFloat = 4, offsetHeight: CGFloat = 6) -> ZLView {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 0, height: offsetHeight)
        return self
    }
    
    public func hideShadow() {
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 0
    }
    
    public func showBorder(color: UIColor = UIColor.black.withAlphaComponent(0.4), width: CGFloat = 1) -> ZLView {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        return self
    }
    
    public func hideBorder() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
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
        self.layer.insertSublayer(gradientLayer, at: 0)
        return self
    }
}

// MARK: - events
extension ZLView {
    public func onViewTapped(_ action: @escaping(ZLView) -> ()) -> ZLView {
        self._onViewTapped = action
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewTappedWithGesture(_:))))
        self.isUserInteractionEnabled = true
        return self
    }
    
    @objc private func onViewTappedWithGesture(_ sender: UITapGestureRecognizer) {
        self._onViewTapped?(self)
    }
    
    public func onTouchesBegan(action: @escaping(_ touches: Set<UITouch>, _ event: UIEvent?) -> Void) -> ZLView {
        self._onTouchesBegan = action
        return self
    }
    
    public func onTouchesMoved(action: @escaping(_ touches: Set<UITouch>, _ event: UIEvent?) -> Void) -> ZLView {
        self._onTouchesMoved = action
        return self
    }
    
    public func onTouchesEnded(action: @escaping(_ touches: Set<UITouch>, _ event: UIEvent?) -> Void) -> ZLView {
        self._onTouchesEnded = action
        return self
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self._onTouchesBegan?(touches, event)
        if isScaleAtViewOnTapped {
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self._onTouchesEnded?(touches, event)
        if isScaleAtViewOnTapped {
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        self._onTouchesMoved?(touches, event)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self._onTouchesEnded?(touches, event)
        if isScaleAtViewOnTapped {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
