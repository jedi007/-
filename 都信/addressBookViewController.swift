//
//  addressBookViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/5.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class addressBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var titleItem: UIBarButtonItem!
    @IBOutlet weak var addItem: UIBarButtonItem!
    @IBOutlet weak var searchItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    var dataArray:Array<String>?
    var systemDataArray:Array<String> = ["新的朋友", "群聊", "标签", "公众号"]
    var titleArray:[String]?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBarItem.image = UIImage(named: "通讯录")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        self.tabBarItem.selectedImage = UIImage(named: "通讯录")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        
        dataArray = Array<String>()
        for _ in 0...3 {
            dataArray?.append("联系人")
        }
        titleArray = ["🌟","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]
        
        tableView.register(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: "TableViewCellId")
        //设置数据源与代理
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //设置列表有多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return dataArray!.count
    }
    //设置每行数据的数据载体Cell视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath)
            cell.textLabel?.text = systemDataArray[indexPath.row]
            cell.imageView?.image = UIImage(named: systemDataArray[indexPath.row])?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            return cell
        }
        
        
        //获取到载体Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath)
        cell.textLabel?.text = dataArray![indexPath.row]
        
        cell.imageView?.image = UIImage(named: "示例头像")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
//        let model = dataArray![indexPath.row]
//        //对cell进行设置
//        cell.iconView.image = UIImage(named: model.imageName!)
//        cell.proTitle.text = model.name
//        cell.proDetail.text = model.subTitle
//        cell.price.text = model.price
        return cell
    }
    //设置列表的分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray!.count
    }
    //设置索引栏标题
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titleArray!
    }
    //设置分区头部标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return titleArray![section]
    }
    //这个方法将索引栏上的文字与具体的分区进行绑定
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}
