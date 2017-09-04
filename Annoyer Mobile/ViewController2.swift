//
//  ViewController2.swift
//  Annoyer Mobile
//
//  Created by Tyler Knox on 9/3/17.
//  Copyright © 2017 tyler58546. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController2: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var stopButton: UIButton!
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["Alarm Clock", "Nails on Chalkboard", "Emergency Broadcast System", "Car Alarm", "Dog Barking", "Siren", "Birds Chirping", "???", "Baby Crying", "Fork on Glass", "Goat Screaming"]
    var images = ["alarm-clock", "nails-chalkboard", "ebs", "car-alarm", "dog-bark", "siren", "birds", "wtf", "baby-cry", "fork-glass", "goat"]
    var soundPlayer: AVAudioPlayer!
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        cell.myLabel.text = self.items[indexPath.item]
        cell.thumbnail.image = UIImage(named: self.images[indexPath.item])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        var sounds = ["alarm-clock.mp3", "nails-chalkboard.mp3", "ebs.mp3", "car-alarm.mp3", "dog-bark.mp3", "siren.mp3", "birds.mp3", "wtf.mp3", "baby-cry.mp3", "fork-glass.mp3", "goat.mp3"]
        let soundToPlay = (sounds[indexPath.item])
        print("You selected cell #\(indexPath.item)!")
        let path = Bundle.main.path(forResource: soundToPlay, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            soundPlayer = sound
            sound.play()
            stopButton.isEnabled = true
        } catch {
            // couldn't load file :(
        }

        
    }
    @IBAction func stopSounds(_ sender: Any) {
        do {
            soundPlayer.stop()
        } catch {
            //error
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
