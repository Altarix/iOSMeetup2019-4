//
//  ViewController.swift
//  BackgroundApp
//
//  Created by AikOganisyan on 08/11/2019.
//  Copyright © 2019 icos. All rights reserved.
//

import UIKit
import AVFoundation

enum PlayerState {
    case play
    case pause
}

class AudioViewController: UIViewController {
    
    
    let timeInterval: TimeInterval = 1
    let timer = DispatchSource.makeTimerSource()
    
    var playerState: PlayerState = .pause
    var player = AVPlayer()
    var playerItem: AVPlayerItem {
        let path = Bundle.main.path(forResource: "LooseScrew", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        return AVPlayerItem(url: url)
    }
    let audioSession = AVAudioSession.sharedInstance()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "System", size: 20)
        label.text = "This label added in background"
        return label
    }()
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        playButton.setTitle("Play", for: .normal)
        playButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        setupPlayer()
        makeTask()
        anotherTask()
    }
    
    //MARK:- You any task
    private func makeTask() {
        var i = 0
        timer.schedule(deadline: .now() + timeInterval, repeating: timeInterval)
        timer.setEventHandler {
            i += 1
            print(i)
        }
        timer.resume()
    }
    
    //UI task
    private func anotherTask() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) { [unowned self] in
            self.view.addSubview(self.label)
            self.label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
            self.label.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
            self.label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
            self.label.heightAnchor.constraint(equalToConstant: 30)
            print("Label was added")
        }
    }
    
    //MARK:- Player
    private func play() {
        playButton.setTitle("Pause", for: .normal)
        playerState = .play
        player.play()
    }
    
    private func pause() {
        playButton.setTitle("Play", for: .normal)
        playerState = .pause
        player.pause()
    }
    
    private func setupPlayer() {
        player = AVPlayer(playerItem: self.playerItem)
        player.volume = 0.5
        do {
            try audioSession.setActive(true)
        } catch {
            print("Failed to activate audio session")
        }
    }
    
    @objc private func playPause() {
        switch playerState {
        case .play:
            pause()
        case .pause:
            play()
        }
    }

    private func restartPlaying() {
        player.seek(to: .zero)
        play()
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        restartPlaying()
    }
}
