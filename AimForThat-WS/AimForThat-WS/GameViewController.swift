//
//  ViewController.swift
//  AimForThat-WS
//
//  Created by Haydee Rodriguez on 3/20/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var currentValue: Int = 50
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabels: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updatLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let difference = abs(self.currentValue - self.targetValue)
        let points = (difference > 0) ? 100 - difference : 1000
        self.score += points
        
        let message = """
        Has hecho \(points) puntos
        El valor del slider es \(self.currentValue)
        El valor del objetivo es: \(self.targetValue)
        El error fue de de \(difference)
        """
        
        let alert = UIAlertController(title: "Puntuacion", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Genial", style: .default, handler: {action in
            self.startNewRound()
            self.updatLabels()
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        //startNewRound()
        //updatLabels()
        
    }
    @IBAction func sliderMove(_ sender: UISlider) {
        self.currentValue = lroundf(sender.value)
    }
    
    func startNewRound(){
        self.targetValue = 1 + Int(arc4random_uniform(100))
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        self.round += 1
    }
    
    func updatLabels(){
        self.targetLabel.text = "\(self.targetValue)"
        self.scoreLabels.text = "\(self.score)"
        self.roundLabel.text = "\(self.round)"
    }
    
    @IBAction func restartAction(_ sender: UIButton) {
        self.round = 0
        self.score = 0
        startNewRound()
        updatLabels()
    }
}

