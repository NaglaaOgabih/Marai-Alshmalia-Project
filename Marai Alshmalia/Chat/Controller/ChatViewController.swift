//
//  ChatViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 28/03/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
//import CoreLocation
import Kingfisher
import WebKit
import GSImageViewerController
class ChatViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate, setLadLongValues,UIDocumentPickerDelegate, WKNavigationDelegate, UIDocumentInteractionControllerDelegate {
    func setValues(msg: Messages) {
        messages.insert(msg, at: 0)
//        messages.append(msg)
        tableView.reloadData()
    }
    
    var pickedImg : UIImage?
    //    var recordButton: UIButton!
    var audioRecorder: AVAudioRecorder!
    //    var audioPlayer: AVAudioPlayer!
    var recordName: String = "audioFile.m4a"
    var recordValue : Bool = false
    //    var timer = Timer()
    var recordingSession : AVAudioSession!
    var videoURL = "https://www.rbtcs.co:30007/chat/video/videoName801617892119605.mp4"
    let fileURL = "https://www.rbtcs.co:30007/chat/file/fileName651617895311744.pdf"
    let googleKey = "AIzaSyD5eKqs2_QBnxgMePLiEmBpz7WXr_aPuFA"
    var source : String?
    var messages : [Messages] = []
    var currntMessage : Messages?
    @IBOutlet weak var messageTxtField: UITextField!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var micBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        var timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        
        messageTxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: messageTxtField.frame.height))
        messageTxtField.leftViewMode = .always
        
        
        self.messages.append(Messages(messageBody: "hello", img: nil, pickedImg: nil, lat: nil, long: nil, type: "text", pickedVideo: nil, fileTitle: nil, direction: "you"))
        self.messages.append(Messages(messageBody: "hi", img: nil, pickedImg: nil, lat: nil, long: nil, type: "text", pickedVideo: nil, fileTitle: nil, direction: "I"))
        self.messages.append(Messages(messageBody: "Test1", img: nil, pickedImg: nil, lat: nil, long: nil, type: "text", pickedVideo: nil, fileTitle: nil, direction: "you"))
        self.messages.append(Messages(messageBody: "Test2", img: nil, pickedImg: nil, lat: nil, long: nil, type: "text", pickedVideo: nil, fileTitle: nil, direction: "I"))
        
        recordValue = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        //        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.size.width - 10)
        //        tableView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
//        DispatchQueue.main.async {
//            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//        }
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPremission) in
            if hasPremission{
                print("Accepted")
            }
        }
    }
    func startRecording() {
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent(recordName)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            //            audioRecorder.prepareToRecord()
            //            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        //
        //        if success {
        //            recordButton.setTitle("Tap to Re-record", for: .normal)
        //        } else {
        //            recordButton.setTitle("Tap to Record", for: .normal)
        //            // recording failed :(
        //        }
    }
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        //        playbtn.enabled = true
        if !flag {
            finishRecording(success: false)
        }
    }
    //    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    //        RecordTableViewCell.audioPlayerFinish(finishValue: true)
    //    }
    //    func setupPlayer() {
    //        let audioFilename = getDocumentsDirectory().appendingPathComponent(recordName)
    //        do{
    //
    //            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
    //            audioPlayer.delegate = self
    //            audioPlayer.play()
    //            audioPlayer.volume = 1.0
    //        }catch{
    //        }
    //    }
    //     func updateTime() {
    //        let currentTime = Int(audioPlayer.currentTime)
    //        print(currentTime)
    //        let duration = Int(audioPlayer.duration)
    //        let total = currentTime - duration
    //        var totalString = String(total)
    //
    //        var minutes = currentTime/60
    //        var seconds = currentTime - minutes / 60
    //        playerTime = NSString(format: "%02d:%02d", minutes,seconds) as String
    //        print(playerTime)
    //
    ////        playerTime = NSString(format: "%02d:%02d", minutes,seconds) as String
    ////        timeLabel.text =
    //
    ////        playedTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    //    }
    //    func updateSlider() -> Float{
    ////        slider.value = Float(audioPlayer.currentTime)
    //        return Float(audioPlayer.currentTime)
    //        }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        let msg = Messages(messageBody: messageTxtField.text ?? "nil", img: nil, lat: nil, long: nil, type: "text")
        messages.insert(msg, at: 0)
