//
//  GA_RootViewController.swift
//  GA_LoadingAdvertisement
//
//  Created by houjianan on 16/5/20.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private var advertisementImageView: UIImageView?
    var advertisementImage: UIImage? {
        didSet {
            weak var tmpSelf = self
            advertisementImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
            advertisementImageView!.image = advertisementImage!
            self.view.addSubview(advertisementImageView!)
            
            UIImageView.animateWithDuration(2.0, animations: { () -> Void in
                tmpSelf!.advertisementImageView!.transform = CGAffineTransformMakeScale(1.2, 1.2)
                tmpSelf!.advertisementImageView!.alpha = 0
            }) { (finsch) -> Void in
                tmpSelf!.advertisementImageView!.removeFromSuperview()
                tmpSelf!.advertisementImageView = nil
            }
        }
    }

}
