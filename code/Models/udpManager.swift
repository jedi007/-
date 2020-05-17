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
    static let shared = UdpManager()
    
    var timer:DispatchSourceTimer!
    
    var clientSocket: GCDAsyncSocket!   // 服务器socket
    var udp:GCDAsyncUdpSocket!
    var udpError:String?
    
    var receiveHandle: ((_ data: Data,_ host: String,_ port: UInt16) -> Void)?
    
    let localPort:UInt16 = 8008
    
    private override init() {
        super.init()
        
        print("init udpmanager")
        
        udp = GCDAsyncUdpSocket(delegate:self, delegateQueue: DispatchQueue.main);
        do
        {
            try udp.enableBroadcast(true)
            print("do bindport")
            if bindPort(toPort: localPort) {
                print("do bindport success")
                startTimer()
            }
            
        }
        catch{
            print("catch:\(udpError)")
        }
    }
    
    func sendData(data: Data, toHost: String, port: UInt16) -> Void {
        //开始广播(toHost 255.255.255.255 即为广播)
        udp.send(data, toHost: toHost, port: port, withTimeout: -1, tag: 0)
    }
    
    func bindPort(toPort: UInt16)->Bool
    {
        do {
            try udp.bind(toPort: toPort, interface:udpError)
            try udp.beginReceiving()
        } catch  {
            print("catch:\(udpError)")
            return false
        }
        return true
    }
    
    func close() -> Void {
        udp.close()
    }
    
    //建立与服务器的心跳连接
    func startTimer() {
        print("startTimer")
       // 在global线程里创建一个时间源
       timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
       // 设定这个时间源是每秒循环一次，立即开始
       timer.schedule(deadline: .now(), repeating: .seconds(48))
       // 设定时间源的触发事件
       timer.setEventHandler(handler: {
            print("心跳触发")
            if let telephone = mainUserInfo.telephone
            {
                var dic : [String: AnyObject] = [:]
                dic["telephone"] = telephone as AnyObject?
                dic["action"] = 0 as AnyObject?
                let convertStr:String = JSONTools.shared.convertDictionaryToString(dict: dic)
                let senddata = convertStr.data(using: .utf8)!
                self.sendData(data: senddata, toHost: httpManager.shared.serverIP, port: httpManager.shared.serverPort)
            }
        
//           // 返回主线程处理一些事件，更新UI等等
//           DispatchQueue.main.async {
//
//           }
       })
       // 启动时间源
       timer.resume()
    }
}
 
extension UdpManager: GCDAsyncUdpSocketDelegate {
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        if let hostInfo = GCDAsyncUdpSocket.host(fromAddress: address)
        {
            let fromHost = String( hostInfo.split(separator: ":").last! )
            let fromPort = GCDAsyncUdpSocket.port(fromAddress: address)
            print("receive data : \(data)")
            if let recvievH = receiveHandle {
                recvievH(data,fromHost,fromPort)
            }
        }
    }
    
    func udpSocket(_ sock:GCDAsyncUdpSocket, didSendDataWithTag tag:Int) {
        //print("已经发送数据:\(tag)")
    }
    
}

extension Data {
    public init(hex: String) {
        self.init(bytes: Array<UInt8>(hex: hex))
    }
    public var bytes: Array<UInt8> {
        return Array(self)
    }
    public func toHexString() -> String {
        return bytes.toHexString()
    }
}

extension Array {
    public init(reserveCapacity: Int) {
        self = Array<Element>()
        self.reserveCapacity(reserveCapacity)
    }
    
    var slice: ArraySlice<Element> {
        return self[self.startIndex ..< self.endIndex]
    }
}

extension Array where Element == UInt8 {
    public init(hex: String) {
        self.init(reserveCapacity: hex.unicodeScalars.lazy.underestimatedCount)
        var buffer: UInt8?
        var skip = hex.hasPrefix("0x") ? 2 : 0
        for char in hex.unicodeScalars.lazy {
            guard skip == 0 else {
                skip -= 1
                continue
            }
            guard char.value >= 48 && char.value <= 102 else {
                removeAll()
                return
            }
            let v: UInt8
            let c: UInt8 = UInt8(char.value)
            switch c {
            case let c where c <= 57:
                v = c - 48
            case let c where c >= 65 && c <= 70:
                v = c - 55
            case let c where c >= 97:
                v = c - 87
            default:
                removeAll()
                return
            }
            if let b = buffer {
                append(b << 4 | v)
                buffer = nil
            } else {
                buffer = v
            }
        }
        if let b = buffer {
            append(b)
        }
    }
    
    public func toHexString() -> String {
        return `lazy`.reduce("") {
            var s = String($1, radix: 16)
            if s.count == 1 {
                s = "0" + s
            }
            return $0 + s
        }
    }
}



