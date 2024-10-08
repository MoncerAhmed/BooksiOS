//
//  UITabBar+SectionIndicator.swift
//  Books
//
//  Created by Ahmed Moncer on 04/09/2024.
//

import UIKit

extension UIImage {

    func createSelectionIndicator(
        color: UIColor,
        size: CGSize,
        lineWidth: CGFloat
    ) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
