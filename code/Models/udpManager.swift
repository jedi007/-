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
    
    var clientSocket: GCDAsyncSocket!   // 服务器socket
    var udp:GCDAsyncUdpSocket!
    var udpError:String?
    
    let localPort:UInt16 = 8008
    
    private override init() {
        super.init()
        
        print("init udpmanager")
        
        udp = GCDAsyncUdpSocket(delegate:self, delegateQueue: DispatchQueue.main);
        do
        {
            try udp.enableBroadcast(true)
            try udp.bind(toPort: localPort, interface:udpError)
            try udp.beginReceiving()
        }
        catch{
            print("catch:\(udpError)")
        }
        
        //开始广播(toHost 255.255.255.255 即为广播)
        udp.send("test".data(using: String.Encoding.utf8)!, toHost: "171.216.249.223", port: 8009, withTimeout: -1, tag: 0)
    }
}
 
extension UdpManager: GCDAsyncUdpSocketDelegate {
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        let receiveData = String(data: data, encoding: String.Encoding.utf8)
        print("data=" , data.toHexString()  , "\n" ,  "receiveData=" , receiveData!)
        
        let fromAddress2 = String(data: address, encoding: String.Encoding.utf8)
        print("fromAddressData=" , address.toHexString()  , "\n" ,  "fromAddress=" , fromAddress2)
    }
    
    func udpSocket(_ sock:GCDAsyncUdpSocket, didSendDataWithTag tag:Int) {
        print("已经发送数据:\(tag)")
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


