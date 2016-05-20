//
//  FilePathManager.swift
//  shenbian-1.1.0
//
//  Created by WeiMiao on 15/11/4.
//  Copyright © 2015年 WeiMiao. All rights reserved.
//

import Foundation

class FilePathManager {
    let documentPath: String
    let cachesPath: String
    
    init() throws {
        let fileManager = NSFileManager.defaultManager()
        
        var path = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0].path!
        if path.hasSuffix("/") {
            documentPath = path.substringToIndex(path.endIndex.predecessor())
        } else {
            documentPath = path
        }
        
        path = fileManager.URLsForDirectory(NSSearchPathDirectory.CachesDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0].path!
        if path.hasSuffix("/") {
            cachesPath = path.substringToIndex(path.endIndex.predecessor())
        } else {
            cachesPath = path
        }
        
        if !fileManager.fileExistsAtPath(documentPath) {
            try fileManager.createDirectoryAtPath(documentPath, withIntermediateDirectories: true, attributes: nil)
        }
        if !fileManager.fileExistsAtPath(cachesPath) {
            try fileManager.createDirectoryAtPath(cachesPath, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
