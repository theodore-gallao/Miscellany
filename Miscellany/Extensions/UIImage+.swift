//
//  UIImage+.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func image(from color: UIColor?) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color?.cgColor ?? UIColor.clear.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

//    func circularImage(size: CGSize, borderColor: UIColor) -> UIImage? {
//        let newSize = size
//
//        let minEdge = min(newSize.height, newSize.width)
//        let size = CGSize(width: minEdge, height: minEdge)
//
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        let context = UIGraphicsGetCurrentContext()
//
//        self.draw(in: CGRect(origin: CGPoint.zero, size: size), blendMode: .copy, alpha: 1.0)
//
//        context?.setBlendMode(CGBlendMode.copy)
//        context?.setFillColor(UIColor.clear.cgColor)
//
//        let rectPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
//        let circlePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
//        rectPath.append(circlePath)
//        rectPath.usesEvenOddFillRule = true
//        rectPath.fill()
//
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return result
//    }
    
    var isPortrait:  Bool    { size.height > size.width }
    var isLandscape: Bool    { size.width > size.height }
    var breadth:     CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
    var breadthRect: CGRect  { .init(origin: .zero, size: breadthSize) }
    
    var circleMasked: UIImage? {
        guard let cgImage = cgImage?
            .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
                                              y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                size: breadthSize)) else { return nil }
        return UIGraphicsImageRenderer(size: breadthSize,
                                       format: imageRendererFormat).image { _ in
            UIBezierPath(ovalIn: breadthRect).addClip()
            UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
            .draw(in: .init(origin: .zero, size: breadthSize))
        }
    }
}
