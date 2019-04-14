//
//  Indecator.swift
//  test
//
//  Created by ashraf on 4/14/19.
//  Copyright © 2019 com.AbdoAmin. All rights reserved.
//

import Foundation
import UIKit

open class Spinner {
    
    internal static var spinner: UIActivityIndicatorView?
    open static var style: UIActivityIndicatorViewStyle = .whiteLarge
    open static var baseBackColor = UIColor.black.withAlphaComponent(0.5)
    open static var baseColor = UIColor.red
    
    open static func start(style: UIActivityIndicatorViewStyle = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.activityIndicatorViewStyle = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    open static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
    @objc open static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}
