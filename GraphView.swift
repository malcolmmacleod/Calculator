//
//  GraphView.swift
//  Calculator
//
//  Created by Malcolm Macleod on 22/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import UIKit

protocol GraphViewDataSource : class {
    func resultsForFunction(sender: GraphView, xValues: [Double]) -> [Double]
}

@IBDesignable
class GraphView: UIView
{
    weak var dataSource: GraphViewDataSource?
    
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
    
    var origin: CGPoint = CGPoint(x: 0,y: 0)
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
        
        drawer.drawAxesInRect(self.bounds, origin: origin, pointsPerUnit: self.scale)
    }
}
