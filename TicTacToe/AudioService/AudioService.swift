//
//  SoundService.swift
//  TicTacToe
//
//  Created by Вадим on 10.04.2024.
//

import AVFoundation
import UIKit

public protocol AudioServiceProtocol {
    func playBackgroundMusic()
    func playCrossActionSound()
    func playCircleActionSound()
}

public final class AudioService: AudioServiceProtocol {
    public static let shared = AudioService()
    
    private var backgroundMusic: AVAudioPlayer?
    private var crossActionSound: AVAudioPlayer?
    private var circleActionSound: AVAudioPlayer?
    
    init() {
        guard let audioURL = Bundle.main.url(forResource: "ClozeeKoto", withExtension: "mp3") else { return }
        backgroundMusic = try? AVAudioPlayer(contentsOf: audioURL)
        
        guard let audioURL = Bundle.main.url(forResource: "crossSwing", withExtension: "mp3") else { return }
        crossActionSound = try? AVAudioPlayer(contentsOf: audioURL)
        
        guard let audioURL = Bundle.main.url(forResource: "circleSwing", withExtension: "mp3") else { return }
        circleActionSound = try? AVAudioPlayer(contentsOf: audioURL)
    }
    
    public func playBackgroundMusic() {
        playBackgroundMusic(player: backgroundMusic)
    }
    
    public func playCrossActionSound() {
        playActionSound(player: crossActionSound)
    }
    
    public func playCircleActionSound() {
        playActionSound(player: circleActionSound)
    }
    
    private func playBackgroundMusic(player: AVAudioPlayer?) {
        DispatchQueue.global(qos: .userInteractive).async {
            player?.play()
            player?.volume = 0.02
        }
    }
    
    private func playActionSound(player: AVAudioPlayer?) {
        DispatchQueue.global(qos: .userInteractive).async {
            player?.play()
            player?.volume = 0.3
        }
    }
}

