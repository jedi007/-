//
//  NetworkManager.swift
//  都信
//
//  Created by 李杰 on 2020/2/29.
//  Copyright © 2020 李杰. All rights reserved.
//

import Foundation

class NetworkManager {
//    //获取本机的公网IP
//    public static func string GetIP()
//    {
//        string tempip = "";
//        try
//        {
//            WebRequest request = WebRequest.Create("http://ip.qq.com/");
//            request.Timeout = 10000;
//            WebResponse response = request.GetResponse();
//            Stream resStream = response.GetResponseStream();
//            StreamReader sr = new StreamReader(resStream, System.Text.Encoding.Default);
//            string htmlinfo = sr.ReadToEnd();
//            //匹配IP的正则表达式
//            Regex r = new Regex("((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]\\d|\\d)\\.){3}(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]\\d|[1-9])", RegexOptions.None);
//            Match mc = r.Match(htmlinfo);
//            //获取匹配到的IP
//            tempip = mc.Groups[0].Value;
//
//            resStream.Close();
//            sr.Close();
//        }
//        catch (Exception err)
//        {
//            tempip = err.Message;
//        }
//        return tempip;
//    }
    
    static func getPublicIP222(backBlock: @escaping ((String)->())){
        print(" Thread = \(Thread.current)")
         
        let ipURL = URL(string: "http://pv.sohu.com/cityjson?ie=utf-8")
         
        var ip: String? = nil
        do {
            if let ipURL = ipURL {
                ip = try String(contentsOf: ipURL, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            }
        } catch {
        }
        //判断返回字符串是否为所需数据
        if ip?.hasPrefix("var returnCitySN = ") ?? false {
            //对字符串进行处理，然后进行json解析
            //删除字符串多余字符串
            let range = NSRange(location: 0, length: 19)
            if let subRange = Range<String.Index>(range, in: ip ?? "") { ip?.removeSubrange(subRange) }
            let nowIp = (ip as NSString?)?.substring(to: (ip?.count ?? 0) - 1)
            //将字符串转换成二进制进行Json解析
            let data = nowIp?.data(using: .utf8)
            var dict: [String : Any]? = nil
            do {
                if let data = data {
                    dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]
                }
            } catch {
            }
            if let dict = dict {
                print("\(dict)")
                print(dict["cip"] as? String ?? "")
            }
            backBlock(dict?["cip"] as? String ?? "")
        }
        backBlock("")
    }
}

//getIFAddresses()[0]
func getIFAddresses() -> [String] {
    var addresses = [String]()
    
    // Get list of all interfaces on the local machine:
    var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
      
      var ptr = ifaddr
      while ptr != nil {
        let flags = Int32((ptr?.pointee.ifa_flags)!)
        var addr = ptr?.pointee.ifa_addr.pointee
        
        // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
        if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
          if addr?.sa_family == UInt8(AF_INET) || addr?.sa_family == UInt8(AF_INET6) {
            
            // Convert interface address to a human readable string:
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            if (getnameinfo(&addr!, socklen_t((addr?.sa_len)!), &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST) == 0) {
              if let address = String(validatingUTF8: hostname) {
                addresses.append(address)
              }
            }
          }
        }
        ptr = ptr?.pointee.ifa_next
      }

        freeifaddrs(ifaddr)
    }
    print("Local IP \(addresses)")
    return addresses
}
