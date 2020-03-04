//
//  ViewController.swift
//  ZLKitTest
//
//  Created by zyf on 2020/3/4.
//  Copyright © 2020 zyf. All rights reserved.
//

import UIKit
import ZLKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let view1 = UIView()
            .frame(CGRect(x: 100, y: 100, width: 100, height: 100))
            .background(UIColor.purple)
        view.addSubview(view1)

        let view2 = UIView()
            .config { builder in
                builder.backgroundColor = .red
                builder.frame = CGRect(x: 100, y: 220, width: 100, height: 100)
            }
            .build()
        view.addSubview(view2)

        let view3 = UIView { builder in
            builder.backgroundColor = .yellow
            builder.frame = CGRect(x: 100, y: 340, width: 100, height: 100)
        }
        .build()
        view.addSubview(view3)
    }
}
