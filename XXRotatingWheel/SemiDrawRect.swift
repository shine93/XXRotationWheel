//
//  SemiDrawRect.swift
//  XXRotatingWheel
//
//  Created by 人人 on 2018/6/15.
//  Copyright © 2018年 人人. All rights reserved.
//

import UIKit

class SemiDrawRect: UIView {
    
    var currentLotsRadian : CGFloat?
    var currentLots = 0.5
    let needleLayer = CALayer()
    
    
    let ScreenW = UIScreen.main.bounds.width
    let ScreenH = UIScreen.main.bounds.height
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        drawSemicicle()
    }
    
    func drawSemicicle() -> Void {
        
        let centerPoint = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height)
        let startA = 0
        let endA = Double.pi
//        let midA = -Double.pi  + currentLots * Double.pi
        
        
        let radius = self.bounds.width * 0.5
        
        let semiCicle = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(startA), endAngle: CGFloat(endA), clockwise: false)
        semiCicle.lineWidth = 2
        semiCicle.lineCapStyle = .round
        UIColor.red.set()
        semiCicle.stroke()
        
    }
    
    func show() -> Void {
        
        setupUI()
    
    }
    
    // first show
    func setupUI() -> Void {
        self.isOpaque = false;// opaque：不透明的
        self.contentMode = .redraw;
        
        currentLotsRadian = CGFloat(Double.pi * currentLots + (-Double.pi/2))
        
        // set up needleLayer
        needleLayer.anchorPoint = CGPoint(x: 0.5, y: 1155/1300.0);
        // 锚点位置
        needleLayer.position = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height )
        needleLayer.bounds = CGRect(x: 0, y: 0, width: 29, height: 130)
        needleLayer.contents = UIImage.init(named: "zhizhen")?.cgImage
        
        layer.addSublayer(needleLayer)
        needleLayer.transform = CATransform3DMakeRotation(currentLotsRadian!, 0, 0, 1)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(handleTapGes(gesture:)))
        self.addGestureRecognizer(tapGes)
        
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(handlePanGes(panGes:)))
        self.addGestureRecognizer(panGes)
        
        
        
    }
    
    @objc func handlePanGes(panGes: UIPanGestureRecognizer) -> Void {
        
        
        if panGes.state == .began {
            print("pan gesture began")
        }else if panGes.state == .changed {
            let currentPosition = panGes.location(in: self)
            changeNeedlePosion(currentPosition: currentPosition)
            
        }else if panGes.state == .ended {
            let currentPosition = panGes.location(in: self)
            changeNeedlePosion(currentPosition: currentPosition)
            
        }
    }
    
    @objc func handleTapGes(gesture: UITapGestureRecognizer) -> Void {
        let currentPosition = gesture.location(in: self)
        
        changeNeedlePosion(currentPosition: currentPosition)
        
        
    }
    
    func changeNeedlePosion(currentPosition: CGPoint) -> Void {
        currentLotsRadian = calculateRadian(pos: currentPosition)
        
        self.setNeedsDisplay()
        
        needleAnimation(currentLotsRadian: currentLotsRadian!)
    }
    
    func calculateRadian(pos: CGPoint) -> CGFloat {
        let circleCenter_X = self.bounds.width * 0.5
        let circleCenter_Y = self.bounds.height
        
        
        if (pos.x == circleCenter_X) {
            return 0;
        }
        if (pos.y > circleCenter_Y  && pos.x <= circleCenter_X) {
            return CGFloat(-Double.pi/2);
        }
        if (pos.y > circleCenter_Y  && pos.x > circleCenter_X) {
            return CGFloat(Double.pi/2);
        }
        
        let  x_space = pos.x - circleCenter_X;
        let y_space = circleCenter_Y - pos.y;
        let r_space = sqrt(x_space * x_space + y_space * y_space);
        
        let result = CGFloat(Double.pi/2) -  CGFloat(acos(x_space/r_space));
        
        //    NSLog(@"x_space: %f, y_space: %f,  r_space: %f", x_space,y_space,r_space);
        //    NSLog(@"result:------- %f", result);
        
        return result;
        
    }
    
    func needleAnimation(currentLotsRadian: CGFloat) -> Void {
        // needle animation
        CATransaction.begin()
        CATransaction.disableActions()
        needleLayer.transform = CATransform3DMakeRotation(currentLotsRadian, 0, 0, 1)
        CATransaction.commit()
    }

}
