//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    let eggTime : [String: Int] = ["Soft": 5, "Medium": 7,"Hard": 12]
    var timer = Timer()
    var totalTime: Int = 0
    var secondsPassed: Int = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0
        let hardness = sender.currentTitle ?? "Error"
        titleLabel.text = hardness
        secondsPassed = 0
        totalTime = (eggTime[hardness] ?? 0)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        let percentageProgress: Float = Float(secondsPassed) / Float(totalTime)
        progressBar.progress = percentageProgress
        
        if(secondsPassed < totalTime) {
            secondsPassed += 1
        }else{
            timer.invalidate()
            titleLabel.text = "Done"
            playSound()
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
