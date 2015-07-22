//
//  GraphViewController.swift
//  Calculator
//
//  Created by Malcolm Macleod on 22/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, UIScrollViewDelegate, GraphViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
        {
        didSet {
            scrollView.contentSize = graph.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.2
            scrollView.maximumZoomScale = 5.0
        }
    }
    
    @IBOutlet weak var graphName: UILabel!
    
    @IBOutlet weak var graph: GraphView!
    
    var graphTitle : String = "Graph title"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        self.graph.origin = CGPoint(x: self.graph.bounds.size.width / 2, y: self.graph.bounds.size.height / 2)
        self.scrollView.addSubview(self.graph)
        self.graphName.text = self.graphTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return graph
    }
    
    @IBAction func moveGraph(sender: UIPanGestureRecognizer) {
        let newPoint = sender.translationInView(graph)
        println("\(newPoint)")
        
        graph.origin = CGPoint(x: graph.origin.x + (newPoint.x / 10), y: graph.origin.y + (newPoint.y / 10))
        
    }
    
    
    @IBAction func moveGraphTo(sender: UITapGestureRecognizer) {
        
        if sender.state == .Ended {
            // handling code
            let newPoint = sender.locationInView(graph)
            
            println("\(newPoint)")
            
            graph.origin = CGPoint(x: newPoint.x , y: newPoint.y )
        }
    }
    
    func resultsForFunction(sender: GraphView, xValues: [Double]) -> [Double] {
        return [0.0]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
