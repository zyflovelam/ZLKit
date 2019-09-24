//
//  ViewController.swift
//  ZLKitTest
//
//  Created by Zyf on 2019/9/17.
//  Copyright © 2019 dev-zhang. All rights reserved.
//

import UIKit
import ZLKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ZLView.create()
            .backgroundColor(color: UIColor.purple)
            .cornerRadius(size: 5)
            .showShadow()
            .showBorder()
            .enableScaleAtViewOnTapped(true)
            .onViewTapped { (view) in
                print("on view tapped")
            }
            .addTo(view: self.view) { (make) in
                make.size.equalTo(100)
                make.left.top.equalToSuperview().offset(100)
            }
        
        let view2 = ZLView.create()
            .backgroundColor(color: UIColor.orange)
            .cornerRadius(size: 10)
            .showBorder()
            .showShadow()
            .enableScaleAtViewOnTapped(true)
            .onViewTapped { (_) in
                print("on view2 tapped")
            }
            .addTo(view: self.view) { (make) in
                make.size.equalTo(200)
                make.left.equalTo(view.snp.right)
                make.top.equalTo(view.snp.bottom).offset(20)
            }
    }


}

