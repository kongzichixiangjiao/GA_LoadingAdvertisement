//
//  AppDelegate.swift
//  GA_LoadingAdvertisement
//
//  Created by houjianan on 16/5/20.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.advertisementTimeSecussed(_:)), name: "advertisementTimeSecussed", object: nil)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let isFirst = NSUserDefaults.standardUserDefaults().objectForKey("isFirst") as? Bool {
            if !isFirst {
                let vc = storyboard.instantiateViewControllerWithIdentifier("AdvertisementViewController") as! AdvertisementViewController
                
                AdvertisementManager.loadAdvertisementData({
                    [weak self] data, error in
                    if let weakSelf = self {
                        vc.imageName = data?.imageName
                        weakSelf.window?.rootViewController = vc
                    }
                    })
            }
        } else {
            let vc = storyboard.instantiateViewControllerWithIdentifier("GuideViewController") as! GuideViewController
            window?.rootViewController = vc
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isFirst")
        }
        
        return true
    }
    
    func advertisementTimeSecussed(notification: NSNotification) {
        let advertisementImage = notification.object as! UIImage
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
        vc.advertisementImage = advertisementImage
        window?.rootViewController = vc
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

