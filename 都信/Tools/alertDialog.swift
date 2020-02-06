//
//  alertDialog.swift
//  都信
//
//  Created by 李杰 on 2020/2/6.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class AlertDialog
{
    static let shared = AlertDialog()
    
    private init() {
    }

    func alertDialog(title:String, message:String, actionText:String, actionHandler:((UIAlertAction) -> Void)? = nil ) ->Void {
        let alertController = UIAlertController(title: title, message: message,preferredStyle: .alert)
        let Action1 = UIAlertAction(title: actionText, style: .destructive, handler: actionHandler)
        //let Action2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(Action1)
        //alertController.addAction(Action2)
        //self.present(alertController, animated: true, completion: nil)
        
        if let vc = UIViewController.currentViewController() {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
}
