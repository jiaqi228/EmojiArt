//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Huang Jiaqi on 2019/07/14.
//  Copyright © 2019 Huang Jiaqi. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {

    var backgroundImage: UIImage? {
        didSet{
            // We have to write this line of code to redraw the view after backgroundImage has been changed. (= calling draw(_:) function)
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }

}
