//
//  SKTipsRollView.swift
//  shen
//
//  Created by 沈凯强 on 2021/01/01.
//  Copyright © 2021 mn. All rights reserved.
//

import UIKit
/// 上下滚动的公告栏
public class SKTipsRollView: UIView {

    private var imgV:UIImageView!
    private var tipsLab:UILabel!
    private var rollV:SKRollView!
    
    public var imgName:String? {
        willSet {
            guard let imgn = newValue, !imgn.isEmpty else {
                return
            }
            imgV.image = UIImage.init(named: imgn)
            layoutSubviews()
        }
    }
    public var rightTextColor:UIColor? {
        willSet {
            rollV.textColor = newValue
            rollV.textColor = newValue
        }
    }
    public var rightTextFont:UIFont? {
        willSet {
            rollV.textFont = newValue
        }
    }
    public var textFont:UIFont? {
        willSet {
            tipsLab.font = newValue
        }
    }
    public var clickClosure:((_ index:Int)->Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
                
        imgV = UIImageView.init()
        addSubview(imgV)
        
        tipsLab = UILabel.init()
        addSubview(tipsLab)
        tipsLab.font = UIFont.systemFont(ofSize: 15)
        tipsLab.text = "公告:"
        
        rollV = SKRollView.init()
        addSubview(rollV)
        weak var weakself = self
        rollV.clickClosure = { index in
            weakself?.clickClosure?(index)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var tipsX:CGFloat = 0
        
        if let _ = imgV.image {
            imgV.frame = CGRect.init(x: 0, y: 0, width: 15, height: 15)
            imgV.center.y = frame.height/2
            tipsX = imgV.frame.maxX+5
        } else {
            imgV.frame = CGRect.zero
        }
        
        tipsLab.frame.origin = CGPoint.init(x: tipsX, y: 0)
        tipsLab.sizeToFit()
        tipsLab.center.y = frame.height/2
        
        rollV.frame = CGRect.init(x: tipsLab.frame.maxX+5, y: 0, width: frame.width-tipsLab.frame.maxX, height: frame.height)
    }
    
    public func reloadData(titleArr:[String]) {
        rollV.reloadData(titleArr: titleArr)
    }
    
}