//        messages.append(msg)
        messageTxtField.text = ""
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func locationBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "ChatStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapMsgViewController") as? MapMsgViewController
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @available(iOS 14.0, *)
    @IBAction func fileBtnPressed(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        //        imagePickerController.mediaTypes = ["public.image", "public.movie"]
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Liperary", style: .default, handler: { (action : UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.source = "Photo Liperary"
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Video Liperary", style: .default, handler: { (action : UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            self.source = "Video Liperary"
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "File", style: .default, handler: { (action : UIAlertAction) in
            //                    self.clickFunction()
            self.source = "file"
            self.selectFiles()
            let fileUrlConverted = URL(string: self.fileURL)
            let fileName = fileUrlConverted?.lastPathComponent
            let file =  Messages(messageBody: nil, img: nil, pickedImg: nil, lat: nil, long: nil, type: "file", pickedVideo: nil, fileTitle: fileName)
            self.messages.insert(file, at: 0)
//            self.messages.append(file)
            self.tableView.reloadData()
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action : UIAlertAction) in
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
    }
    func clickFunction(){
        
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    @available(iOS 14.0, *)
    func selectFiles() {
        let types = UTType.types(tag: "json",
                                 tagClass: UTTagClass.filenameExtension,
                                 conformingTo: nil)
        let documentPickerController = UIDocumentPickerViewController(
            forOpeningContentTypes: types)
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if source == "Photo Liperary" {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            pickedImg = image
            let picked = Messages(messageBody: nil, img: nil, pickedImg: pickedImg, lat: nil, long: nil, type: "pickedImg")
            messages.insert(picked, at: 0)
            
//            messages.append(picked)
        }else if source == "Video Liperary"{
            let asset: AVAsset = AVAsset(url:URL(string: videoURL)!)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            let timestamp = CMTime(seconds: 2, preferredTimescale: 60)
            do{
                let thumbnailImage = try imageGenerator.copyCGImage(at: timestamp, actualTime: nil)
                let video =  Messages(messageBody: nil, img:nil, pickedImg: nil, lat: nil, long: nil, type: "pickedVideo", pickedVideo:UIImage(cgImage: thumbnailImage))
                messages.insert(video, at: 0)

//                messages.append(video)
            }catch{
                let video =  Messages(messageBody: nil, img:nil, pickedImg: nil, lat: nil, long: nil, type: "pickedVideo", pickedVideo: UIImage(named: "master"))
                messages.insert(video, at: 0)

//                messages.append(video)
                print(error)
            }
            if source == "file"{
            }
        }
        tableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func micBtnPressed(_ sender: Any) {
        //        recordValue = true
        if  recordValue == true{
            startRecording()
            //            deleteBtn.isHidden = false
            micBtn.setImage(UIImage(named: "microphone-1"), for: .normal)
            audioRecorder.record()
        }else{
            recordValue = false
            //            deleteBtn.isHidden = true
            audioRecorder.stop()
            micBtn.setImage(UIImage(named: "microphone"), for: .normal)
            let record = Messages(messageBody: nil, img: nil, pickedImg: nil, lat: nil, long: nil, type: "record", pickedVideo: nil, fileTitle: nil)
            messages.insert(record, at: 0)

//            messages.append(record)
            tableView.reloadData()
            
        }
        recordValue = !recordValue
        
    }
}
extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages[indexPath.row].type == "text"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reciverCell") as! ReciverTableViewCell
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell.reciverMsg.text = messages[indexPath.row].messageBody
            
            if messages[indexPath.row].direction == "you"{
                cell.rightConstrain.priority = UILayoutPriority(rawValue: 1000)
                cell.leftConstrain.priority =  UILayoutPriority(rawValue: 900)
                cell.reciverMsg.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            }else{
                cell.rightConstrain.priority = UILayoutPriority(rawValue: 900)
                cell.leftConstrain.priority =  UILayoutPriority(rawValue: 1000)
            }
            return cell
        }else if messages[indexPath.row].type == "img"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ImgTableViewCell
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            cell.configureCell(with: messages[indexPath.row].lat!, long: messages[indexPath.row].long!)
            return cell
        }else if messages[indexPath.row].type == "pickedImg"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "pickedImgCell") as! PickedImgTableViewCell
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            cell.pickedImgView.image = messages[indexPath.row].pickedImg
            
            return cell
        }else if messages[indexPath.row].type == "file"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "fileCell") as! FileTableViewCell
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            cell.fileTitle.text = messages[indexPath.row].fileTitle
            return cell
        }else if messages[indexPath.row].type == "record"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell") as! RecordTableViewCell
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            var playValue : Bool = true
            cell.setPlayBtn = {
                var timer = Timer()
                if playValue == true{
                    cell.playBtn.setImage(UIImage(named: "pause"), for: .normal)
                    cell.setupPlayer()
                    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (t) in
                        let currentTime = Float(cell.audioPlayer.currentTime)
                        //                        let duration = Float(cell.audioPlayer.duration)
                        let minutes = currentTime/60
                        let seconds = currentTime - minutes / 60
                        cell.timeLabel.text = NSString(format:"%02i:%02i",Int(minutes),Int(seconds)) as String
                        cell.recordSlider.maximumValue = Float((cell.audioPlayer.duration))
                        cell.recordSlider.value = currentTime
                        //                        let total = duration - currentTime
                        cell.audioPlayer.currentTime = TimeInterval(cell.recordSlider.value)
                    })
                    cell.audioPlayer.currentTime = TimeInterval(cell.recordSlider.value)
                }else{
                    playValue = false
                    cell.audioPlayer.stop()
                    timer.invalidate()
                    cell.playBtn.setImage(UIImage(named: "play"), for: .normal)
                }
                playValue = !playValue
                cell.finishPlaying = {
                    cell.playBtn.setImage(UIImage(named: "play"), for: .normal)
                    timer.invalidate()
                    cell.recordSlider.value = 0.0
                    cell.timeLabel.text = "00:00"
                }
            }
            return cell
        }
        //        video
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as! VideoTableViewCell
            cell.videoImg.image = messages[indexPath.row].pickedVideo
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if messages[indexPath.row].type == "pickedVideo"{
            let player = AVPlayer(url: URL(string: videoURL)!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }else if messages[indexPath.row].type == "file"{
            //            let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: fileURL))
            //            let dc = UIDocumentInteractionController(url:URL(string: fileURL)!)
            //              dc.delegate = self
            //              dc.presentPreview(animated: true)
            //            let webview = WKWebView(frame: UIScreen.main.bounds)
            //            view.addSubview(webview)
            //            webview.navigationDelegate = self
            //            webview.load(URLRequest(url:URL(string: fileURL)! ))
            
            if let url = URL(string: fileURL){
                UIApplication.shared.open(url)
            }
            //            view.sendSubviewToBack(webview)
        }else if messages[indexPath.row].type == "img"{
            
            if let urlDestination = URL.init(string:"http://www.google.com/maps/place/\(String(describing: messages[indexPath.row].lat)),\(String(describing: messages[indexPath.row].long))") {
                print(urlDestination)
                UIApplication.shared.open(urlDestination)
            }
        }else if messages[indexPath.row].type == "pickedImg"{
            let pickedImage = messages[indexPath.row].pickedImg!
            let imageInfo   = GSImageInfo(image: pickedImage, imageMode: .aspectFit)
            let imageViewer = GSImageViewerController(imageInfo: imageInfo)
            navigationController?.pushViewController(imageViewer, animated: true)
   
        }
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if messages[indexPath.row].type == "img" || messages[indexPath.row].type == "pickedVideo" {
            return 314
        }else if messages[indexPath.row].type == "pickedImg"{
            return 230
            
        }else if messages[indexPath.row].type == "record" || messages[indexPath.row].type == "file"{
            return 100
        }
        return UITableView.automaticDimension
    }
}

