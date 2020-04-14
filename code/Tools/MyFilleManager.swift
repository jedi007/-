//
//  MyFilleManager.swift
//  jediChat
//
//  Created by 李杰 on 2020/4/13.
//  Copyright © 2020 李杰. All rights reserved.
//

import Foundation

class MyFileManager {
    static func saveBytesToFile(bytes:Data,fileName:String = "AllMessages.dat") -> Void {
        let fileManager = FileManager.default
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = file! + "/"+fileName

        fileManager.createFile(atPath: path, contents:nil, attributes:nil)

        let handle = FileHandle(forWritingAtPath:path)
        handle?.write(bytes)
    }
    
    static func readBytesFromFile(fileName:String = "AllMessages.dat")->Data? {
        let fileManager = FileManager.default
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = file! + "/"+fileName
    
        if let url = URL.init(string: path) {
            if fileManager.fileExists(atPath: url.path) {
                return fileManager.contents(atPath: url.path)
            }else {
                print("Path loss file is not exists")
            }
        }
        return nil
    }
    
    static func saveMessagesDic() -> Void {
        let queue = DispatchQueue(label: "saveMessagesDic")
        queue.async {  //异步方法不阻塞UI
            let messageDicData = NSKeyedArchiver.archivedData(withRootObject:messagesDics as NSDictionary)
            MyFileManager.saveBytesToFile(bytes: messageDicData)
        }
    }
}
