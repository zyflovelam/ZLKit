//
//  ZLSwitch.swift
//  ZLKit
//
//  Created by zyf on 2020/12/20.
//

import AVFoundation
import UIKit

public struct ZLSwitchAppearence {
    static public let size: CGSize = CGSize(width: 55, height: 22)
    
    var borderColor: UIColor
    var borderWidth: CGFloat
    var backgroundColor: UIColor
    var tintColor: UIColor

    static func `default`() -> ZLSwitchAppearence {
        ZLSwitchAppearence(borderColor: UIColor(red: 96 / 255, green: 190 / 255, blue: 169 / 255, alpha: 1), borderWidth: 2, backgroundColor: UIColor(red: 230 / 255, green: 233 / 255, blue: 235 / 255, alpha: 1), tintColor: UIColor(red: 87 / 255, green: 201 / 255, blue: 175 / 255, alpha: 1))
    }
}

open class ZLSwitch: UIView {
    var isOn: Bool = false {
        didSet {
            animation()
        }
    }

    var isEnabled: Bool = true

    private var size: CGSize = CGSize(width: 55, height: 22) {
        didSet {
            updateView()
        }
    }

    var appearence: ZLSwitchAppearence = .default()

    // MARK: - Subviews

    private var backgroundView: UIView = UIView()
    private var coverView: UIView = UIView()
    private var thumbView: UIView = UIView()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        bindEvents()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    @discardableResult public func setSize(_ size: CGSize) -> Self {
        self.size = size
        return self
    }
}

extension ZLSwitch {
    private func initView() {
        frame = CGRect(origin: frame.origin, size: size)
        backgroundColor = .clear
        layer.cornerRadius = size.height / 2
        layer.masksToBounds = true
        addSubview(backgroundView)
        addSubview(coverView)
        addSubview(thumbView)
        updateView()
    }

    private func updateView() {
        backgroundView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        backgroundView.backgroundColor = appearence.backgroundColor
        backgroundView.layer.borderWidth = appearence.borderWidth
        backgroundView.layer.borderColor = appearence.backgroundColor.cgColor
        backgroundView.layer.cornerRadius = size.height / 2
        coverView.frame = CGRect(x: 1, y: 1, width: size.width - 2, height: size.height - 2)
        coverView.backgroundColor = appearence.backgroundColor
        coverView.layer.cornerRadius = (size.height - 2) / 2
        thumbView.frame = CGRect(x: 1, y: 1, width: size.height - 2, height: size.height - 2)
        thumbView.backgroundColor = .white
        thumbView.layer.cornerRadius = (size.height - 2) / 2
    }

    private func bindEvents() {
        onTapped { [weak self] _ in
            self?.onSwitchTapped()
        }
    }
}

extension ZLSwitch {
    private func onSwitchTapped() {
        guard isEnabled else { return }
        peek()
        isOn.toggle()
        animation()
    }
}

extension ZLSwitch {
    private func animation() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            if self.isOn {
                self.coverView.frame.origin = CGPoint(x: self.size.width - (self.size.height - 1), y: 1)
                self.coverView.frame.size = CGSize(width: self.size.height - 2, height: self.size.height - 2)
                self.thumbView.frame.origin = CGPoint(x: self.size.width - (self.size.height - 1), y: 1)
                self.backgroundView.layer.borderColor = self.appearence.borderColor.cgColor
            } else {
                self.coverView.frame = CGRect(x: 1, y: 1, width: self.size.width - 2, height: self.size.height - 2)
                self.thumbView.frame.origin = CGPoint(x: 1, y: 1)
                self.backgroundView.layer.borderColor = self.appearence.borderColor.cgColor
            }
        }
    }

    private func peek() {
        let id: SystemSoundID = 1519
        AudioServicesPlaySystemSound(id)
    }
}
