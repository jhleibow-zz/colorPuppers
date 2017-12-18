//
//  SettingsViewController.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/8/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIViewControllerTransitioningDelegate, GameSessionAnimationDelegate, UIGestureRecognizerDelegate {

    
    //MARK: - Properties
    
    
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var pupperInfoButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var resetHighScoreButton: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBOutlet weak var badgeButton: UIButton!
    
    @IBOutlet weak var easyHighScoreLabel: UILabel!
    @IBOutlet weak var mediumHighScoreLabel: UILabel!
    @IBOutlet weak var hardHighScoreLabel: UILabel!
    @IBOutlet weak var easyLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var hardLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    
    //Object that is passed around all view controllers that contains current game state
    var gameSession: GameSession!
    
    
    var percentInteractionController: UIPercentDrivenInteractiveTransition?
    
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    //MARK: - Actions
    
    @IBAction func goBackButtonTap(_ sender: UIButton) {
        goBackToStartPage()
    }
    @IBAction func pupperInfoButtonTap(_ sender: UIButton) {
        goToPupperInfo()
    }
    @IBAction func soundButtonTap(_ sender: UIButton) {
        toggleSoundOn()
    }
    @IBAction func musicButtonTap(_ sender: UIButton) {
        toggleMusicOn()
    }    
    @IBAction func resetHighScoreButtonTap(_ sender: UIButton) {
        gameSession.resetHighScores()
        updateHighScoreLabel()
        
    }
    @IBAction func badgeButtonTap(_ sender: UIButton) {
        stopAnimations()
        goToBadges()
    }
    
    
    //MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //colorSettingsButtons()
        
        gameSession.animationDelegate = self
        
        updateSoundOnText()
        updateMusicOnText()
        
        let panRight = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_ :)))
        panRight.delegate = self
        view.addGestureRecognizer(panRight)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        createDropShadow()
        resizeText()
        updateHighScoreLabel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stopAnimations()
        animateBadge(radians: CGFloat.pi/48, counter: 0, delay: 0.0)
    }
    

    //MARK: - Private Methods
    
    //TODO: make this method part of GameColors class since its also used in game start page
    private func colorSettingsButtons() {
        var alreadyUsedColors = [GameColor]()
        var tempColor = gameSession.gameColorsAndObjects.getRandomGameColor(butNot: alreadyUsedColors)
        
        goBackButton.backgroundColor = tempColor.color
        alreadyUsedColors.append(tempColor)
        
        tempColor = gameSession.gameColorsAndObjects.getRandomGameColor(butNot: alreadyUsedColors)
        resetHighScoreButton.backgroundColor = tempColor.color
        alreadyUsedColors.append(tempColor)
        
        tempColor = gameSession.gameColorsAndObjects.getRandomGameColor(butNot: alreadyUsedColors)
        soundButton.backgroundColor = tempColor.color
        alreadyUsedColors.append(tempColor)
        
        tempColor = gameSession.gameColorsAndObjects.getRandomGameColor(butNot: alreadyUsedColors)
        pupperInfoButton.backgroundColor = tempColor.color
        
    }
    
    @objc func panGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view)
        let percent = translation.x / gesture.view!.frame.size.width
        
        if gesture.state == .began {
            
            let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: "gameStartPageViewControllerID") as! GameStartPageViewController
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
    
    //go back to Start page view
    private func goBackToStartPage() {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let passToViewController = "gameStartPageViewControllerID"
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: passToViewController) as! GameStartPageViewController
        nextViewController.gameSession = gameSession
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    //navigate to badges page
    private func goToBadges() {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: "badgesViewControllerID") as! BadgesViewController
        nextViewController.gameSession = gameSession
        nextViewController.sendingViewControllerName = "settingsViewControllerID"
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    //navigate to pupper info page
    private func goToPupperInfo() {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: "pupperInfoPageViewControllerID") as! AboutPuppersViewController
        nextViewController.gameSession = gameSession
        nextViewController.sendingViewControllerName = "settingsViewControllerID"
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    //toggles setting
    private func toggleSoundOn() {
        if gameSession.highScoresAndSettings!.soundOn {
            gameSession.highScoresAndSettings!.soundOn = false
        } else {
            gameSession.highScoresAndSettings!.soundOn = true
        }
        gameSession.saveScoresAndSettings()
        updateSoundOnText()
    }
    
    //updates text to match setting
    private func updateSoundOnText() {
        
        if gameSession.highScoresAndSettings!.soundOn {
            soundButton.setTitle("SOUND: ON", for: .normal)
        } else {
            soundButton.setTitle("SOUND: OFF", for: .normal)
        }
        
    }
    
    //toggles setting
    private func toggleMusicOn() {
        if gameSession.highScoresAndSettings!.musicOn {
            gameSession.highScoresAndSettings!.musicOn = false
            gameSession.stopMusic()
        } else {
            gameSession.highScoresAndSettings!.musicOn = true
            gameSession.playMusic()
        }
        gameSession.saveScoresAndSettings()
        updateMusicOnText()
    }
    
    //updates text to match setting
    private func updateMusicOnText() {
        
        if gameSession.highScoresAndSettings!.musicOn {
            musicButton.setTitle("MUSIC: ON", for: .normal)
        } else {
            musicButton.setTitle("MUSIC: OFF", for: .normal)
        }
        
    }
    
    //updates button text size
    private func resizeText() {
        
        Utilities.updateLabelFont(label: easyHighScoreLabel, fontName: GamePlayParameters.Fonts.scoreFontName)
        Utilities.updateLabelFont(label: mediumHighScoreLabel, fontName: GamePlayParameters.Fonts.scoreFontName)
        Utilities.updateLabelFont(label: hardHighScoreLabel, fontName: GamePlayParameters.Fonts.scoreFontName)
        Utilities.updateLabelFont(label: easyLabel, fontName: GamePlayParameters.Fonts.gameFontName)
        Utilities.updateLabelFont(label: mediumLabel, fontName: GamePlayParameters.Fonts.gameFontName)
        Utilities.updateLabelFont(label: hardLabel, fontName: GamePlayParameters.Fonts.gameFontName)
        Utilities.updateLabelFont(label: highLabel, fontName: GamePlayParameters.Fonts.gameFontName)
        Utilities.updateLabelFont(label: scoresLabel, fontName: GamePlayParameters.Fonts.gameFontName)
        
        Utilities.updateLabelFontAttributed(label: settingsLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center, characterSpacing: 5.0, scaleDownFromHeightFactor: 2.7)
        
        Utilities.updateButtonFontSize(button: goBackButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.5)
        Utilities.updateButtonFontSize(button: soundButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.5)
        Utilities.updateButtonFontSize(button: musicButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.5)
        Utilities.updateButtonFontSize(button: pupperInfoButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.5)
        Utilities.updateButtonFontSize(button: resetHighScoreButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.5)
        
        
    }
    
    //MARK: - Private Methods
    
    private func animateBadge(radians: CGFloat, counter: Int, delay: CGFloat) {

        var count = counter
        
        if self.badgeButton.layer.animationKeys()?.count == nil {

            UIView.animate(withDuration: 0.1, delay: TimeInterval(delay), usingSpringWithDamping: 0.2, initialSpringVelocity: 5.5, options: [.allowUserInteraction], animations: {
                self.badgeButton.transform = CGAffineTransform(rotationAngle: radians)
            }, completion: { finished in
                print(count)
                count = count + 1
                if !finished {
                    self.badgeButton.layer.removeAllAnimations()
                } else if count == 6 {
                    count = 0
                    self.animateBadge(radians: -radians, counter: count, delay: 1.0)
                } else {
                    self.animateBadge(radians: -radians, counter: count, delay: 0.0)
                }
            } )
            
        }
        

    }
    
    private func createDropShadow() {
        badgeButton.layer.shadowColor = UIColor.black.cgColor
        badgeButton.layer.shadowOpacity = 1
        badgeButton.layer.shadowOffset = CGSize.init(width: badgeButton.frame.size.width * 0.025, height: badgeButton.frame.size.width * 0.05)
        badgeButton.layer.shadowRadius = badgeButton.frame.size.width / 10
        
    }
    
    private func stopAnimations() {

        view.layer.removeAllAnimations()
    }
    
    //updates high score label
    private func updateHighScoreLabel() {
        
        easyHighScoreLabel.text = String(gameSession!.highScoresAndSettings!.getEasyHighScore())
        mediumHighScoreLabel.text = String(gameSession!.highScoresAndSettings!.getMediumHighScore())
        hardHighScoreLabel.text = String(gameSession!.highScoresAndSettings!.getHardHighScore())
        
    }
    
    //MARK: - GameSessionAnimationDelegate method
    
    func focusReturnedStartAnimationAgain() {
        stopAnimations()
        animateBadge(radians: CGFloat.pi/48, counter: 0, delay: 0.0)
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

extension SettingsViewController {
    
    // make sure it only recognizes upward gestures
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

