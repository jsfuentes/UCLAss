//
//  DetailsViewController.swift
//  HackSprint
//
//  Created by Audrey Pham on 3/7/18.
//  Copyright © 2018 Katie Cai. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(filteredClasses.count == 0){
            courseLabel.text = "No class details"
            return
        }
        courseLabel.text = filteredClasses[myIndex].course
        subjectLabel.text = filteredClasses[myIndex].subject
        instructorLabel.text = filteredClasses[myIndex].instructor
        locationLabel.text = filteredClasses[myIndex].location
        timeLabel.text = filteredClasses[myIndex].day_time
        typeLabel.text = filteredClasses[myIndex].course_type
        
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
