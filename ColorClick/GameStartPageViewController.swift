//
//  GameStartPageViewController.swift
//  ColorClick
//
//  Created by John Leibowitz on 6/6/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class GameStartPageViewController: UIViewController, UIViewControllerTransitioningDelegate, GameSessionAnimationDelegate {

    
    //MARK: - Properties
    
    @IBOutlet weak var playEasyButton: UIButton!
    @IBOutlet weak var playMediumButton: UIButton!
    @IBOutlet weak var playHardButton: UIButton!
    @IBOutlet weak var pupperInfoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
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
    
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    var percentInteractionController: UIPercentDrivenInteractiveTransition?
    
    
    //MARK: - Actions
    
    @IBAction func playEasyButtonTap(_ sender: Any) {
        stopAnimations()
        startGame(difficulty: GameSession.Difficulty.easy)
    }
    
    @IBAction func playMediumButtonTap(_ sender: UIButton) {
        stopAnimations()
        startGame(difficulty: GameSession.Difficulty.medium)
    }
    
    @IBAction func playHardButtonTap(_ sender: UIButton) {
        stopAnimations()
        startGame(difficulty: GameSession.Difficulty.hard)
    }

    @IBAction func pupperInfoButtonTap(_ sender: UIButton) {
        stopAnimations()
        goToPupperInfo()
    }
    
    @IBAction func settingsButtonTap(_ sender: UIButton) {
        stopAnimations()
        goToSettings()
    }
    @IBAction func badgeButtonTap(_ sender: UIButton) {
        stopAnimations()
        goToBadges()
    }
    
    
    //MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameSession.animationDelegate = self
        

        stopAnimations()
      
        
        
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
    
    private func animateBadge(radians: CGFloat, counter: Int, delay: CGFloat) {
        var count = counter
        
        if self.badgeButton.layer.animationKeys()?.count == nil {
        
            UIView.animate(withDuration: 0.1, delay: TimeInterval(delay), usingSpringWithDamping: 0.2, initialSpringVelocity: 5.5, options: [.allowUserInteraction], animations: {
                    self.badgeButton.transform = CGAffineTransform(rotationAngle: radians)
            }, completion: { finished in
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
    
    private func stopAnimations() {
        //self.badgeButton.layer.removeAllAnimations()
        view.layer.removeAllAnimations()
    }
  

    
    //starts a game with input difficulty
    private func startGame(difficulty: GameSession.Difficulty) {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = myStoryBoard.instantiateViewController(withIdentifier: "gameViewControllerID") as! GameViewController
        gameSession.startNewGame(difficulty: difficulty)
        gameViewController.gameSession = gameSession
        gameViewController.transitioningDelegate = self;
        self.present(gameViewController, animated: true, completion: nil)
    }
    
    //navigate to settings page
    private func goToSettings() {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: "settingsViewControllerID") as! SettingsViewController
        nextViewController.gameSession = gameSession
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    //navigate to badges page
    private func goToBadges() {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: "badgesViewControllerID") as! BadgesViewController
        nextViewController.gameSession = gameSession
        nextViewController.sendingViewControllerName = "gameStartPageViewControllerID"
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
    //navigate to pupper info page
    private func goToPupperInfo() {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: "pupperInfoPageViewControllerID") as! AboutPuppersViewController
        nextViewController.gameSession = gameSession
        nextViewController.sendingViewControllerName = "gameStartPageViewControllerID"
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    //randomly assigns colors to menu buttons
    private func colorMenuButtons() {
//        var alreadyUsedColors = [GameColor]()
//        var tempColor = gameSession.gameColorsAndObjects.getRandomGameColor(butNot: alreadyUsedColors)
//        
//        playEasyButton.backgroundColor = tempColor.color
//        alreadyUsedColors.append(tempColor)
//        
//        tempColor = gameSession.gameColorsAndObjects.getRandomGameColor(butNot: alreadyUsedColors)
//        playMediumButton.backgroundColor = tempColor.color
//        alreadyUsedColors.append(tempColor)
//        
//        tempColor = gameSession.gameColorsAndObjects.getRandomGameColor(butNot: alreadyUsedColors)
//        playHardButton.backgroundColor = tempColor.color
//        alreadyUsedColors.append(tempColor)
//        
//        tempColor = gameSession.gameColorsAndObjects.getRandomGameColor(butNot: alreadyUsedColors)
//        settingsButton.backgroundColor = tempColor.color
        
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

        Utilities.updateButtonFontSize(button: playEasyButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: playMediumButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: playHardButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: pupperInfoButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: settingsButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        
       
        
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
    
    private func createDropShadow() {
        badgeButton.layer.shadowColor = UIColor.black.cgColor
        badgeButton.layer.shadowOpacity = 1
        badgeButton.layer.shadowOffset = CGSize.init(width: badgeButton.frame.size.width * 0.025, height: badgeButton.frame.size.width * 0.05)
        badgeButton.layer.shadowRadius = badgeButton.frame.size.width / 10

    }

}
