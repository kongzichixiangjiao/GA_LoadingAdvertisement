//
//  GA_AdvertisementManager.swift
//  GA_LoadingAdvertisement
//
//  Created by houjianan on 16/5/20.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import Foundation

class AdvertisementManager: NSObject {
    var code: Int = -1
    var msg: String?
    var data: Advertisement?
    
    class func loadAdvertisementData(completion:(data: Advertisement?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("advertisement", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dic: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let advertisement = Advertisement(data: dic as! [String : AnyObject])
            completion(data: advertisement, error: nil)
        }
    }
}

class Advertisement: NSObject {
    
    let keyTitle = "title"
    let keyImageNmae = "img_name"
    let keyStartTime = "starttime"
    let keyEndTime = "endtime"
    
    var title = ""
    var imageName = ""
    var startTime = ""
    var endTime = ""
    
    init(data: [String : AnyObject]) {
        let dic = data["data"] as! [String : AnyObject]
        self.title = dic[keyTitle] as! String
        self.imageName = dic[keyImageNmae] as! String
        self.startTime = dic[keyStartTime] as! String
        self.endTime = dic[keyEndTime] as! String
    }
}
