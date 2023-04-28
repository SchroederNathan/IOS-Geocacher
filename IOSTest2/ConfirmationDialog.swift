//
//  ConfirmationDialog.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-26.
//

import UIKit

class ConfirmationDialog: UIView {

    // Drawing code
    override func draw(_ rect: CGRect) {
        
        
        // Create circle
        let circle = UIBezierPath(arcCenter: CGPoint(x: center.x, y: center.y - 15), radius: 50, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // Change color of fill and stroke
        UIColor(red: 43/255, green: 101/255, blue: 236/255, alpha: 1).setFill()
        UIColor(red: 0, green: 0/255, blue: 0, alpha: 1).setStroke()

        // Fill the circle with the set fill color above
        circle.fill()
        
        // Adds stroke to circle
        circle.lineWidth = 3
        circle.stroke()
        
        // Create image with the backpack SF Symbol
        guard let image = UIImage(systemName: "backpack.fill")?.withTintColor(.white) else { return }
        
        // Draw image
        image.draw(in: CGRect(x: center.x - 37, y: center.y - 55, width: 75, height: 75))
    }
    
    // Animate the drawing
    func showDialog(){
        alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
    }
  


}
