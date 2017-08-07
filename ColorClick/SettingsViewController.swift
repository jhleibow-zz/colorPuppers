//
//  SettingsViewController.swift
//  ColorPuppers
//
//  Created by John Leibowitz on 6/8/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    //MARK: - Properties
    
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var pupperInfoButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var resetHighScoreButton: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    
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
    
    @IBAction func goBackButtonTap(_ sender: UIButton) {
        goBackToStartPage()
    }
    @IBAction func pupperInfoButtonTap(_ sender: UIButton) {
        
    }
    @IBAction func soundButtonTap(_ sender: UIButton) {
        toggleSoundOn()
    }
    @IBAction func musicButtonTap(_ sender: UIButton) {
    
    }    
    @IBAction func resetHighScoreButtonTap(_ sender: UIButton) {
        gameSession.resetHighScores()
    }
    
    
    //MARK: - View Controller Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //colorSettingsButtons()
        resizeText()
        updateSoundOnText()
    }



    //MARK: - Private Methods
    
    //TODO: make this method part of GameColors class since its also used in game start page
    //randomly assigns colors to menu buttons
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
    
    //go back to Start page view
    private func goBackToStartPage() {
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let passToViewController = "gameStartPageViewControllerID"
        let nextViewController = myStoryBoard.instantiateViewController(withIdentifier: passToViewController) as! GameStartPageViewController
        nextViewController.gameSession = gameSession
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    //toggles setting
    private func toggleSoundOn() {
        if gameSession.highScoresAndSettings!.soundOn {
            gameSession.highScoresAndSettings!.soundOn = false
            gameSession.stopMusic()
        } else {
            gameSession.highScoresAndSettings!.soundOn = true
            gameSession.playMusic()
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
        
        Utilities.updateButtonFontSize(button: goBackButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: soundButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: musicButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: pupperInfoButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        Utilities.updateButtonFontSize(button: resetHighScoreButton, fontName: GamePlayParameters.Fonts.buttonFontName, scaleDownFromHeightFactor: 2.1)
        
        
    }
    
    
}
