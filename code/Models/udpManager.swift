//
//  udpManager.swift
//  jediChat
//
//  Created by 李杰 on 2020/3/4.
//  Copyright © 2020 李杰. All rights reserved.
//

import Foundation
import CocoaAsyncSocket

class UdpManager:NSObject {
    
    var clientSocket: GCDAsyncSocket!   // 服务器socket
    
    override init() {
        super.init()
        clientSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }
}
 
extension UdpManager: GCDAsyncSocketDelegate {
    
    
    // 断开连接
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        
        print("disconnected-----")
    }
    // 连接成功
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        
        print("The connection is successful")
        
        let address = "Server IP：" + "\(host)"
        
        print(address)
        
        clientSocket.readData(withTimeout: -1, tag: 0)
    }
    // 接受消息
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        
        let text = String(data: data, encoding: .utf8)
        
        print(text!)
        
        clientSocket.readData(withTimeout: -1, tag: 0)
    }
}
