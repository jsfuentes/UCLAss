//
//  LaunchViewController.swift
//  HackSprint
//
//  Created by Katie Cai on 3/2/18.
//  Copyright © 2018 Katie Cai. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var emptyButton: UIButton!
    @IBOutlet weak var classesButton: UIButton!
    
    // Empty classroom = 0
    // Fun classes = 1
    var clicked: Int!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? SearchViewController {
            if let button = sender as? UIButton {
                destination.option = button.tag
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyButton.tag = 0
        classesButton.tag = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
