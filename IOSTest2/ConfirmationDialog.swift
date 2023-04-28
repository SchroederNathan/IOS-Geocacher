//
//  ConfirmationDialog.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-26.
//

import UIKit

class ConfirmationDialog: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        let circle = UIBezierPath(arcCenter: CGPoint(x: center.x, y: center.y - 15), radius: 50, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        UIColor(red: 43/255, green: 101/255, blue: 236/255, alpha: 1).setFill()
        UIColor(red: 0, green: 0/255, blue: 0, alpha: 1).setStroke()

        circle.fill()
        
        circle.lineWidth = 3
        circle.stroke()
        
        
        guard let image = UIImage(systemName: "backpack.fill")?.withTintColor(.white) else { return }
        
        image.draw(in: CGRect(x: center.x - 37, y: center.y - 55, width: 75, height: 75))

        
    }
    
    func showDialog(){
        alpha = 0
        
//        UIView.animate(withDuration: 1.0, delay: 0,options: .curveEaseInOut ,animations: {
//            self.alpha = 1
//            self.transform = CGAffineTransform(scaleX: 2, y: 2)
//        })
//
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
    }
  


}
