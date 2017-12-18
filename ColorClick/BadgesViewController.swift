//
//  BadgesViewController.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 8/7/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class BadgesViewController: UIViewController, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate {

    
//    @IBOutlet weak var transparentGoBackButton: UIButton!

    @IBOutlet weak var badgesLabel: UILabel!
    
    @IBOutlet weak var badgeEasyLabel: UILabel!
    @IBOutlet weak var badgeMediumLabel: UILabel!
    @IBOutlet weak var badgeHardLabel: UILabel!
    
    @IBOutlet weak var badgeeasy1: UIImageView!
    @IBOutlet weak var badgemedium1: UIImageView!
    @IBOutlet weak var badgehard1: UIImageView!
    
    @IBOutlet weak var badgeeasy2: UIImageView!
    @IBOutlet weak var badgemedium2: UIImageView!
    @IBOutlet weak var badgehard2: UIImageView!
    
    @IBOutlet weak var badgeeasy3: UIImageView!
    @IBOutlet weak var badgemedium3: UIImageView!
    @IBOutlet weak var badgehard3: UIImageView!
    
    @IBOutlet weak var badgeeasy4: UIImageView!
    @IBOutlet weak var badgemedium4: UIImageView!
    @IBOutlet weak var badgehard4: UIImageView!
    
//    @IBAction func transparentGoBackButtonTap(_ sender: UIButton) {
//        goBack()
//    }
    
    var percentInteractionController: UIPercentDrivenInteractiveTransition?
    
    
    //Object that is passed around all view controllers that contains current game state
    var gameSession: GameSession!
    
    var sendingViewControllerName: String!
    
    var preloadSettingsViewController: SettingsViewController?
    var preloadGameStartPageViewController: GameStartPageViewController?
    
    private var initialTouchLocation: CGPoint = CGPoint.zero
    private var priorTouchLocation: CGPoint = CGPoint.zero
    
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(goBack));
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//        view.addGestureRecognizer(swipeLeft);
//
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(goBack));
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.right
//        view.addGestureRecognizer(swipeRight);
        
