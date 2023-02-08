//
//  ViewController.swift
//  EggTimer
//
//  Created by Vsevolod Honcharenko on 08.02.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 3
    var secondsPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func eggSelected(_ sender: UIButton) {
        
        //каждый раз при нажании на кнопку останавливаем и отменяем таймер
        timer.invalidate()
        let hardness = sender.currentTitle! //Sofe, Medium, Hard
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:
                                        #selector(updateTimer), userInfo: nil, repeats: true)
    
    }
    
    func updateProgressBar(step: Float) {
        progressBar.progress += step
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}

