//
//  AddView.swift
//  jediChat
//
//  Created by 李杰 on 2020/5/1.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

protocol AddViewDelegate {
    func useImg(_ img:UIImage)
    func cancelSelectImg()
    func repairUIBUG()
}

class AddView:UIView {
    
    var delegate:AddViewDelegate?
    
    @IBAction func photoBtnClicked(_ sender: UIButton) {
        print("photoBtnClicked")
        
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        
        //photoPicker.modalPresentationStyle = .fullScreen
        //在需要的地方present出来
        UIViewController.currentViewController()!.present(photoPicker, animated: true, completion: nil)
        //self.present(photoPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func cameraBtnClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            UIViewController.currentViewController()!.present(cameraPicker, animated: true, completion: nil)
        } else {
           print("不支持拍照")
        }
    }
    
    @IBAction func vedioClicked(_ sender: UIButton) {
        AlertDialog.shared.alertDialog(title: "敬请期待", message: "功能暂未开放", actionText: "知道了", actionHandler: { (action:UIAlertAction) in
            self.delegate?.repairUIBUG()
        })
    }
    
}

extension AddView:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
     {
         print("\n\n\n\n\ndidFinishPickingMediaWithInfo")

        //获得照片
         //let image:UIImage = info[UIImagePickerController.InfoKey.editedImage.rawValue] as! UIImage
         let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
         
        // 拍照
//        if picker.sourceType == .camera {
//             //保存相册
//             UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
//        }

        //personImage.image = image
        //imgV.image = image
        
        UIViewController.currentViewController()!.dismiss(animated: true, completion: {
            self.delegate?.useImg(image)
        })
        //self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("取消了")
        UIViewController.currentViewController()!.dismiss(animated: true, completion: {
            self.delegate?.cancelSelectImg()
        })
    }
     
     
     @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {

        if error != nil {
            print("保存失败")
        } else {
            print("保存成功")
        }
    }
}
