//
//  ChangeConfigViewController.swift
//  Amplitude Controller
//
//  Created by Sean Condon on 8/23/19.
//  Copyright © 2019 Amplitude Lighting. All rights reserved.
//

import UIKit

//we'll handle all changes with a global config string varible
var configString = "off"


class ChangeConfigViewController: UIViewController {
    
    @IBOutlet weak var configStringLabel: UILabel!
    
    @IBOutlet weak var onOffButton: UIButton!
    
    @IBOutlet weak var volumeModeButton: UIButton!
    @IBOutlet weak var fftModeButton: UIButton!
    @IBOutlet weak var rainbowModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStringLabel.text = "Config: "
        configStringLabel.text! += configString
        // Do any additional setup after loading the view.
        onOffButton.setTitle("Turn On", for: UIControl.State.normal)
        volumeModeButton.isHidden = true
        fftModeButton.isHidden = true
        rainbowModeButton.isHidden = true
    }
    
    @IBAction func onOffButtonPress(_ sender: Any) {
        if (onOffButton.titleLabel?.text == "Turn On"){
            //update button title
            onOffButton.setTitle("Turn Off", for: UIControl.State.normal)
            //set to default fft config string
            configString = "on-fft-params"
            configStringLabel.text = "Config: "
            configStringLabel.text! += configString
            //update hidden buttons
            fftModeButton.isHidden = true
            rainbowModeButton.isHidden = false
            volumeModeButton.isHidden = false
            
            
        } else if (onOffButton.titleLabel?.text == "Turn Off"){
            //update config, buttons hidden, button title
            onOffButton.setTitle("Turn On", for: UIControl.State.normal)
            configString = "off"
            configStringLabel.text = "Config: "
            configStringLabel.text! += configString
            //update hidden buttons
            volumeModeButton.isHidden = true
            fftModeButton.isHidden = true
            rainbowModeButton.isHidden = true
            
        }
    }
    
    
    @IBAction func volumeButtonClick(_ sender: Any) {
        //update hidden buttons
        volumeModeButton.isHidden = true
        fftModeButton.isHidden = false
        rainbowModeButton.isHidden = false
        
        //update config
        configString = "on-vol-params"
        configStringLabel.text = "Config: "
        configStringLabel.text! += configString
    }
    
    @IBAction func rainbowButtonClick(_ sender: Any) {
        //update hidden buttons
        volumeModeButton.isHidden = false
        fftModeButton.isHidden = false
        rainbowModeButton.isHidden = true
                
        //update config
        configString = "on-ran-params"
        configStringLabel.text = "Config: "
        configStringLabel.text! += configString
    }
    
    @IBAction func fftButtonClick(_ sender: Any) {
        //update hidden buttons
        volumeModeButton.isHidden = false
        fftModeButton.isHidden = true
        rainbowModeButton.isHidden = false
                
        //update config
        configString = "on-fft-params"
        configStringLabel.text = "Config: "
        configStringLabel.text! += configString
    }
    

}
