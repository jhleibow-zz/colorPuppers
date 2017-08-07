//
//  SquareButton.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 5/30/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

@IBDesignable class SquareButton: UIButton {

    //MARK: - Properties
    
    var squareTextLabel: UILabel?
    var squareObjectImage: UIImage?
    var squareSideSize: Double?
    
    
    //MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    

    
    //MARK: - Private Methods
    
    func setupButton(squareBackgroundColor: GameColor, gameObject: GameObject?, gameWord: GameColor?, gameFontColor: GameColor?) {
    
        squareSideSize = Double(self.frame.height)
        let buffer = squareSideSize!/6
        
        var textRect: CGRect
        var objectRect: CGRect
        
//        if gameWord != nil && gameObject != nil { //word and object case
//            textRect = CGRect(x: buffer, y: buffer, width: squareSideSize! - (buffer * 2), height: squareSideSize!/3) // - (buffer * 2))
//            objectRect = CGRect(x: buffer, y: squareSideSize!/3 + buffer, width: squareSideSize! - (buffer * 2), height: squareSideSize! * (2/3) - (buffer * 2))
//        } else { //word or object case
//            textRect = CGRect(x: buffer, y: buffer, width: squareSideSize! - (buffer * 2), height: squareSideSize! - (buffer * 2))
//            objectRect = CGRect(x: buffer, y: buffer, width: squareSideSize! - (buffer * 2), height: squareSideSize! - (buffer * 2))
//        }

        if gameWord != nil && gameObject != nil { //word and object case
            textRect = CGRect(x: buffer, y: buffer * 0.7, width: squareSideSize! - (buffer * 2), height: squareSideSize!/4) // - (buffer * 2))
            objectRect = CGRect(x: buffer, y: squareSideSize!/3.5 + buffer, width: squareSideSize! - (buffer * 2), height: squareSideSize! * (3/4) - (buffer * 2))
        } else { //word or object case
            textRect = CGRect(x: buffer, y: buffer, width: squareSideSize! - (buffer * 2), height: squareSideSize! - (buffer * 2))
            objectRect = CGRect(x: buffer, y: buffer, width: squareSideSize! - (buffer * 2), height: squareSideSize! - (buffer * 2))
        }
        
        //Reset square buttons
        resetSquareButtons()
        
        
        //Update background color of SquareButtons
        self.backgroundColor = squareBackgroundColor.color
        
        //Update object of Square Buttons
        if gameObject != nil {
            // add image
            let imageName = "\(gameObject!.naturalColor!.name)_\(gameObject!.name)"
            squareObjectImage = UIImage(named: imageName)
            let myFrameView = UIImageView(frame: objectRect)
            myFrameView.image = squareObjectImage
            myFrameView.contentMode = .scaleAspectFit
            self.addSubview(myFrameView)
        }
        
        //Update word of Square Buttons
        if gameWord != nil {
            
            //squareTextLabel = UILabel(frame: textLabelRect)
            squareTextLabel = UILabel(frame: textRect)

            //set word wrapping
            squareTextLabel!.numberOfLines = 1
            squareTextLabel!.adjustsFontSizeToFitWidth = true
            
            //set font
            //squareTextLabel!.font = UIFont.boldSystemFont(ofSize: CGFloat(squareSideSize!/3.5))
            squareTextLabel!.font = UIFont(name: GamePlayParameters.Fonts.gameFontName, size: CGFloat(squareSideSize!/GamePlayParameters.Fonts.squareSideSizeRatioToFontSize))
            
            //set font color
            squareTextLabel!.textColor = gameFontColor!.fontColor
                        
            //center font
            squareTextLabel!.textAlignment = .center
            
            squareTextLabel!.text = gameWord!.name
            squareTextLabel!.contentMode = .center
            self.addSubview(squareTextLabel!)
            
            
        }
        
        
    }
    
