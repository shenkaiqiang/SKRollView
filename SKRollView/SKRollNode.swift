//
//  SKRollNode.swift
//  shen
//
//  Created by 沈凯强 on 2021/01/01.
//  Copyright © 2021 mn. All rights reserved.
//

import Foundation

class SKRollNode {

    var index:Int = 0
    var data:Any?
    var next:SKRollNode? // 下一个
    var last:SKRollNode? // 上一个
    
    class func createLinkList(dataArr:[Any]) -> SKRollNode {
        let head = SKRollNode.init()
        head.data = dataArr.first
        head.index = 0
        var ptr = head
        for (iii,ddd) in dataArr.enumerated() {
            guard iii > 0 else {
                continue
            }
            let node = SKRollNode.init()
            node.index = iii
            node.data = ddd
            ptr.next = node
            node.last = ptr
            ptr = node
        }
        head.last = ptr
        ptr.next = head
        
        if dataArr.count == 1 {
            head.next = ptr
        }
        return head
    }
    
    func insertDataAfter(data:Any) {
        
        let node = SKRollNode.init()
        node.data = data
        node.next = self.next
        node.last = self
        
        if self.next!.index == 0 { // 判断当前是否是最后一个
            node.index = self.index + 1
        } else {
            node.index = self.next?.index ?? 0
        }
        
        self.next?.last = node
        self.next = node
        
        if node.next!.index != 0 {
            var temp = node
            while temp.next!.index != 0 {
                temp = temp.next!
                if temp.next!.index == 0 {
                    break
                }
                temp.index = temp.index+1
            }
        }
        debugPrint("当前下标:\(self.index),插入下标:\(node.index)")
    }
}
