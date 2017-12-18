//
//  InstantPanGestureRecoginzer.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 11/25/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class InstantPanGestureRecoginzer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        NSLog("touchesBegan")
        if self.state == UIGestureRecognizerState.began {
            return
        }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizerState.began
    }
    
}