//        let panRight = InstantPanGestureRecoginzer(target: self, action: #selector(panGesture(_ :)))
//        panRight.delegate = self
//        view.addGestureRecognizer(panRight)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(panGesture(_ :)))
        longPress.delegate = self
        longPress.allowableMovement = CGFloat.infinity
        longPress.minimumPressDuration = 0.0
        view.addGestureRecognizer(longPress)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        loadBadges()
        
        Utilities.updateLabelFontAttributed(label: badgesLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center, characterSpacing: 5.0, scaleDownFromHeightFactor: 2.7)
        
        Utilities.updateLabelFontAttributed(label: badgeEasyLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center, characterSpacing: 3.0, scaleDownFromHeightFactor: 4.1)
        
        Utilities.updateLabelFontAttributed(label: badgeMediumLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center, characterSpacing: 3.0, scaleDownFromHeightFactor: 4.1)
        
        Utilities.updateLabelFontAttributed(label: badgeHardLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center, characterSpacing: 3.0, scaleDownFromHeightFactor: 4.1)
        
        if sendingViewControllerName == "settingsViewControllerID" {
            DispatchQueue.global(qos: .userInitiated).async {
                let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                self.preloadSettingsViewController = myStoryBoard.instantiateViewController(withIdentifier: self.sendingViewControllerName) as? SettingsViewController
                self.preloadSettingsViewController!.gameSession = self.gameSession
                
                self.percentInteractionController = UIPercentDrivenInteractiveTransition()
                self.preloadSettingsViewController!.percentInteractionController = self.percentInteractionController
                
                self.preloadSettingsViewController!.transitioningDelegate = self;
                
                
                let nextView = self.preloadSettingsViewController!.view
                NSLog(nextView.debugDescription)
            }
        
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                self.preloadGameStartPageViewController = myStoryBoard.instantiateViewController(withIdentifier: self.sendingViewControllerName) as? GameStartPageViewController
                self.preloadGameStartPageViewController!.gameSession = self.gameSession
                
                self.percentInteractionController = UIPercentDrivenInteractiveTransition()
                self.preloadGameStartPageViewController!.percentInteractionController = self.percentInteractionController
                
                self.preloadGameStartPageViewController!.transitioningDelegate = self;
                
                
                let nextView = self.preloadGameStartPageViewController!.view
                NSLog(nextView.debugDescription)
            }
            
            
        }
        
        
    }
    
    //deal with pan gesture
    @objc func panGesture(_ gesture: UILongPressGestureRecognizer) {

        
        
        if sendingViewControllerName == "settingsViewControllerID" {
            
//            let translation = gesture.translation(in: gesture.view)
            let location = gesture.location(in: gesture.view)
            let percent: CGFloat
            
            if initialTouchLocation.x == 0 && initialTouchLocation.y == 0 {
                percent = 0
            } else {
                percent = (initialTouchLocation.x - location.x) / gesture.view!.frame.size.width
            }
            
            
            
            if gesture.state == .began {
                priorTouchLocation = location
                initialTouchLocation = location
                NSLog("initialTouchLocation: \(initialTouchLocation.x)")
//                let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: sendingViewControllerName) as! SettingsViewController
//                nextViewController.gameSession = gameSession
//
//                percentInteractionController = UIPercentDrivenInteractiveTransition()
//                nextViewController.percentInteractionController = percentInteractionController
//
//                nextViewController.transitioningDelegate = self;
                self.present(preloadGameStartPageViewController!, animated: true, completion: nil)
            } else if gesture.state == .changed {
                percentInteractionController!.update(percent)
                priorTouchLocation = location
            } else if gesture.state == .ended || gesture.state == .cancelled {
                let velocity = location.x - priorTouchLocation.x
                
                initialTouchLocation = CGPoint.zero
                
                percentInteractionController?.completionSpeed = 0.99
                if (percent > 0.5 && velocity == 0) || (velocity > 0) {
                    percentInteractionController?.finish()
                } else {

                    percentInteractionController?.cancel()
                }
                percentInteractionController = nil
            }
            
            

        } else {
            let location = gesture.location(in: gesture.view)
            let percent: CGFloat
            
            if initialTouchLocation.x == 0 && initialTouchLocation.y == 0 {
                percent = 0
            } else {
                percent = (location.x + gesture.view!.frame.size.width - initialTouchLocation.x) / gesture.view!.frame.size.width
            }
            
            if gesture.state == .began {
                NSLog("in .began")
                priorTouchLocation = location
                initialTouchLocation = location
                NSLog("initialTouchLocation: \(initialTouchLocation.x)")
                let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: sendingViewControllerName) as! GameStartPageViewController
                nextViewController.gameSession = gameSession

                percentInteractionController = UIPercentDrivenInteractiveTransition()
                nextViewController.percentInteractionController = percentInteractionController

                nextViewController.transitioningDelegate = self;
                
                self.present(nextViewController, animated: true, completion: nil)
//                DispatchQueue.global(qos: .userInteractive).async {
//                    self.present(nextViewController, animated: true, completion: nil)
//                }
                
                
            } else if gesture.state == .changed {
                NSLog("in .changed with location: \(location.x + gesture.view!.frame.size.width) and percent: \(percent)")
                percentInteractionController!.update(percent)
                priorTouchLocation = location
            } else if gesture.state == .ended || gesture.state == .cancelled {
                let velocity = location.x - priorTouchLocation.x
                
                percentInteractionController?.completionSpeed = 0.99
                if (percent > 0.5 && velocity == 0) || (velocity > 0) {
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
    
    private func loadBadges() {
        
        
        if gameSession.highScoresAndSettings!.getEasyHighScore() >= GamePlayParameters.Badges.level1 {
            badgeeasy1.image = UIImage(named:"badgeeasy1")
            createDropShadow(badge: badgeeasy1)
        } else {
            badgeeasy1.image = UIImage(named:"badgeempty1")
        }
        
        if gameSession.highScoresAndSettings!.getEasyHighScore() >= GamePlayParameters.Badges.level2 {
            badgeeasy2.image = UIImage(named:"badgeeasy2")
            createDropShadow(badge: badgeeasy2)
        } else {
            badgeeasy2.image = UIImage(named:"badgeempty2")
        }
        
        if gameSession.highScoresAndSettings!.getEasyHighScore() >= GamePlayParameters.Badges.level3 {
            badgeeasy3.image = UIImage(named:"badgeeasy3")
            createDropShadow(badge: badgeeasy3)
        } else {
            badgeeasy3.image = UIImage(named:"badgeempty3")
        }
        
        if gameSession.highScoresAndSettings!.getEasyHighScore() >= GamePlayParameters.Badges.level4 {
            badgeeasy4.image = UIImage(named:"badgeeasy4")
            createDropShadow(badge: badgeeasy4)
        } else {
            badgeeasy4.image = UIImage(named:"badgeempty4")
        }
        
        
        
        if gameSession.highScoresAndSettings!.getMediumHighScore() >= GamePlayParameters.Badges.level1 {
            badgemedium1.image = UIImage(named:"badgemedium1")
            createDropShadow(badge: badgemedium1)
        } else {
            badgemedium1.image = UIImage(named:"badgeempty1")
        }
        
        if gameSession.highScoresAndSettings!.getMediumHighScore() >= GamePlayParameters.Badges.level2 {
            badgemedium2.image = UIImage(named:"badgemedium2")
            createDropShadow(badge: badgemedium2)
        } else {
            badgemedium2.image = UIImage(named:"badgeempty2")
        }
        
        if gameSession.highScoresAndSettings!.getMediumHighScore() >= GamePlayParameters.Badges.level3 {
            badgemedium3.image = UIImage(named:"badgemedium3")
            createDropShadow(badge: badgemedium3)
        } else {
            badgemedium3.image = UIImage(named:"badgeempty3")
        }
        
        if gameSession.highScoresAndSettings!.getMediumHighScore() >= GamePlayParameters.Badges.level4 {
            badgemedium4.image = UIImage(named:"badgemedium4")
            createDropShadow(badge: badgemedium4)
        } else {
            badgemedium4.image = UIImage(named:"badgeempty4")
        }
        
        
        if gameSession.highScoresAndSettings!.getHardHighScore() >= GamePlayParameters.Badges.level1 {
            badgehard1.image = UIImage(named:"badgehard1")
            createDropShadow(badge: badgehard1)
        } else {
            badgehard1.image = UIImage(named:"badgeempty1")
        }
        
        if gameSession.highScoresAndSettings!.getHardHighScore() >= GamePlayParameters.Badges.level2 {
            badgehard2.image = UIImage(named:"badgehard2")
            createDropShadow(badge: badgehard2)
        } else {
            badgehard2.image = UIImage(named:"badgeempty2")
        }
        
        if gameSession.highScoresAndSettings!.getHardHighScore() >= GamePlayParameters.Badges.level3 {
            badgehard3.image = UIImage(named:"badgehard3")
            createDropShadow(badge: badgehard3)
        } else {
            badgehard3.image = UIImage(named:"badgeempty3")
        }
        
        if gameSession.highScoresAndSettings!.getHardHighScore() >= GamePlayParameters.Badges.level4 {
            badgehard4.image = UIImage(named:"badgehard4")
            createDropShadow(badge: badgehard4)
        } else {
            badgehard4.image = UIImage(named:"badgeempty4")
        }

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
    
    private func createDropShadow(badge: UIImageView) {
        badge.layer.shadowColor = UIColor.black.cgColor
        badge.layer.shadowOpacity = 1
        badge.layer.shadowOffset = CGSize.init(width: badge.frame.size.width * 0.015, height: badge.frame.size.width * 0.025)
        badge.layer.shadowRadius = badge.frame.size.width / 20
    }

}



