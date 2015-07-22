//
//  GraphView.swift
//  Calculator
//
//  Created by Malcolm Macleod on 22/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView
{
    @IBInspectable
    var color: UIColor = UIColor.blackColor()
    {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var scale: CGFloat = CGFloat(1)
    {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var x : Int = 0
        {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var y : Int = 0
        {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let drawer = AxesDrawer(color: self.color, contentScaleFactor: self.scale)
        
        let xpoint = self.bounds.width / 2
        let ypoint = self.bounds.height / 2
        let center = CGPoint(x: xpoint, y: ypoint)
        
        drawer.drawAxesInRect(self.bounds, origin: center, pointsPerUnit: self.scale)
    }
    

}
