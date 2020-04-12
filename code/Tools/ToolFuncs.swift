//
//  ToolFuncs.swift
//  jediChat
//
//  Created by 李杰 on 2020/4/12.
//  Copyright © 2020 李杰. All rights reserved.
//

func judgeStringIncludeChineseWord(string: String) -> Bool {
    
    for (_, value) in string.enumerated() {

        if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
            return true
        }
    }
    
    return false
}


extension String {
    //获取下标对应的字符
    func charAt(pos: Int) -> Character? {
        if pos < 0 || pos >= count {
            return nil   //判断边界条件
        }
        let index = self.index(self.startIndex, offsetBy: pos)
        let str = self[index]
        return Character(String(str))
    }
}
//let str = "abcdef"
//print(str.charAt(pos: 1)!)  //b
