//
//  ViewController3.swift
//  Annoyer Mobile
//
//  Created by Tyler Knox on 9/3/17.
//  Copyright © 2017 tyler58546. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox



class ViewController3: UIViewController {
    
    public func platform() -> String {
    var sysinfo = utsname()
    uname(&sysinfo)
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    public var hasHapticFeedback: Bool {
        return ["iPhone9,1", "iPhone9,3", "iPhone9,2", "iPhone9,4", "iPhone8,1", "iPhone8,2"].contains(platform())
    }

    @IBOutlet weak var brightSlider: UISlider!
    @IBOutlet weak var h1: UIButton!
    @IBOutlet weak var h2: UIButton!
    @IBOutlet weak var h3: UIButton!
    
    var lightOn = false
    
    
    @IBAction func flashToggle(_ sender: Any) {
        toggleFlash(brightness: brightSlider.value)
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        if (lightOn) {
            toggleFlash(brightness: brightSlider.value)
            toggleFlash(brightness: brightSlider.value)
        }
    }
    
    
    @IBAction func vibrate(_ sender: Any) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
    @IBAction func peek(_ sender: Any) {
        AudioServicesPlaySystemSound(1519) // Actuate `Peek` feedback (weak boom)
    }
    
    @IBAction func pop(_ sender: Any) {
        AudioServicesPlaySystemSound(1520) // Actuate `Pop` feedback (strong boom)
    }
    
    @IBAction func nope(_ sender: Any) {
        AudioServicesPlaySystemSound(1521) // Actuate `Nope` feedback (series of three weak booms)
    }
    
    
    func toggleFlash(brightness: Float) {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                if (device?.torchMode == AVCaptureDevice.TorchMode.on) {
                    device?.torchMode = AVCaptureDevice.TorchMode.off
                    lightOn = false
                } else {
                    do {
                        try device?.setTorchModeOn(level: brightness)
                        lightOn = true
                    } catch {
                        print(error)
                    }
                }
                device?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (!hasHapticFeedback) {
            h1.isEnabled = false
            h2.isEnabled = false
            h3.isEnabled = false
        }
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
