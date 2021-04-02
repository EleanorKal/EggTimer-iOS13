//
//  ViewController.swift
//  EggTimer App
//
//  Created by Eleanor Kalu on 2 April 2021.
//  Copyright @2021 Blarnya. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {
    

//    var softTime = 300  // 5 minutes
//    let mediumTime = 420 // 7 minutes
//    let hardTime = 720 // 12 minutes
    
    var seconds = 60
//    var minutes = 12
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var player: AVAudioPlayer!

    // create a dictionary with a key and a value
    // let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    let eggTimes : [String: Int] = ["Soft": 301, "Medium": 421, "Hard": 721]
    
    // This method call initializes the timer.
    // It specifies the timeInterval (how often the a method will be called)
    // and the selector (the method being called).
    // The interval is measured seconds so for it to perform like a standard clock
    // we should set this argument to 1.
    //
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,
          selector: (#selector(ViewController.updateTimer)),
           userInfo: nil, repeats: true)
    }
    
    // this NEW function formats the timer to 00:00 (minutes:seconds)
    func prodTimeString(time: TimeInterval) -> String {
        let prodMinutes = Int(time) / 60 % 60
        let prodSeconds = Int(time) % 60
        
        return String(format: "%02d:%02d", prodMinutes, prodSeconds)
    }
    
    // the new function sounds the alarm bell once the eggs are done
    func alarm(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    // this NEW code performs the timer countdown
    @objc func updateTimer() {
        //This will decrement(count down)the seconds.
        // countdownTimer.text = String(seconds) //This will update the label.
        //
        // new code
        if seconds < 1 {
            timer.invalidate()
            countdownTimer.text = "00:00"
            alarm(soundName: "alarm_sound")
            countdownTimer.text = "Your Eggs Are Done!"
        } else {
            seconds -= 1
            countdownTimer.text = prodTimeString(time: TimeInterval(seconds))
        }
    }
   

    @IBOutlet weak var countdownTimer: UILabel!
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        runTimer()
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if resumeTapped == false {
             timer.invalidate()
             resumeTapped = true
        } else {
             runTimer()
             resumeTapped = false
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // timer.invalidate()
        countdownTimer.text = "00:00"
        timer.invalidate()
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // print(sender.currentTitle!)
        
        let hardness = sender.currentTitle!
        
        // NEW code to evaluate the eggTimes and run the countdown
        seconds = Int(eggTimes[hardness] ?? 60)
        updateTimer()
       // the questions marks are stripped out with the ?? ""
       // print(eggTimes[hardness] ?? "")
    
       // alternatively, the longer way is use an IF Statement
    }
    
    
    
}
