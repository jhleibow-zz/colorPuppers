//
//  GameStartPageViewController.swift
//  ColorClick
//
//  Created by John Leibowitz on 6/6/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class GameStartPageViewController: UIViewController {

    
    //MARK: - Properties
    
    @IBOutlet weak var playEasyButton: UIButton!
    @IBOutlet weak var playMediumButton: UIButton!
    @IBOutlet weak var playHardButton: UIButton!
    @IBOutlet weak var pupperInfoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var boneButton: UIButton!
    
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
        goToSettings()
    }
    
    @IBAction func settingsButtonTap(_ sender: UIButton) {
        stopAnimations()
        goToSettings()
    }
    @IBAction func boneButtonTap(_ sender: UIButton) {
        stopAnimations()
        goToSettings()
    }
    
    
    //MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorMenuButtons()
        resizeText()
        updateHighScoreLabel()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBone(radians: CGFloat.pi/18, counter: 0, delay: 0.0)
    }
    
  
    //MARK: - Private Methods
    
    private func animateBone(radians: CGFloat, counter: Int, delay: CGFloat) {
        var count = counter
        UIView.animate(withDuration: 0.1, delay: TimeInterval(delay), usingSpringWithDamping: 0.2, initialSpringVelocity: 5.5, options: [.allowUserInteraction], animations: {
                self.boneButton.transform = CGAffineTransform(rotationAngle: radians)
        }, completion: { finished in
            count = count + 1
            if count == 6 {
                count = 0
                self.animateBone(radians: -radians, counter: count, delay: 1.0)
            } else {
                self.animateBone(radians: -radians, counter: count, delay: 0.0)
            }
        } )
    }
    
    private func stopAnimations() {
        self.boneButton.layer.removeAllAnimations()
    }
  

    
    //starts a game with input difficulty
    private func startGame(difficulty: GameSession.Difficulty) {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = myStoryBoard.instantiateViewController(withIdentifier: "gameViewControllerID") as! GameViewController
        gameSession.startNewGame(difficulty: difficulty)
        gameViewController.gameSession = gameSession
        self.present(gameViewController, animated: true, completion: nil)
    }
    
    //navigate to settings page
    private func goToSettings() {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: "settingsViewControllerID") as! SettingsViewController
        nextViewController.gameSession = gameSession
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
        
        easyHighScoreLabel.text = String(gameSession!.highScoresAndSettings!.easyHighScore)
        mediumHighScoreLabel.text = String(gameSession!.highScoresAndSettings!.mediumHighScore)
        hardHighScoreLabel.text = String(gameSession!.highScoresAndSettings!.hardHighScore)
        
    }

}
