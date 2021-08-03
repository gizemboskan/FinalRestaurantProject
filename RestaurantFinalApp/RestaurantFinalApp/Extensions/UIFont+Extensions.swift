//
//  UIFont+Extensions.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 3.08.2021.
//

import Foundation
import UIKit

extension UIFont {
    fileprivate class func getFont(_ name: String, size: CGFloat) -> UIFont {
        systemFont(ofSize: size)
        //return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static var MateRegular12: UIFont { get { return getFont("Mate", size: 12) } }
    public static var MateRegular14: UIFont { get { return getFont("Mate", size: 14) } }
    public static var MateRegular16: UIFont { get { return getFont("Mate", size: 16) } }
    public static var MateRegular18: UIFont { get { return getFont("Mate", size: 18) } }
    public static var MateRegular20: UIFont { get { return getFont("Mate", size: 20) } }
    
    
    public static var MateBold12: UIFont { get { return getFont("Mate-Bold", size: 12) } }
    public static var MateBold14: UIFont { get { return getFont("Mate-Bold", size: 14) } }
    public static var MateBold16: UIFont { get { return getFont("Mate-Bold", size: 16) } }
    public static var MateBold18: UIFont { get { return getFont("Mate-Bold", size: 18) } }
    public static var MateBold20: UIFont { get { return getFont("Mate-Bold", size: 20) } }
    
    public static var MateExtraBold12: UIFont { get { return getFont("MateExtraBold", size: 12) } }
    public static var MateExtraBold14: UIFont { get { return getFont("MateExtraBold", size: 14) } }
    public static var MateExtraBold16: UIFont { get { return getFont("MateExtraBold", size: 16) } }
    public static var MateExtraBold18: UIFont { get { return getFont("MateExtraBold", size: 18) } }
    public static var MateExtraBold20: UIFont { get { return getFont("MateExtraBold", size: 20) } }
    public static var MateExtraBold24: UIFont { get { return getFont("MateExtraBold", size: 24) } }
    public static var MateExtraBold32: UIFont { get { return getFont("MateExtraBold", size: 32) } }
    
    public static var MateLight12: UIFont { get { return getFont("Mate-Light", size: 12) } }
    public static var MateLight14: UIFont { get { return getFont("Mate-Light", size: 14) } }
    public static var MateLight16: UIFont { get { return getFont("Mate-Light", size: 16) } }
    public static var MateLight18: UIFont { get { return getFont("Mate-Light", size: 18) } }
    public static var MateLight20: UIFont { get { return getFont("Mate-Light", size: 20) } }
}
