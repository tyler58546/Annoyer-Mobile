//
//  ViewController.swift
//  Annoyer Mobile
//
//  Created by Tyler Knox on 8/31/17.
//  Copyright © 2017 tyler58546. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var toneSelector: UISegmentedControl!
    @IBOutlet weak var voiceSelector: UISegmentedControl!
    @IBOutlet weak var ttsField: UITextField!
    
    var tonePlayer: AVAudioPlayer!
    
    @IBAction func sayButtonPressed(_ sender: Any) {
        
        let voiceid = voiceSelector.selectedSegmentIndex
        var voicelang = "en-US"
        
        
        
        if (voiceid == 0) {voicelang = "en-GB"}
        if (voiceid == 1) {voicelang = "en-IE"}
        if (voiceid == 2) {voicelang = "en-US"}
        if (voiceid == 3) {voicelang = "en-ZA"}
        
        let string = ttsField.text
        let utterance = AVSpeechUtterance(string: string!)
        utterance.voice = AVSpeechSynthesisVoice(language: voicelang)
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    @IBAction func tonePlayButtonPressed(_ sender: Any) {
        let toneid = toneSelector.selectedSegmentIndex
        var file = "1000hz.wav"
        
        if (toneid != 4) {
            
            
            if (toneid == 0) {file = "1000hz.wav"}
            if (toneid == 1) {file = "5000hz.wav"}
            if (toneid == 2) {file = "10000hz.wav"}
            if (toneid == 3) {file = "15000hz.wav"}
            
            let path = Bundle.main.path(forResource: file, ofType:nil)!
            let url = URL(fileURLWithPath: path)
        
            do {
                let sound = try AVAudioPlayer(contentsOf: url)
                tonePlayer = sound
                sound.play()
            } catch {
                // couldn't load file :(
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

