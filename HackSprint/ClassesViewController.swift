//
//  ClassesViewController.swift
//  HackSprint
//
//  Created by Katie Cai on 3/2/18.
//  Copyright © 2018 Katie Cai. All rights reserved.
//

//FOR DEMO CHANGE LINE 100

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
    
    let today = "Wednesday, March 7, 2018 at 10:15:08 AM Pacific Standard Time"
    //        let today = Date().description(with: .current)
    
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
        
        print("Running with", today)
        getClasses(building: "Boelter")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Since swift is a little bitch and won't let me return the first letter of a String
    func getDayOfWeek() -> String {
        let today: String = Date().description(with: .current)
        let dayOfWeek = today.components(separatedBy: ",")[0]
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
    
    func getMilitaryHour(hour: Int, tp: String) -> Int {
        let timePeriod = tp.uppercased()
        var mHour = hour
        if(mHour == 12 && timePeriod == "AM"){
            mHour = 0
        } else if (mHour == 12 && timePeriod == "PM") {
            mHour = 12
        } else if (timePeriod == "PM") {
            mHour += 12
        }
        return mHour
    }
    
    func isNow(schedule: String, daysOfWeek: String) -> Bool {
        let curDayOfWeek = getDayOfWeek()
        if (daysOfWeek.range(of: curDayOfWeek) == nil) {
            return false
        }
        
        //Get Today Details
        let parts = today.components(separatedBy: " ")
        
        let time = parts[5]
        let timeParts = time.components(separatedBy: ":")
        var today_hour = Int(timeParts[0])!
        let today_minute = Int(timeParts[1])!
        
        let timePeriod = parts[6]
        today_hour = getMilitaryHour(hour: today_hour, tp: timePeriod)
        
        //Get Time Period From String
        let class_time = schedule.components(separatedBy: "-")
        let start_time = class_time[0]
        let end_time = class_time[1]
        
        var index = start_time.index(start_time.endIndex, offsetBy: -2)
        let startTimePeriod = String(start_time[index...])
        let startTime = start_time[..<index]
        
        let startParts = startTime.components(separatedBy: ":")
        var startHour = Int(startParts[0])!
        var startMinute: Int
        if (startParts.count == 2) {
            startMinute = Int(startParts[1])!
        } else {
            startMinute = 0
        }
        startHour = getMilitaryHour(hour: startHour, tp: startTimePeriod)
        
        index = end_time.index(end_time.endIndex, offsetBy: -2)
        let endTimePeriod = String(end_time[index...])
        let endTime = end_time[..<index]
        let endParts = endTime.components(separatedBy: ":")
        var endHour = Int(endParts[0])!
        var endMinute :Int
        if (endParts.count == 2) {
            endMinute = Int(endParts[1])!
        } else {
            endMinute = 0
        }
        endHour = getMilitaryHour(hour: endHour, tp: endTimePeriod)
        
        if (startHour < today_hour && today_hour < endHour) {
            return true
        }
        
        if (today_hour == startHour && today_minute >= startMinute) {
//            print("B", schedule, daysOfWeek, startHour, today_hour)
            return true
        }
        
        if (today_hour == endHour && today_minute <= endMinute) {
            return true
        }
        
        return false
    }
    
    func getClasses(building: String) {
        var filteredClasses: [uclass] = []
        
        Alamofire.request("http://api.ucladevx.com/courses/?quarter=Winter").responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("HUGGEEE Error getting shit")
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: response.data!, options: [])
            if let j = json! as? [Any] {
                for anyC in j {
                    if let c = anyC as? [String: String] {
                        let course = c["course"]
                        let subject = c["subject"]
                        
                        let instructors = c["instructors"]
                        let locations = c["locations"]
                        let day_times = c["day_times"]
                        let rawLocation = locations?.components(separatedBy: "|*|")
                        let rawInstructor = instructors?.components(separatedBy: "|*|")
                        //TODO: THIS WAS TOO MUCH EFFORT FOR LITTLE REWARD CAN FINISH LATER
//                        //Some of the locations have a new line in it: https://sa.ucla.edu/ro/ClassSearch/Results?t=18W&sBy=subject&sName=Statistics+%28STATS%29&subj=STATS&crsCatlg=13+-+Introduction+to+Statistical+Methods+for+Life+and+Health+Sciences&catlg=0013&cls_no=%25&btnIsInIndex=btn_inIndex&btnIsExchange=False
//                        var location: [String] = []
//                        var instructor: [String] = []
//                        for (i, loc) in rawLocation!.enumerated() {
//                            if (loc.range(of: "\n") != nil) {
//                                let multipleLocs = loc.components(separatedBy: "\n")
//                                for l in multipleLocs {
//                                    location.append(l)
//                                    instructor.append(rawInstructor![i])
//                                }
//                           }
//                            else {
//                                location.append(loc)
//                            }
//                        }
//                        //Get the right day time for the above cases
//                        var day_time: [String] = []
                        let raw_day_time = day_times?.components(separatedBy: "|*|")
//                        for dt in raw_day_time! {
//                            if (dt.range(of: "\n") != nil) {
//                                print(dt)
//                                let multipleDt = dt.components(separatedBy: "\n")
//                                if(multipleDt.count != 4) {
//                                    print("THIS WAS UNEXPECTED AND WILL CAUSE HUGE ERRORS")
//                                }
//
//                                day_time.append(multipleDt[0] + " ")
//                            }
//                            else {
//                                day_time.append(dt)
//                            }
//                        }

                        for (i, loc) in rawLocation!.enumerated() {
                            if (loc.range(of:building) != nil) {
                                let myClass = uclass(course: course!, subject: subject!, location: loc, instructor: rawInstructor![i], day_time: raw_day_time![i])
                                //discard classes for now, look at above TODO
                                if(myClass.day_time.range(of: "\n") == nil) {
                                    let day_time_parts = myClass.day_time.components(separatedBy: " ")
                                    let days = day_time_parts[0]
                                    let time = day_time_parts[1]
                                    if (self.isNow(schedule: time, daysOfWeek: days)) {
                                        filteredClasses.append(myClass)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
//            print(filteredClasses)
            
//            for c in filteredClasses {
//                print(c.day_time)
//            }
            print("Finished Processing Classes")
            
            //            print(buildings)
            
            //            print(String(data: response.data!, encoding: String.Encoding.utf8)!)
        }
        
    }
}
