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
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    
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
        
        appNameLabel.font = UIFont(name: "Helvetica-Light", size: 50)
        
        emptyButton.layer.cornerRadius = 5
        emptyButton.layer.borderWidth = 1
        emptyButton.layer.borderColor = UIColor.white.cgColor
        emptyButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,0)

        classesButton.layer.cornerRadius = 5
        classesButton.layer.borderWidth = 1
        classesButton.layer.borderColor = UIColor.white.cgColor
        classesButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
