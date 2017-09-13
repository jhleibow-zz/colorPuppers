//
//  GameOverViewController.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/5/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import GoogleMobileAds
import UIKit
import AVFoundation

class GameOverViewController: UIViewController, GameSessionAdDelegate, UIViewControllerTransitioningDelegate {

 
    //MARK: - Properties
    
    @IBOutlet weak var reactionImage: UIImageView!

    @IBOutlet weak var gameOverFrame: UIView!
    @IBOutlet weak var continueFrame: UIView!
    @IBOutlet weak var gameOverNoAdFrame: UIView!
    
    @IBOutlet weak var playAdButton: UIButton!
    @IBOutlet weak var noThanksButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var continueFromThisLevelLabel: UILabel!
    @IBOutlet weak var thanksForWatchingLabel: UILabel!
    @IBOutlet weak var madeItToLevelLabel: UILabel!
    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var someLinesLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var anotherGameOverLabel: UILabel!
    @IBOutlet weak var someOtherLinesLabel: UILabel!
    @IBOutlet weak var evenMoreLinesLabel: UILabel!

    //trying to play ad?
    var adClicked = false
    
    
    //audio player
    var audioPlayer: AVAudioPlayer!
    
    
    //Object that is passed around all view controllers that contains current game state
    var gameSession: GameSession!

  
   
    //hides battery and other info...
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    
    //MARK: - Actions
    @IBAction func playAd(_ sender: UIButton) {
        
        if gameSession.rewardVideo?.isReady == true {
            adClicked = true
            gameSession.pauseGame()
            
            gameOverFrame.alpha = 0.0
            gameOverNoAdFrame.alpha = 0.0
            continueFrame.alpha = 0.0
            
            gameSession.rewardVideo?.present(fromRootViewController: self)
        } else {
            print("video not available or ready")
        }
    }
    
    @IBAction func noThanksButtonTap(_ sender: UIButton) {
        goBack()
    }
    
    @IBAction func okButtonTap(_ sender: UIButton) {
        goBack()
    }
  
    @IBAction func continueButtonTap(_ sender: UIButton) {
        
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        var passToViewController: String
        
        passToViewController = "gameViewControllerID"
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: passToViewController) as! GameViewController
        nextViewController.gameSession = gameSession
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
    //MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        gameSession.adDelegate = self
        
        
        gameOverFrame.alpha = 0.0
        gameOverNoAdFrame.alpha = 0.0
        continueFrame.alpha = 0.0
        
        roundCorners()
        createDropShadow()
        wrongAnswer()
        fixFontSizes()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !adClicked {
            if gameSession.rewardVideo?.isReady == true && gameSession.numberOfAdsWatchedThisGame < 3 {
                fadeInGameOverWindow()
            } else {
                fadeInGameOverNoAdWindow()
            }
        }
        
        gameSession.unpauseGame()
    }

    
    //MARK: - GameSessionAdDelegate Methods
    func adWasWatched(_ result: Bool) {
        if result == true {
            continueFrame.alpha = 1.0
        } else {
            gameOverNoAdFrame.alpha = 1.0
        }
    }
    
    //MARK: - Private Methods
    
    private func fadeInGameOverWindow() {
        blurBackgroundPhoto()
        UIView.animate(withDuration: 0.8, delay: 0.65, options: [.allowUserInteraction], animations: {
            self.gameOverFrame.alpha = 1.0
        }, completion: nil )
    }
    
    private func fadeInGameOverNoAdWindow() {
        blurBackgroundPhoto()
        UIView.animate(withDuration: 0.8, delay: 0.65, options: [.allowUserInteraction], animations: {
            self.gameOverNoAdFrame.alpha = 1.0
        }, completion: nil )
    }
    
    private func blurBackgroundPhoto() {
        
        
        let visEffectView = UIVisualEffectView()
        reactionImage.addSubview(visEffectView)
        let blurEffect = UIBlurEffect(style: .dark)
        
        visEffectView.frame = reactionImage.bounds
        UIView.animate(withDuration: 0.8, delay: 0.35, options: [.allowUserInteraction], animations: {
            visEffectView.effect = blurEffect
        }, completion: nil )
    }
    
    
