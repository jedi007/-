//
//  SaveInfo.swift
//  jediChat
//
//  Created by 李杰 on 2020/4/7.
//  Copyright © 2020 李杰. All rights reserved.
//

import Foundation

class SaveInfo: NSObject {

    static func writeInfo(infoDic: Dictionary<String, AnyObject>) {
        let defaults = UserDefaults.standard
        let data:Data = NSKeyedArchiver.archivedData(withRootObject: infoDic as NSDictionary)
        defaults.set(data, forKey: "userInfo.plist")
        defaults.synchronize()
    }
    
    static func readInfo() -> Dictionary<String, AnyObject> {
        let defaults = UserDefaults.standard
        let data = defaults.object(forKey: "userInfo.plist")
        if data != nil {
            let dic = NSKeyedUnarchiver.unarchiveObject(with:data as! Data)! as! NSDictionary
            return dic as! Dictionary<String, AnyObject> 
        } else {
            return [:]
        }
    }
}
