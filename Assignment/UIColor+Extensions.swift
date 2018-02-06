//
//  UIColor+Extensions.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(_ r: Double, _ g: Double, _ b: Double) {
    self.init(red: CGFloat(r/255),
              green: CGFloat(g/255),
              blue: CGFloat(b/255),
              alpha: 1.0)
  }
  
  convenience init(_ r: Double, _ g: Double, _ b: Double, _ a: Double) {
    self.init(red: CGFloat(r/255),
              green: CGFloat(g/255),
              blue: CGFloat(b/255),
              alpha: CGFloat(a))
  }
  
  
  class func rgb(_ r: Double, _ g: Double, _ b: Double) -> UIColor {
    return UIColor(r, g, b)
  }
  
  class func rgb(_ r: Double, _ g: Double, _ b: Double, _ a: Double) -> UIColor {
    return UIColor(r, g, b, a)
  }
}