//    { finished in
//    //provide way to move on from Reaction Image view by tap
//    let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.goBack))
//    self.reactionImage.addGestureRecognizer(imageTap)
//    }
    
    private func roundCorners() {
        
        let screenHeight = UIScreen.main.bounds.height
        
        gameOverFrame.layer.cornerRadius = screenHeight/80
        //gameOverFrame.layer.masksToBounds = true
        continueFrame.layer.cornerRadius = screenHeight/80
        //continueFrame.layer.masksToBounds = true
        gameOverNoAdFrame.layer.cornerRadius = screenHeight/80
        //gameOverNoAdFrame.layer.masksToBounds = true
        
        continueButton.layer.cornerRadius = screenHeight/110
        continueButton.layer.masksToBounds = true
        playAdButton.layer.cornerRadius = screenHeight/110
        playAdButton.layer.masksToBounds = true
        okButton.layer.cornerRadius = screenHeight/110
        okButton.layer.masksToBounds = true
    }
    
    private func createDropShadow() {
        gameOverFrame.layer.shadowColor = UIColor.gray.cgColor
        gameOverFrame.layer.shadowOpacity = 0.9
        gameOverFrame.layer.shadowOffset = CGSize.init(width: gameOverFrame.frame.size.width * 0.025, height: gameOverFrame.frame.size.width * 0.05)
        gameOverFrame.layer.shadowRadius = gameOverFrame.frame.size.width / 15
        
        continueFrame.layer.shadowColor = UIColor.gray.cgColor
        continueFrame.layer.shadowOpacity = 0.9
        continueFrame.layer.shadowOffset = CGSize.init(width: continueFrame.frame.size.width * 0.025, height: continueFrame.frame.size.width * 0.05)
        continueFrame.layer.shadowRadius = gameOverFrame.frame.size.width / 15
        
        gameOverNoAdFrame.layer.shadowColor = UIColor.gray.cgColor
        gameOverNoAdFrame.layer.shadowOpacity = 0.9
        gameOverNoAdFrame.layer.shadowOffset = CGSize.init(width: gameOverNoAdFrame.frame.size.width * 0.025, height: gameOverNoAdFrame.frame.size.width * 0.05)
        gameOverNoAdFrame.layer.shadowRadius = gameOverFrame.frame.size.width / 15
        
    }
    
    private func fixFontSizes() {
        
        
        Utilities.updateLabelFont(label: continueFromThisLevelLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        Utilities.updateLabelFont(label: thanksForWatchingLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        Utilities.updateLabelFont(label: thanksLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        Utilities.updateLabelFont(label: someLinesLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        Utilities.updateLabelFont(label: gameOverLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        Utilities.updateLabelFont(label: someOtherLinesLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        Utilities.updateLabelFont(label: anotherGameOverLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        Utilities.updateLabelFont(label: madeItToLevelLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        Utilities.updateLabelFont(label: evenMoreLinesLabel, fontName: GamePlayParameters.Fonts.gameFontName, alignment: .center)
        
        Utilities.updateButtonFontSize(button: playAdButton, fontName: GamePlayParameters.Fonts.gameFontName, scaleDownFromHeightFactor: 1.3)
        Utilities.updateButtonFontSize(button: noThanksButton, fontName: GamePlayParameters.Fonts.gameFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: continueButton, fontName: GamePlayParameters.Fonts.gameFontName, scaleDownFromHeightFactor: 1.3)
        Utilities.updateButtonFontSize(button: okButton, fontName: GamePlayParameters.Fonts.gameFontName, scaleDownFromHeightFactor: 1.3)
     

    }
    
    private func wrongAnswer() {
        
        let whinePath = Bundle.main.path(forResource: "Sad Whine", ofType: "m4a")
        let whineUrl = URL.init(fileURLWithPath: whinePath!)
        
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: whineUrl)
        } catch {
            print ("audio file not found")
        }
        reactionImage.image = UIImage(named: getSadDogPhotoName())
        //gameOverLabel.text = "GAME OVER"
        //levelLabel.text = "You made it to \(gameSession!.currentDifficulty!) level \(gameSession!.getCurrentLevel())!!!"
        continueFromThisLevelLabel.text = "Do you want to watch an ad to continue from level \(gameSession!.getCurrentLevel())?"
        thanksForWatchingLabel.text = "Thanks for watching the ad! Tap 'continue' below to continue the game from level \(gameSession!.getCurrentLevel())."
        
        if (gameSession!.getCurrentLevel() - 1) > 0 {
            madeItToLevelLabel.text = "Congratulations, you passed level \(gameSession!.getCurrentLevel() - 1)!"
        } else {
            madeItToLevelLabel.text = "Try again, you've got this!"
        }
        
        if gameSession.highScoresAndSettings!.soundOn  {
            audioPlayer.play()
        }
        

    }
    
    
    
    //go to start page
    @objc private func goBack() {
        
       
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        var passToViewController: String
        
        passToViewController = "gameStartPageViewControllerID"
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: passToViewController) as! GameStartPageViewController
        nextViewController.gameSession = gameSession
        nextViewController.transitioningDelegate = self;
        self.present(nextViewController, animated: true, completion: nil)

       
        
    }
    
    private func getSadDogPhotoName() -> String {
        var returnString = "saddog"
        returnString += String(arc4random_uniform(UInt32(GamePlayParameters.DogPhotos.numSadDogs)))
        return returnString
    }
    

    
    //MARK: - UIViewControllerTransitioningDelegate methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return gameSession
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    


}
