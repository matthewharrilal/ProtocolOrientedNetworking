//
//  ViewController.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/7/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
        getPokemon(name: "pikachu") { (pokemon, error) in
            
        }
    }


}