    //destroy all subviews
    private func resetSquareButtons() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        if squareTextLabel != nil {
            squareTextLabel!.text = ""
        }
    }

    
}

//
//        //squareTextLabel = UILabel(frame: textLabelRect)
//        squareTextLabel = UILabel(frame: textRect)
//
//
//        //squareTextLabel!.backgroundColor = .white
//
//        //set word wrapping
//        squareTextLabel!.numberOfLines = 3
//        squareTextLabel!.lineBreakMode = .byTruncatingTail
//        squareTextLabel!.adjustsFontSizeToFitWidth = true
//
//        //set font
//        squareTextLabel!.font = UIFont.systemFont(ofSize: CGFloat(squareSideSize!/8))
//
//        //center font
//        squareTextLabel!.textAlignment = .center
//
//        squareTextLabel!.text = "Yellow"
//        squareTextLabel!.contentMode = .center
//        self.addSubview(squareTextLabel!)
//
//
//        // add image
//        squareObjectImage = UIImage(named: "yellowBanana")
//        let myFrameView = UIImageView(frame: imageRect)
//        myFrameView.image = squareObjectImage
//        myFrameView.contentMode = .scaleAspectFit
//        self.addSubview(myFrameView)

//    init(rightAnswer: Bool, squareColor: UIColor, fontColor: UIColor, squareText: String?, overlayImage: UIImage?) {
//
//
//
//        self.rightAnswer = rightAnswer
//        self.squareColor = squareColor
//        self.fontColor = fontColor
//        self.squareText = squareText
//        self.overlayImage = overlayImage
//        //createCompositeImage()
//    }


// Only override draw() if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        let path = UIBezierPath(rect: rect)
//        let fillColor: UIColor = UIColor.brown
//        fillColor.setFill()
//        path.fill()
//
//    }

//MARK: Private Methods

//    private func createCompositeImage() {
//        //let rect = CGRect(x: 0, y: 0, width: twoxImageSize, height: twoxImageSize)
//        //let context = CGContext(data: nil, width: twoxImageSize, height: twoxImageSize, bitsPerComponent: <#T##Int#>, bytesPerRow: 0, space: CGColorSpace., bitmapInfo: <#T##UInt32#>)
//
//    }

//let twoxImageSize = 200

//    var rightAnswer: Bool
//    var squareColor: UIColor
//    var fontColor: UIColor
//    var squareText: String?
//    var overlayImage: UIImage?


//        //Define size of square image context
//        let squareSideSize = 375
//        let squareSize = CGSize(width: squareSideSize, height: squareSideSize)
//
//        //Begin image context
//        UIGraphicsBeginImageContextWithOptions(squareSize, false, 0.0)
//        //let context = UIGraphicsGetCurrentContext()
//
//        //Fill background with color
//        let myFillColor = UIColor.purple
//        myFillColor.setFill()
//        let backgroundPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: squareSideSize, height: squareSideSize))
//        backgroundPath.fill()

//        //Add Object image
//        let myObjectImage = UIImage(named: "yellowBanana")
//        let objectRect = CGRect(x: 0, y: squareSideSize/2, width: squareSideSize, height: squareSideSize/2)
//        myObjectImage!.draw(in: objectRect)
//
//
//        //Add text
//        let textRect = CGRect(x: 0, y: 0, width: squareSideSize, height: squareSideSize/2)
//        let text = "yellow"
//        let font = UIFont(name: "Arial", size: 20)
//        let myTextColor = UIColor.red
//        let textStyle = NSMutableParagraphStyle()
//        textStyle.alignment = .center
//
//        let textAttributes = [
//            NSFontAttributeName: font!,
//            NSForegroundColorAttributeName: myTextColor,
//            NSParagraphStyleAttributeName: textStyle
//            ] as [String : Any]
//        text.draw(in: textRect, withAttributes: textAttributes)
//
//        //End image context
//        let squareImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//
//        self.setImage(squareImage, for: .normal)
//    }
