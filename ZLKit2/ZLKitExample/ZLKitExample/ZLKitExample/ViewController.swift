//
//  ViewController.swift
//  ZLKitExample
//
//  Created by zyf on 2020/3/6.
//  Copyright © 2020 zyf. All rights reserved.
//

import UIKit
import ZLKit
import SnapKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let view1 = UIView()
            .background(.red)
            .border(width: 1, color: .blue)
            .shadow()
        view.addSubview(view1) { (make) in
            make.top.left.equalToSuperview()
            make.size.equalTo(100)
        }
    }
}
