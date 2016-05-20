//
//  ViewController.swift
//  GA_LoadingAdvertisement
//
//  Created by houjianan on 16/5/20.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class AdvertisementViewController: UIViewController {
    
    let advertisementTime: Double = 2.0
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.frame = UIScreen.mainScreen().bounds
        return backImageView
    }()
    
    var imageName: String? {
        didSet {
            let placeholderImageName = "IMG_3097.JPG"
            
            backImageView.sd_setImageWithURL(NSURL(string: imageName!), placeholderImage: UIImage(named: placeholderImageName)) { (image, error, _, _) -> Void in
                if error != nil {
                    print("加载广告失败")
                }
                if image != nil {
                    let time = dispatch_time(DISPATCH_TIME_NOW,Int64(self.advertisementTime * Double(NSEC_PER_SEC)))
                    dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName("advertisementTimeSecussed", object: image)
                    })
                } else {
                    print("加载广告失败")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backImageView)
        
    }
    
}

