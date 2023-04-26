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
        //let width: CGFloat = 100
        //let height: CGFloat = 100
        
        //let viewRect = CGRect(x: round(bounds.size.width - width) / 3, y: round(bounds.size.height - height) / 3, width: width, height: height)
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100), radius: 200, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        UIColor(red: 43, green: 101, blue: 236, alpha: 1).setFill()
        UIColor(red: 0, green: 0, blue: 0, alpha: 0).setStroke()

        circle.fill()
        circle.stroke()
        
        guard let image = UIImage(systemName: "backpack.fill")?.withTintColor(.white) else { return }
        
        image.draw(in: CGRect(x: center.x - 15, y: center.y - 30, width: 30, height: 30))
        
        
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
