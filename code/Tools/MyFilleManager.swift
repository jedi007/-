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
    
    func readPathLossFile(_ path: String) -> [[Substring]]? {
        let fileManager = FileManager.default
        if let url = URL.init(string: path) {
            if fileManager.fileExists(atPath: url.path) {
                let txtData = fileManager.contents(atPath: url.path)
                var dataArray:[[Substring]] = []
                if txtData == nil {
                    return nil
                }
                let readString = String(data: txtData!, encoding: String.Encoding.utf8)
                print("readString: \(String(describing: readString))")
                if readString!.contains("\r\n") {
                    let dataOfRowArray = readString?.split(separator: "\r\n")
                    for (_,rowString) in dataOfRowArray!.enumerated() {
                        let rowArray = rowString.split(separator: ",")
                        if rowArray.count > 0 {
                            dataArray.append(rowArray)
                        }
                    }
                } else {
                    let dataOfRowArray = readString?.split(separator: "\r")
                    for (_,rowString) in dataOfRowArray!.enumerated() {
                        let rowArray = rowString.split(separator: ",")
                        if rowArray.count > 0 {
                            dataArray.append(rowArray)
                        }
                    }
                }
                return dataArray
            }else {
                print("Path loss file is not exists")
                return nil
            }
        }
        return []
    }
}
