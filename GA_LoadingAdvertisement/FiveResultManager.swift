//
//  FiveResultManager.swift
//  shenbian-1.1.0
//
//  Created by houjianan on 15/11/5.
//  Copyright © 2015年 WeiMiao. All rights reserved.
//

import Foundation
//存feed搜索结果
class FiveResultManager {
    var filePath: String
    var results: [[String : AnyObject]]?
    
    init(filePathManager: FilePathManager) throws {
        let fileManager = NSFileManager.defaultManager()
        
        filePath = filePathManager.documentPath + "/fiveResultWithFeedSearch"
        if fileManager.fileExistsAtPath(filePath), let data = NSData(contentsOfFile: filePath), json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? NSDictionary, results = json["results"] as? [[String : AnyObject]] {
            self.results = results
        } else {
            self.results = nil
        }
    }
    
    func update1(results: [[String : AnyObject]]?) throws {
        self.results = results
        if results != nil {
            try NSJSONSerialization.dataWithJSONObject(["results": results!], options: NSJSONWritingOptions()).writeToFile(filePath, atomically: true)
        } else {
            let fileManager = NSFileManager.defaultManager()
            try fileManager.removeItemAtPath(filePath)
        }
    }
    
    let SAVE_RESULT_NUMS: Int = 5
    func update(searchTest: [String : AnyObject]) throws {
        print(searchTest)
        if var arr:[[String : AnyObject]] = self.results {
            var i = 0
            for a in arr {
                if let name: String = searchTest["name"] as? String, let name1: String = a["name"] as? String {
                    if name == name1 {
                        arr.removeAtIndex(i)
                    } else {
                        i += 1
                    }
                }
            }
            if arr.count >= 5 {   
                arr.insert(searchTest, atIndex: 0)
                arr.removeRange(Range(SAVE_RESULT_NUMS..<arr.count))
            } else {
                arr.append(searchTest)
            }
            try! self.update1(arr)
        } else {
            let resulet: [[String : AnyObject]] = [searchTest]
            try! self.update1(resulet)
        }   
    }
}


//存地图页搜索
class MapSearchManager {
    var filePath: String = ""
    var results: [[String : AnyObject]] = []
    
    init(filePathManager: FilePathManager) throws {
        let fileManager = NSFileManager.defaultManager()
        filePath = filePathManager.documentPath + "/mapSearch"
        if fileManager.fileExistsAtPath(filePath), let data = NSData(contentsOfFile: filePath), json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? NSDictionary, results = json["results"] as? [[String : AnyObject]] {
            self.results = results
        } else {
            self.results.removeAll()
        }
    }
    
    func update1(results: [[String : AnyObject]]?) throws {
        self.results = results!
        if results != nil {
            try NSJSONSerialization.dataWithJSONObject(["results": results!], options: NSJSONWritingOptions()).writeToFile(filePath, atomically: true)
        } else {
            let fileManager = NSFileManager.defaultManager()
            try fileManager.removeItemAtPath(filePath)
        }
    }
    
    let SAVE_RESULT_NUMS: Int = 5
    func update(searchTest: [String : AnyObject]) throws {
        if var arr:[[String : AnyObject]] = self.results {
            var i = 0
            for a in arr {
                if let name: String = searchTest["name"] as? String, let name1: String = a["name"] as? String {
                    if name == name1 {
                        arr.removeAtIndex(i)
                    } else {
                        i += 1
                    }
                }
            }
            if arr.count >= 5 {
                arr.insert(searchTest, atIndex: 0)
                arr.removeRange(Range(SAVE_RESULT_NUMS..<arr.count))
            } else {
                arr.append(searchTest)
            }
            try! self.update1(arr)
        } else {
            let resulet: [[String : AnyObject]] = [searchTest]
            try! self.update1(resulet)
        }
    }
    
}


