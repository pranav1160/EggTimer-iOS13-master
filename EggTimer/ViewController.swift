import UIKit
import AVFoundation
var player: AVAudioPlayer?


class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var totalTime = 0
    var secPassed = 0
    var timer = Timer()
    
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate() // Stop any previous timer
        secPassed = 0 // Reset seconds passed
        progressBarView.progress = 0.0 // Reset progress bar
        
        let hardness = sender.currentTitle ?? "no title found"
        if let selectedTime = eggTimes[hardness] {
            totalTime = selectedTime
            titleLabel.text = "\(hardness) egg is cooking..."
            
            // Start the timer
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTimer() {
        if secPassed < totalTime {
            secPassed += 1
            let percentageProgress = Float(secPassed) / Float(totalTime)
            progressBarView.setProgress(percentageProgress, animated: true)
            print("Time remaining: \(totalTime - secPassed) seconds")
        } else {
            timer.invalidate()
            titleLabel.text = "Egg is ready!"
            progressBarView.progress = 1.0
            playSound()
            print("Time is up")
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
