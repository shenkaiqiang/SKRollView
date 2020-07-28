//
//  SKRollView.swift
//  shen
//
//  Created by 沈凯强 on 2021/01/01.
//  Copyright © 2021 mn. All rights reserved.
//

import UIKit
/// 上下滚动的 视图
public class SKRollView: UIView {

    // GCD 计时器,需要设置全局变量引用, 否则不会调用事件
    private var sourceTimer: DispatchSourceTimer?
    private var cell1:UILabel!  //当前显示的view
    private var cell2:UILabel!  //底部藏起的view
    private var nowShowNode:SKRollNode? //当前显示的node
    private var flag = 0 //标识当前是哪个view显示(currentView/hidenView)
    lazy var dataArr:[String] = Array.init()
    
    public var textColor:UIColor? {
        willSet {
            cell1.textColor = newValue
            cell2.textColor = newValue
        }
    }
    public var textAlignment:NSTextAlignment = .left {
        willSet {
            cell1.textAlignment = newValue
            cell2.textAlignment = newValue
        }
    }
    public var textFont:UIFont? {
        willSet {
            cell1.font = newValue
            cell2.font = newValue
        }
    }
    
    /// 轮播时长
    private let animateTime:TimeInterval = 0.5
    
    public var clickClosure:((_ index:Int)->Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        cell1 = UILabel.init()
        addSubview(cell1)
        cell1.font = UIFont.systemFont(ofSize: 15)
        
        cell2 = UILabel.init()
        addSubview(cell2)
        cell2.font = UIFont.systemFont(ofSize: 15)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        cell1.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
        
        cell2.frame = cell1.frame
        cell2.frame.origin.y = frame.height
    }
    
    public func reloadData(titleArr:[String]) {
        if titleArr.isEmpty {
            return
        }
        dataArr = titleArr
        
        nowShowNode = SKRollNode.createLinkList(dataArr: titleArr)
        
        cellConfigure(cell: cell1, node: nowShowNode)
        cellConfigure(cell: cell2, node: nowShowNode?.next)
        
        if titleArr.count > 1 {
            setupTimer()
        }
    }
    
}

private extension SKRollView {
    func cellConfigure(cell:UILabel, node:SKRollNode?) {
        guard let data = node?.data as? String else {
            return
        }
        cell.text = data
    }
    
    func setupTimer() {
        let queue = DispatchQueue.global()
        sourceTimer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        sourceTimer?.schedule(deadline: .now(), repeating: DispatchTimeInterval.seconds(3))
        sourceTimer?.resume()
        weak var weakself = self
        sourceTimer?.setEventHandler {
            DispatchQueue.main.async {
                weakself?.timerAction()
            }
        }
    }
    
    @objc func timerAction() {
        if flag == 1 {
        }
        nowShowNode = nowShowNode?.next
        
        if flag == 0 {
            cellConfigure(cell: cell2, node: nowShowNode)
        } else {
            cellConfigure(cell: cell1, node: nowShowNode)
        }
        weak var weakself = self
        if flag == 0 {
            UIView.animate(withDuration: animateTime, animations: {
                guard let strongself = weakself else {
                    return
                }
                weakself?.cell1.frame.origin.y = -strongself.frame.height
                weakself?.cell2.frame.origin.y = 0
            }) { (isfinish) in
                guard let strongself = weakself else {
                    return
                }
                weakself?.flag = 1
                weakself?.cell1.frame.origin.y = strongself.frame.height
            }
        } else {
            UIView.animate(withDuration: animateTime, animations: {
                guard let strongself = weakself else {
                    return
                }
                weakself?.cell2.frame.origin.y = -strongself.frame.height
                weakself?.cell1.frame.origin.y = 0
            }) { (isfinish) in
                guard let strongself = weakself else {
                    return
                }
                weakself?.flag = 0
                weakself?.cell2.frame.origin.y = strongself.frame.height
                
            }
        }
    }
    
    @objc func tapAction() {
        guard let selectIndex = nowShowNode?.index else {
            return
        }
        clickClosure?(selectIndex)
    }
}
