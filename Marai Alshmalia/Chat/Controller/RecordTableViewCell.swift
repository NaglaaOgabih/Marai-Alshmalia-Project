//
//  RecordTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 10/04/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class RecordTableViewCell: UITableViewCell,AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    var audioPlayer: AVAudioPlayer!
    var recordName: String = "audioFile.m4a"
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var recordSlider: UISlider!
    @IBOutlet weak var  timeLabel: UILabel!
    var sliderValue : Float?
    var playerTime : String?

    override func awakeFromNib() {
        super.awakeFromNib()
        recordSlider.isUserInteractionEnabled = true
        recordSlider.value = 0.0
        timeLabel.text = "00:00"
        // Initialization code
//        var updateTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: Selector(("updateTime")), userInfo: nil, repeats: true)
//        var timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: Selector(("updateSlider")), userInfo: nil, repeats: true)
        
        let pathString = Bundle.main.path(forResource: "agnes", ofType: "mp3")

         if let pathString = pathString {

             let pathURL = NSURL(fileURLWithPath: pathString)

             do {

                try audioPlayer = AVAudioPlayer(contentsOf: pathURL as URL)

             } catch {

                 print("error")
             }


         }

//         recordSlider.maximumValue = Float(audioPlayer.duration)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    var finishPlaying : (() -> ())?
    var setPlayBtn : (() -> ())?
    @IBAction func playBtnPressed(_ sender: Any) {
        setPlayBtn?()
    }
//     func audioPlayerFinish(finishValue : Bool){
//        iconValue = finishValue
//        setPlayBtnIcon?()
//    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func setupPlayer() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(recordName)
        do{
       
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.delegate = self
            audioPlayer.play()
            audioPlayer.volume = 1.0
        }catch{
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       finishPlaying?()
        
    }
    @IBAction func sliderChange(_ sender: Any) {
        audioPlayer.currentTime = TimeInterval(recordSlider.value)
//        audioPlayer.currentTime = TimeInterval(recordSlider.value)
    }

}
