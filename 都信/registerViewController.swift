//
//  registerViewController.swift
//  都信
//
//  Created by 李杰 on 2020/1/29.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class reisterViewController: UIViewController {

    @IBOutlet weak var sureImage: UIImageView!
    var sureAgreement:Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(sureImageClick))
        sureImage.addGestureRecognizer(singleTapGesture)
        //sureImage.isUserInteractionEnabled = true
    }
        
    required init?(coder: NSCoder) {
        self.sureAgreement = false
        
        super.init(coder:coder)
        print("reisterViewController init is called")
        
        self.modalPresentationStyle = .fullScreen //= UIModalPresentationFullScreen
        //fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registeCliked(_ sender: UIButton) {
        
        httpManager.shared.regist(name: "lijie", telephone: "1356899002", password: "111111", sex: "男", birthday: "1988-05-13 18:18:18")
        
    }
    
    
    
    @objc func sureImageClick() -> Void {
        print("image is clicked")
        
        self.sureAgreement = !self.sureAgreement
        if self.sureAgreement {
            let image = UIImage(named:"RadioButton-checked.jpg")
            sureImage.image = image
        }
        else
        {
            let image = UIImage(named:"RadioButton-unchecked.jpg")
            sureImage.image = image
        }
    }
    
    
}
