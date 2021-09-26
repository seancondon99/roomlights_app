//
//  TableViewController.swift
//  Amplitude Controller
//
//  Created by Sean Condon on 8/20/19.
//  Copyright © 2019 Amplitude Lighting. All rights reserved.
//

import UIKit
import CoreBluetooth

var bleDevices = [CBPeripheral]()
var selectedDeviceIndex = 0

var universalCharacteristic = [CBCharacteristic]()


class TableViewController: UITableViewController {
    
    
    var centralManager: CBCentralManager!

    override func viewDidLoad() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        

        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("RUNNING TABLE VIEW ROW NUM")
        return bleDevices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rows", for: indexPath)
       // cell.textLabel?.text = tableRows[indexPath.row]
        
        if bleDevices[indexPath.row].name != nil{
            
            cell.textLabel?.text = bleDevices[indexPath.row].name
        }else{
            cell.textLabel?.text = bleDevices[indexPath.row].identifier.uuidString
        }
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDeviceIndex = indexPath.row
        centralManager.stopScan()
        bleDevices[selectedDeviceIndex].delegate = self
        //centralManager.connect(bleDevices[selectedDeviceIndex])
        performSegue(withIdentifier: "segueBluetoothZoom", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let vc = segue.destination as! ViewController
        vc.centralManager = self.centralManager

    }
    

}

extension TableViewController: CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state{
        case .unknown:
            print("Bluetooth is unknown")
        case .resetting:
            print("Bluetooth is resetting")
        case .unsupported:
            print("Bluetooth is unsupported")
        case .unauthorized:
            print("Bluetooth is unauthorized")
        case .poweredOff:
            print("Bluetooth is off")
        case .poweredOn:
            centralManager.scanForPeripherals(withServices: [CBUUID(string: "0000FFE0-0000-1000-8000-00805F9B34FB")])
            print("Bluetooth is on")
        @unknown default:
            print("Bluetooth is idk")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !bleDevices.contains(peripheral){
            bleDevices.append(peripheral)
        }
        print(bleDevices.count)
        print(bleDevices[0])
        tableView.reloadData()
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected!")
        peripheral.discoverServices([CBUUID(string: "0000FFE0-0000-1000-8000-00805F9B34FB")])
        
    }
}


extension TableViewController: CBPeripheralDelegate {

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
          print(service)
          peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics {
            universalCharacteristic = [characteristic]
            if characteristic.properties.contains(.read) {
              print("\(characteristic.uuid): properties contains .read")
            }
            if characteristic.properties.contains(.notify) {
              print("\(characteristic.uuid): properties contains .notify")
            }
            if characteristic.properties.contains(.writeWithoutResponse) {
              print("\(characteristic.uuid): properties contains .writewithoutresponse")
            }
        
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
    error: Error?) {
        for val in characteristic.value!{
            print(val)
        }
    }
    

    
}
