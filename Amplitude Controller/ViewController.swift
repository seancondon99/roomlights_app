//
//  ViewController.swift
//  Amplitude Controller
//
//  Created by Sean Condon on 8/20/19.
//  Copyright © 2019 Amplitude Lighting. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    var centralManager: CBCentralManager!
    var selectedPeripheral = bleDevices[selectedDeviceIndex]

    @IBOutlet weak var bluetoothDeviceName: UILabel!
    
    
    @IBOutlet weak var onButton: UIButton!
    
    @IBOutlet weak var offButton: UIButton!
    
    @IBOutlet weak var connectButton: UIButton!
    
    @IBAction func onButtonPress(_ sender: Any) {
//we just need the characteristic to be universal!
        selectedPeripheral.writeValue("on".data(using: String.Encoding.utf8)!, for: universalCharacteristic[0], type: CBCharacteristicWriteType.withoutResponse)
        
    }
    
    @IBAction func offButtonPress(_ sender: Any) {
        selectedPeripheral.writeValue("off".data(using: String.Encoding.utf8)!, for: universalCharacteristic[0], type: CBCharacteristicWriteType.withoutResponse)
        
    }
    override func viewDidLoad() {
        
        print(centralManager.retrieveConnectedPeripherals(withServices: [CBUUID(string: "0000FFE0-0000-1000-8000-00805F9B34FB")]))
        self.bluetoothDeviceName.text = "Device Name: "
        if bleDevices[selectedDeviceIndex].name == nil{
            self.bluetoothDeviceName.text! += bleDevices[selectedDeviceIndex].identifier.uuidString
        }else{
            self.bluetoothDeviceName.text! += bleDevices[selectedDeviceIndex].name!
        }
        super.viewDidLoad()
    }
    
    
    @IBAction func connectPeripheral(_ sender: Any) {
        centralManager.connect(selectedPeripheral)
    }

}


