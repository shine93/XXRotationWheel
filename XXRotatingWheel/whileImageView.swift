//
//  whileImageView.swift
//  XXRotatingWheel
//
//  Created by 人人 on 2018/6/15.
//  Copyright © 2018年 人人. All rights reserved.
//




import UIKit


class whileImageView: UIImageView {
    let ScreenW = UIScreen.main.bounds.width
    let ScreenH = UIScreen.main.bounds.height
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
        
        configureUI()
    }
    
    
    func configureUI() -> Void {
//        layer.cornerRadius = 100
//        layer.masksToBounds = true
   
        let semiCicle = SemiDrawRect(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        semiCicle.backgroundColor = UIColor.clear
        addSubview(semiCicle)
        semiCicle.currentLots = 0.3
        semiCicle.show()
        
        
    }
    
    

}
