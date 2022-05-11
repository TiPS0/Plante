//
//  fetchData.swift
//  IoT_Farm
//
//  Created by Tipso on 14/3/2565 BE.
//

import Foundation
import FirebaseDatabase

class dataFirebase: ObservableObject {
    
    @Published var name1: String = ""
    @Published var state1: String = ""
    @Published var date1: String = ""
    @Published var timeS1: String = ""
    
    @Published var light1: String = ""
    @Published var lightMax1: String = ""
    @Published var water1: String = ""
    @Published var waterMax1: String = ""
    
    @Published var H1: String = ""
    
//    ### ### ###
    
    @Published var name2: String = ""
    @Published var state2: String = ""
    @Published var date2: String = ""
    @Published var timeS2: String = ""
    
    @Published var light2: String = ""
    @Published var lightMax2: String = ""
    @Published var water2: String = ""
    @Published var waterMax2: String = ""
    
    @Published var H2: String = ""
    
//    ### ### ###
    
    @Published var name3: String = ""
    @Published var state3: String = ""
    @Published var date3: String = ""
    @Published var timeS3: String = ""
    
    @Published var light3: String = ""
    @Published var lightMax3: String = ""
    @Published var water3: String = ""
    @Published var waterMax3: String = ""
    
    @Published var H3: String = ""
    
//    ### ### ### ### ###
    
    @Published var fan: String = ""
    @Published var wifi: String = ""
    @Published var address: String = ""
    
    @Published var date: String = ""
    @Published var celsius: String = ""
    @Published var fahrenheit: String = ""
    @Published var humidity: String = ""
    
    func fetchData() {
        let ref: DatabaseReference = Database.database().reference()
        
        ref.child("Analog").child("Level1").observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                self.name1 = dictionary["name"] as? String ?? "ERROR"
                self.state1 = dictionary["state"] as? String ?? "false"
                self.date1 = dictionary["date"] as? String ?? "ERROR"
                self.timeS1 = dictionary["timeStamp"] as? String ?? "ERROR"
                
                self.light1 = dictionary["light"] as? String ?? "false"
                self.lightMax1 = dictionary["lightMax"] as? String ?? "0.0"
                self.water1 = dictionary["water"] as? String ?? "false"
                self.waterMax1 = dictionary["waterMax"] as? String ?? "20.0"
                
                self.H1 = dictionary["percent"] as? String ?? "ERROR"
            }
        }) { (error) in
            print("Error \(error.localizedDescription)")

            return
        }

        ref.child("Analog").child("Level2").observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                self.name2 = dictionary["name"] as? String ?? "ERROR"
                self.state2 = dictionary["state"] as? String ?? "false"
                self.date2 = dictionary["date"] as? String ?? "ERROR"
                self.timeS2 = dictionary["timeStamp"] as? String ?? "ERROR"
                
                self.light2 = dictionary["light"] as? String ?? "false"
                self.lightMax2 = dictionary["lightMax"] as? String ?? "0.0"
                self.water2 = dictionary["water"] as? String ?? "false"
                self.waterMax2 = dictionary["waterMax"] as? String ?? "20.0"
                
                self.H2 = dictionary["percent"] as? String ?? "ERROR"
            }
        }) { (error) in
            print("Error \(error.localizedDescription)")

            return
        }

        ref.child("Analog").child("Level3").observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                self.name3 = dictionary["name"] as? String ?? "ERROR"
                self.state3 = dictionary["state"] as? String ?? "false"
                self.date3 = dictionary["date"] as? String ?? "ERROR"
                self.timeS3 = dictionary["timeStamp"] as? String ?? "ERROR"
                
                self.light3 = dictionary["light"] as? String ?? "false"
                self.lightMax3 = dictionary["lightMax"] as? String ?? "0.0"
                self.water3 = dictionary["water"] as? String ?? "false"
                self.waterMax3 = dictionary["waterMax"] as? String ?? "20.0"
                
                self.H3 = dictionary["percent"] as? String ?? "ERROR"
            }
        }) { (error) in
            print("Error \(error.localizedDescription)")

            return
        }
        
//        ### ### ### ### ###
        
        ref.child("data").observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                self.fan = dictionary["Fans"] as? String ?? "false"
                self.wifi = dictionary["WiFi"] as? String ?? "false"
                self.address = dictionary["IP_Address"] as? String ?? "ERROR"
                
                self.date = dictionary["updated"] as? String ?? "ERROR"
                self.celsius = dictionary["celsius"] as? String ?? "ERROR"
                self.fahrenheit = dictionary["fahrenheit"] as? String ?? "ERROR"
                self.humidity = dictionary["humidity"] as? String ?? "ERROR"
            }
            
        }) { (error) in
            print("Error \(error.localizedDescription)")
            
            return
        }
        
    }
    
}

