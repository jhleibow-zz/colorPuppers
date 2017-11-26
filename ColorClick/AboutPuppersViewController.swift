//
//  AboutPuppersViewController.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 7/11/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class AboutPuppersViewController: UIViewController, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate {

    
    //MARK: - Properties
    
    @IBOutlet weak var pupperInfoTitleLabel: UILabel!
    @IBOutlet weak var allThePuppersLabel: UILabel!
    @IBOutlet weak var homeForGoodDogTitleLabel: UILabel!
    @IBOutlet weak var njLabel: UILabel!
    @IBOutlet weak var homeWebsiteLabel: UILabel!
    @IBOutlet weak var seattleHumaneTitleLabel: UILabel!
    @IBOutlet weak var waLabel: UILabel!
    @IBOutlet weak var humaneWebsiteLabel: UILabel!
    @IBOutlet weak var homeForGoodButton: UIButton!
    @IBOutlet weak var seattleHumaneButton: UIButton!
//    @IBOutlet weak var goBackButton: UIButton!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!

    var percentInteractionController: UIPercentDrivenInteractiveTransition?
    
    @IBAction func homeForGoodButtonTap(_ sender: UIButton) {
        if let url = URL(string: "https://homeforgooddogs.org/") {
            UIApplication.shared.open(url)
        }
        
    }
    
    @IBAction func seattleHumaneButtonTap(_ sender: UIButton) {
        if let url = URL(string: "http://www.seattlehumane.org/") {
            UIApplication.shared.open(url)
        }
    }
    
//    @IBAction func tapGoBackButton(_ sender: UIButton) {
//        goBack()
//    }
    
    
    //Object that is passed around all view controllers that contains current game state
    var gameSession: GameSession!
    
    var sendingViewControllerName: String!
    
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fixFontSizes()
        loadImages()
        
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(goBack));
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//        view.addGestureRecognizer(swipeLeft);
//
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(goBack));
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.right
        
//        view.addGestureRecognizer(swipeRight);
        // Do any additional setup after loading the view.
        
        let panRight = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_ :)))
        panRight.delegate = self
        view.addGestureRecognizer(panRight)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private Methods
    
    private func fixFontSizes() {
        
        
        Utilities.updateLabelFont(label: allThePuppersLabel, fontName: GamePlayParameters.Fonts.gameFontName)
        Utilities.updateLabelFont(label: homeForGoodDogTitleLabel, fontName: GamePlayParameters.Fonts.gameFontNameBold)
        Utilities.updateLabelFont(label: njLabel, fontName: GamePlayParameters.Fonts.gameFontName)
        Utilities.updateLabelFont(label: homeWebsiteLabel, fontName: GamePlayParameters.Fonts.gameFontNameBold)
        Utilities.updateLabelFont(label: seattleHumaneTitleLabel, fontName: GamePlayParameters.Fonts.gameFontNameBold)
        Utilities.updateLabelFont(label: waLabel, fontName: GamePlayParameters.Fonts.gameFontName)
        Utilities.updateLabelFont(label: humaneWebsiteLabel, fontName: GamePlayParameters.Fonts.gameFontNameBold)
        
        
        Utilities.updateLabelFontAttributed(label: pupperInfoTitleLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center, characterSpacing: 5.0, scaleDownFromHeightFactor: 2.7)
        

     
        
    }
    @objc func panGesture(_ gesture: UIPanGestureRecognizer) {
        
        
        
        if sendingViewControllerName == "settingsViewControllerID" {
            
            let translation = gesture.translation(in: gesture.view)
            let percent = translation.x / gesture.view!.frame.size.width
            
            if gesture.state == .began {
                
                let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: sendingViewControllerName) as! SettingsViewController
                nextViewController.gameSession = gameSession
                
                percentInteractionController = UIPercentDrivenInteractiveTransition()
                nextViewController.percentInteractionController = percentInteractionController
                
                nextViewController.transitioningDelegate = self;
                self.present(nextViewController, animated: true, completion: nil)
            } else if gesture.state == .changed {
                percentInteractionController!.update(percent)
            } else if gesture.state == .ended || gesture.state == .cancelled {
                let velocity = gesture.velocity(in: gesture.view)
                
                percentInteractionController?.completionSpeed = 0.99
                if (percent > 0.5 && velocity.x == 0) || (velocity.x > 0) {
                    percentInteractionController?.finish()
                } else {
                    
                    percentInteractionController?.cancel()
                }
                percentInteractionController = nil
            }
            
            
            
        } else {
            let translation = gesture.translation(in: gesture.view)
            let percent = translation.x / gesture.view!.frame.size.width
            
            if gesture.state == .began {
                
                let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: sendingViewControllerName) as! GameStartPageViewController
                nextViewController.gameSession = gameSession
                
                percentInteractionController = UIPercentDrivenInteractiveTransition()
                nextViewController.percentInteractionController = percentInteractionController
                
                nextViewController.transitioningDelegate = self;
                self.present(nextViewController, animated: true, completion: nil)
            } else if gesture.state == .changed {
                percentInteractionController!.update(percent)
            } else if gesture.state == .ended || gesture.state == .cancelled {
                let velocity = gesture.velocity(in: gesture.view)
                
                percentInteractionController?.completionSpeed = 0.99
                if (percent > 0.5 && velocity.x == 0) || (velocity.x > 0) {
                    percentInteractionController?.finish()
                } else {
                    
                    percentInteractionController?.cancel()
                }
                percentInteractionController = nil
            }
        }
    }
    
    //navigate to prior page
    @objc func goBack() {
        if sendingViewControllerName == "settingsViewControllerID" {
            let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: sendingViewControllerName) as! SettingsViewController
            nextViewController.gameSession = gameSession
            nextViewController.transitioningDelegate = self;
            self.present(nextViewController, animated: true, completion: nil)
        } else {
            let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: sendingViewControllerName) as! GameStartPageViewController
            nextViewController.gameSession = gameSession
            nextViewController.transitioningDelegate = self;
            self.present(nextViewController, animated: true, completion: nil)
        }
        
        
    }
    
    private func loadImages() {
        let image1Name = Utilities.getHappyDogPhotoName()
        var image2Name = Utilities.getHappyDogPhotoName()
        var image3Name = Utilities.getHappyDogPhotoName()
        
        while image2Name == image1Name {
            image2Name = Utilities.getHappyDogPhotoName()
        }
        
        while image3Name == image1Name || image3Name == image2Name{
            image3Name = Utilities.getHappyDogPhotoName()
        }
        
        
        image1.image = UIImage(named: image1Name)
        image2.image = UIImage(named: image2Name)
        image3.image = UIImage(named: image3Name)
    }
    
    //MARK: - UIViewControllerTransitioningDelegate methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return gameSession
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentInteractionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    

}
