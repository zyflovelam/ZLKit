//
//  ViewController.swift
//  ZLKitTest
//
//  Created by Zyf on 2019/9/17.
//  Copyright © 2019 dev-zhang. All rights reserved.
//

import UIKit
import ZLKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ZLView.create()
            .frame(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
            .backgroundColor(color: UIColor.purple)
            .cornerRadius(size: 5)
            .showShadow()
            .showBorder()
            .onViewTapped { (view) in
                print("on view tapped")
            }
        view.isScaleAtViewOnTapped = true
        self.view.addSubview(view)
        
    }


}
