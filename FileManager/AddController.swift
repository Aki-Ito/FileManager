//
//  AddController.swift
//  FileManager
//
//  Created by 伊藤明孝 on 2023/12/10.
//

import UIKit
import AVFoundation

class AddController: UIViewController{
    
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var slider: UISlider!
    var player = AVPlayer()
    var timeObserverToken: Any?
    
    var itemDuration: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
        setupAudioSession()
        slider.value = 0.0
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pauseBtnTapped(_ sender: Any) {
        player.pause()
    }
    
    //動画選択・表示
    @IBAction func selectVideo() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) ?? []
        picker.mediaTypes = ["public.movie"]
        
        picker.videoQuality = .typeHigh
        picker.videoExportPreset = AVAssetExportPresetHighestQuality
        
        present(picker, animated: true, completion: nil)
    }
    
    //動画再生
    //Audio sessionを動画再生向けのものに設定
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        do {
            try audioSession.setActive(true)
            //            print("audio session set active !!")
        } catch {
        }
    }
    
    //AVPlayerをAVPlayerLayerと結びつける
    private func setupPlayer() {
        playerView.player = player
        addPeriodicTimeObserver()
    }
    
    private func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                           queue: .main)
        { [weak self] time in
            // update player transport UI
            DispatchQueue.main.async {
                //print("update timer:\(CMTimeGetSeconds(time))")
                //時間表示
                print("できたら表示")
                // sliderを更新
                self?.updateSlider()
            }
        }
    }
    
    private func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    private func updateSlider() {
        let time = player.currentItem?.currentTime() ?? CMTime.zero
        if itemDuration != 0 {
            slider.value = Float(CMTimeGetSeconds(time) / itemDuration)
        }
    }
}

//MARK: imagePicker(画像、動画選択ツールが閉じた時の挙動)
extension AddController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let movieUrl = info[.mediaURL] as? URL else { return }
        
        Task{
            // replacePlayerItem
            let asset = AVAsset(url: movieUrl)
            let duration = try await asset.load(.duration)
            itemDuration = CMTimeGetSeconds(duration)
            let item = AVPlayerItem(url: movieUrl)
            player.replaceCurrentItem(with: item)
        }
    }
}
