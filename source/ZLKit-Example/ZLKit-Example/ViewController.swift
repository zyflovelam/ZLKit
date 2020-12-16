//
//  ViewController.swift
//  ZLKit-Example
//
//  Created by zyf on 2020/12/16.
//

import UIKit
import ZLKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView()
            .gradientBackgroundColor(startColor: .blue, endColor: .red, direction: .topToBottom, size: CGSize(width: 100, height: 100))
            .border(.red)
            .shadow(color: .black)
            .cornerRadius(5, masks: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            .addTo(view)
            .constraint { make in
                make.top.equalToSuperview().offset(100)
                make.centerX.equalToSuperview()
                make.size.equalTo(100)
            }
            .onTapped { _ in
                print("点击了view")
            }

        let imageView1 = UIImageView("logo")
            .addTo(view)
            .constraint { make in
                make.top.equalTo(view1.snp.bottom).offset(20)
                make.size.equalTo(100)
                make.centerX.equalToSuperview()
            }
        
        
    }
}
