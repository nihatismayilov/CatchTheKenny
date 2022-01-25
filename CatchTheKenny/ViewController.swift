//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Nihad Ismayilov on 23.01.22.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var highscore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var count = 0
    var kennyArray = [UIImageView]()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        scoreLabel.text = "Score: \(score)"
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        if let newHighscore = storedHighscore as? Int {
            highscore = newHighscore
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(gesture1)
        kenny2.addGestureRecognizer(gesture2)
        kenny3.addGestureRecognizer(gesture3)
        kenny4.addGestureRecognizer(gesture4)
        kenny5.addGestureRecognizer(gesture5)
        kenny6.addGestureRecognizer(gesture6)
        kenny7.addGestureRecognizer(gesture7)
        kenny8.addGestureRecognizer(gesture8)
        kenny9.addGestureRecognizer(gesture9)
        
//        hideKenny()
//
//        count = 10
//        timeLabel.text = "\(count)"
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFunction), userInfo: nil, repeats: true)
//        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func easyClicked(_ sender: Any) {
        
        hideKenny()
        count = 10
        timeLabel.text = "\(count)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func mediumClicked(_ sender: Any) {
        
        hideKenny()
        count = 10
        timeLabel.text = "\(count)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func hardClicked(_ sender: Any) {
        
        hideKenny()
        count = 10
        timeLabel.text = "\(count)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    @objc func hideKenny() {
        
//        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func timeFunction() {

        count -= 1
        timeLabel.text = String(count)
        
        if count == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let stopButton = UIAlertAction(title: "Stop", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.count = 10
                self.timeLabel.text = String(self.count)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(stopButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            if score > highscore {
                highscore = score
                highscoreLabel.text = "Highscore: \(highscore)"
                UserDefaults.standard.set(highscore, forKey: "highscore")
                
            }
        }
    }


}

