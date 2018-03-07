//
//  ClassesViewController.swift
//  HackSprint
//
//  Created by Katie Cai on 3/2/18.
//  Copyright © 2018 Katie Cai. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class ClassesViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView?
    @IBOutlet weak var tableView: UITableView!
        
    var building: String!
    var geocoords: (Double, Double)!
    
    var option: Int!
    
    override func viewDidLoad() {
//        print(building)
//        print(geocoords)
//        print(option)
        
        super.viewDidLoad()
        
        let lat = geocoords.0
        let long = geocoords.1
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 18.0)
        mapView?.camera = camera
        let camera_update = GMSCameraUpdate.setCamera(camera)
        mapView?.moveCamera(camera_update)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = building
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Since swift is a little bitch and won't let me return the first letter of a String
    func getDayOfWeek() -> String {
        let today: String = Date().description(with: .current)
        let dayOfWeek = today.components(separatedBy: ",")[0]
        print(dayOfWeek)
        if (dayOfWeek == "Monday") {
            return "M"
        }
        else if (dayOfWeek == "Tuesday") {
            return "T"
        }
        else if (dayOfWeek == "Wednesday") {
            return "W"
        }
        else if (dayOfWeek == "Thursday") {
            return "R"
        }
        else if (dayOfWeek == "Friday") {
            return "F"
        }
        else if (dayOfWeek == "Saturday") {
            return "S"
        }
        else {
            return "S"
        }
    }
    
    func getClasses(building: String) {
        var filteredClasses: [uclass] = []
        
        Alamofire.request("http://api.ucladevx.com/courses/?quarter=Winter").responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("HUGGEEE Error getting shit")
                return
            }
            
            print(type(of:response.data))
            let json = try? JSONSerialization.jsonObject(with: response.data!, options: [])
            if let j = json! as? [Any] {
                for anyC in j {
                    if let c = anyC as? [String: String] {
                        let course = c["course"]
                        let subject = c["subject"]
                        
                        let instructors = c["instructors"]
                        let locations = c["locations"]
                        let day_times = c["day_times"]
                        var location = locations?.components(separatedBy: "|*|")
                        var instructor = instructors?.components(separatedBy: "|*|")
                        var day_time = day_times?.components(separatedBy: "|*|")
                        for (i, loc) in location!.enumerated() {
                            if (loc.range(of:building) != nil) {
                                let myClass = uclass(course: course!, subject: subject!, location: loc, instructor: instructor![i], day_time: day_time![i])
                                filteredClasses.append(myClass)
                            }
                        }
                    }
                }
            }
            
            //            print(filteredClasses)
            
            //            for c in filteredClasses {
            //                var day_time = c.day_time.replacingOccurrences(of: "\n", with: "")
            //                print(day_time)
            //            }
            
            //            print(buildings)
            
            //            print(String(data: response.data!, encoding: String.Encoding.utf8)!)
        }
        
    }
}
