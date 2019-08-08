//
//  UIView.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundSpecificCorner(corners: UIRectCorner, radius: CGFloat) {
        
        let bounds = self.bounds
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        
        layer.mask = maskLayer
        
        let frameLayer = CAShapeLayer()
        frameLayer.frame = bounds
        frameLayer.path = maskPath.cgPath
        frameLayer.strokeColor = UIColor.red.cgColor
        frameLayer.fillColor = nil
        
        layer.addSublayer(frameLayer)
    }
    
    func rounded(cornerRadius: CGFloat = 5.0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    
    func roundWithBorder(radius: CGFloat = 10, borderWidth: CGFloat = 1, borderColor: CGColor = UIColor.white.cgColor){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
        // border
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
    }
}
