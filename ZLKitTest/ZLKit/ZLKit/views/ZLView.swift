//
//  ZLView.swift
//  ZLKit
//
//  Created by Zyf on 2019/9/17.
//  Copyright © 2019 dev-zhang. All rights reserved.
//

import UIKit

public class ZLView: UIView {

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
    
    public func cornerRadius(cornerRadius: CGFloat) -> ZLView {
        self.layer.cornerRadius = cornerRadius
        return self
    }
    
    
}
