# roomlights_app
This repo contains the code to remotely control LED lights with an iPhone app implemented in swift. The lights that can be controlled by this app are found in "fullmaster.ino" of my public repo "roomlights_teensy," so please go there if you would like to see how the microcontroller code handles messages from the iPhone app. Additionally, more info on this project, as well as some demos, can be found on my personal website at https://seancondon99.github.io/.

All of the code relevant for running the app can be found in the Amplitude Controller subfolder. And I will now provide a quick breakdown on the files in that folder.

## Overview of Files

#### Amplitude Controller/*

There are a few helper files in this folder that assist xCode in setting up and running the project. These are AppDelegate.swift, info.Plist, and SceneDelegate.swift. Most of the code in these files has been untouched, with the exception of some brief global class and variable descriptions, so I won't go into much detail on these files.

#### Amplitude Controller/ViewController.swift

This is the main file of the app that allows a user to connect to bluetooth devices in the area with the correct ID (corresponding to the Teensy's BLE ID), and send an on / off command to that bluetooth device.

#### Amplitude Controller/TableViewController.swift

An add-on to ViewController.swift that handles the table view of all BLE enabled devices found near a user. Users can connect to a bluetooth device in this table view by tapping on its name. 

#### Amplitude Controller/ChangeConfigViewController.swift

An under-developement view that allows a user to send the Teensy a configuration string that will change some properties of the lights (i.e. change their mode from FFT to volume EQ, change their color scheme, change the pixel decay times, etc).
