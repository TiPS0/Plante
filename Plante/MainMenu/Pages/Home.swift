//
//  Home.swift
//  IoT_Farm
//
//  Created by Tipso on 20/3/2565 BE.
//

import SwiftUI
import FirebaseDatabase

struct Home: View {
    @ObservedObject var showData = dataFirebase()
    
    @State var fanState: Bool = false
    
    init() {
        self.showData.fetchData()
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black.withAlphaComponent(0.50)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.25)
    }
    
    var body: some View {
        NavigationView {
            
            ZStack() {
                Color(red: 241/255, green: 249/255, blue: 235/255).ignoresSafeArea()
                
                VStack(alignment: .leading, content: {
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("\(Date.now.formatted(.dateTime.weekday(.wide).day().month(.wide).year()))")
                            .font(.custom("ProximaNovaA-Regular", size: 13))
                            .foregroundColor(.black)
                        Text("\(Date.now.formatted(.dateTime.hour().minute().second())) (GMT+7)")
                            .font(.custom("ProximaNovaA-Regular", size: 13))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                    .padding(.top, -50)
                    .padding(.trailing, 20)
                        
                    VStack() {
                        HStack() {
                            Image("menu-1")
                                .resizable()
                                .frame(width: 38, height: 170)
                                .padding(.trailing, 20)
                            Image("menu-2")
                                .resizable()
                                .frame(width: 260, height: 170)
                            Image("menu-3")
                                .resizable()
                                .frame(width: 38, height: 170)
                                .padding(.leading, 20)
                        }
                    }
                    .padding(.top, -14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                ScrollView {
                    VStack(alignment: .leading, spacing: 20, content: {
                        
                        HStack(spacing: 10) {   //Max Width = 390
                            ZStack() {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 8)
                                    .padding(.leading, 10)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Image("shelf")
                                        .padding([.top, .leading], 4)
                                    
                                    Text("สถานะการใช้งาน")
                                        .font(.custom("Kanit-Regular", size: 10))
                                        .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                        .padding(.leading, 8)
                                    
                                    HStack(spacing: 0) {
                                        Text("ชั้นที่ 1 :")
                                            .font(.custom("Kanit-Regular", size: 11))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 14)
                                        
                                        Text(Bool(showData.state1) ?? false ? "Online" : "Offline")
                                            .font(.custom("Kanit-Bold", size: 12))
                                            .foregroundColor(Bool(showData.state1) ?? false ?
                                            Color(red: 6/255, green: 73/255, blue: 44/255) :
                                            Color(red: 6/255, green: 73/255, blue: 44/255, opacity: 0.4))
                                        
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.trailing, 12)
                                    }
                                    
                                    HStack(spacing: 0) {
                                        Text("ชั้นที่ 2 :")
                                            .font(.custom("Kanit-Regular", size: 11))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 14)
                                        
                                        Text(Bool(showData.state2) ?? false ? "Online" : "Offline")
                                            .font(.custom("Kanit-Bold", size: 12))
                                            .foregroundColor(Bool(showData.state2) ?? false ?
                                            Color(red: 6/255, green: 73/255, blue: 44/255) :
                                            Color(red: 6/255, green: 73/255, blue: 44/255, opacity: 0.4))
                                            
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.trailing, 12)
                                    }
                                    
                                    HStack(spacing: 0) {
                                        Text("ชั้นที่ 3 :")
                                            .font(.custom("Kanit-Regular", size: 11))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 14)
                                        
                                        Text(Bool(showData.state3) ?? false ? "Online" : "Offline")
                                            .font(.custom("Kanit-Bold", size: 12))
                                            .foregroundColor(Bool(showData.state3) ?? false ?
                                            Color(red: 6/255, green: 73/255, blue: 44/255) :
                                            Color(red: 6/255, green: 73/255, blue: 44/255, opacity: 0.4))
                                            
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.trailing, 12)
                                    }
                                    
                                }
                                .frame(maxWidth: 100, maxHeight: .infinity, alignment: .topLeading)
                            }
                                
                            ZStack() {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 240, height: 120)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 8)
                                    .padding(.trailing, 10)
                                
                                TabView {
                                    VStack(alignment: .leading) {
                                        Text("\(showData.name1)")
                                            .font(.custom("Kanit-Medium", size: 16))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .frame(maxWidth: 140, alignment: .leading)
                                            .padding(.top, 10)
                                        
                                        Text("เริ่มต้นการปลูก")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 10)
                                        
                                        Text(Bool(showData.state1) ?? false ? "\(showData.date1)" : "--")
                                            .font(.custom("Kanit-Medium", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 20)
                                        
                                        Text("รวมระยะเวลาการปลูก")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 10)
                                        
                                        Text("\(Bool(showData.state1) ?? false ? "\(dateRange(timeStamp: showData.timeS1))" : "--") วัน")
                                            .font(.custom("Kanit-Medium", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 20)
                                        
                                        VStack() {
                                            Image(Bool(showData.state1) ?? false ? "plant-pot-2" : "plant-pot-1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .opacity(0.85)
                                                .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 4)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.top, -80)
                                        .padding(.trailing)
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 120, alignment: .topLeading)
                                    .padding(.leading, 15)
                                    .padding(.trailing, 10)
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(showData.name2)")
                                            .font(.custom("Kanit-Medium", size: 16))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .frame(maxWidth: 140, alignment: .leading)
                                            .padding(.top, 10)
                                        
                                        Text("เริ่มต้นการปลูก")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 10)
                                        
                                        Text(Bool(showData.state2) ?? false ? "\(showData.date2)" : "--")
                                            .font(.custom("Kanit-Medium", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 20)
                                        
                                        Text("รวมระยะเวลาการปลูก")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 10)
                                        
                                        Text("\(Bool(showData.state2) ?? false ? "\(dateRange(timeStamp: showData.timeS2))" : "--") วัน")
                                            .font(.custom("Kanit-Medium", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 20)
                                        
                                        VStack() {
                                            Image(Bool(showData.state2) ?? false ? "plant-pot-2" : "plant-pot-1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .opacity(0.85)
                                                .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 4)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.top, -80)
                                        .padding(.trailing)
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 120, alignment: .topLeading)
                                    .padding(.leading, 15)
                                    .padding(.trailing, 10)
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(showData.name3)")
                                            .font(.custom("Kanit-Medium", size: 16))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .frame(maxWidth: 140, alignment: .leading)
                                            .padding(.top, 10)
                                        
                                        Text("เริ่มต้นการปลูก")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 10)
                                        
                                        Text(Bool(showData.state3) ?? false ? "\(showData.date3)" : "--")
                                            .font(.custom("Kanit-Medium", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 20)
                                        
                                        Text("รวมระยะเวลาการปลูก")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 10)
                                        
                                        Text("\(Bool(showData.state3) ?? false ? "\(dateRange(timeStamp: showData.timeS3))" : "--") วัน")
                                            .font(.custom("Kanit-Medium", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 20)
                                        
                                        VStack() {
                                            Image(Bool(showData.state3) ?? false ? "plant-pot-2" : "plant-pot-1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .opacity(0.85)
                                                .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 4)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.top, -80)
                                        .padding(.trailing)
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 120, alignment: .topLeading)
                                    .padding(.leading, 15)
                                    .padding(.trailing, 10)
                                    
                                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                .frame(width: 240, height: 140)
                                .cornerRadius(10)
                                .padding(.trailing, 10)
                                .padding(.vertical, -10.0)
                                
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack(spacing: 10) {
                            ZStack() {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 240, height: 120)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 8)
                                    .padding(.leading, 10)
                                 
                                VStack(alignment: .leading) {
                                    Image(systemName: "wifi")
                                        .resizable()
                                        .frame(width: 20, height: 16)
                                        .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                        .padding(.leading, 6)
                                        .padding(.vertical, 10)
                                    
                                    Text("Internet: \(showData.address)")
                                        .font(.custom("Kanit-Regular", size: 12))
                                        .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                        .padding(.leading, 8)
                                        .padding(.vertical, -6)
                                    
                                    HStack() {
                                        Text("Connectivity:")
                                            .font(.custom("Kanit-Medium", size: 18))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.leading, 12)
                                        
                                        Text(Bool(showData.wifi) ?? false ? "Online" : "Offline")
                                            .font(.custom("Kanit-Bold", size: 18))
                                            .foregroundColor(Bool(showData.wifi) ?? false ?
                                            Color(red: 6/255, green: 73/255, blue: 44/255) :
                                            Color(red: 6/255, green: 73/255, blue: 44/255, opacity: 0.4))
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: 120, alignment: .topLeading)
                                .padding(.leading, 15)
                                
                            }
                            
                            Button(action: {
                                self.fanState = Bool(showData.fan) ?? false
                                self.fanState.toggle()
                                
                                let ref: DatabaseReference = Database.database().reference()
                                
                                ref.child("data").updateChildValues([
                                    "Fans" : "\(fanState)"
                                ])
                            }, label: {
                                ZStack() {
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 8)
                                        .padding(.trailing, 10)
                                    
                                    VStack(alignment: .leading) {
                                        Image("fan")
                                            .padding(.top, 10)
                                        
                                        Text("สถานะการใช้งาน")
                                            .font(.custom("Kanit-Regular", size: 12))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.vertical, -6)
                                            .padding(.top, 6)
                                        
                                        HStack(spacing: 6) {
                                            Text("State:")
                                                .font(.custom("Kanit-Regular", size: 18))
                                                .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            
                                            Text(Bool(showData.fan) ?? false ? "ON" : "OFF")
                                                .font(.custom("Kanit-Bold", size: 18))
                                                .foregroundColor(Bool(showData.fan) ?? false ?
                                                Color(red: 6/255, green: 73/255, blue: 44/255) :
                                                Color(red: 6/255, green: 73/255, blue: 44/255, opacity: 0.4))
                                        }
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 120, alignment: .topLeading)
                                    .padding(.leading, 15)
                                }
                                
                            })
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        ZStack() {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 370, height: 120)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 8)
                                .padding(.horizontal, 10)
                            
                            VStack(alignment: .leading) {
                                HStack() {
                                    Image("temp")
                                        .resizable()
                                        .frame(width: 26, height: 24)
                                        .padding(.top, 10)
                                    
                                    VStack() {
                                        Text("Last Updated: \(showData.date)")
                                            .font(.custom("ProximaNovaA-Regular", size: 11))
                                            .padding(.top, 10)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    
                                }
                                .frame(width: 350, alignment: .leading)
                                
                                Text("หน่วยวัดอุณหภูมิ")
                                    .font(.custom("Kanit-Regular", size: 12))
                                    .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                    .padding(.vertical, -6)
                                    .padding(.leading, 4)
                                
                                HStack(spacing: 60) {
                                    VStack(alignment: .leading) {
                                        Text("เซลเซียส")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.vertical, -8)
                                            .padding(.top, 12)
                                            .frame(width: 70, alignment: .leading)
                                        
                                        Text("\(showData.celsius) °C")
                                            .font(.custom("Kanit-Medium", size: 16))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.trailing, 0)
                                            .frame(width: 70, alignment: .trailing)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("ฟาเรนไฮต์")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.vertical, -8)
                                            .padding(.top, 12)
                                            .frame(width: 70, alignment: .leading)
                                        
                                        Text("\(showData.fahrenheit) °F")
                                            .font(.custom("Kanit-Medium", size: 16))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.trailing, 0)
                                            .frame(width: 70, alignment: .trailing)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("ความชื้น")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.vertical, -8)
                                            .padding(.top, 12)
                                            .frame(width: 70, alignment: .leading)
                                        
                                        Text("\(showData.humidity) %H")
                                            .font(.custom("Kanit-Medium", size: 16))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.trailing, 0)
                                            .frame(width: 70, alignment: .trailing)
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 6)
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 120, alignment: .topLeading)
                            .padding(.leading, 20)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        ZStack() {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 370, height: 120)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 8)
                                .padding(.horizontal, 10)
                            
                            VStack(alignment: .leading) {
                                Image("soil")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.top, 10)
                                
                                Text("ความชื้นในดิน")
                                    .font(.custom("Kanit-Regular", size: 12))
                                    .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                    .padding(.vertical, -6)
                                    .padding(.leading, 4)
                                
                                HStack(spacing: 60) {
                                    VStack(alignment: .leading) {
                                        Text("ชั้นที่ 1")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.vertical, -8)
                                            .padding(.top, 12)
                                            .frame(width: 70, alignment: .leading)
                                        
                                        HStack(spacing: 2) {
                                            Text("\(Bool(showData.state1) ?? false ? showData.H1 : "--")")
                                                .font(.custom("Kanit-Medium", size: 16))
                                                .foregroundColor(Bool(showData.state1) ?? false ?
                                                Color(red: 6/255, green: 73/255, blue: 44/255) :
                                                Color(red: 6/255, green: 73/255, blue: 44/255, opacity: 0.5))
                                            
                                            Text("%H")
                                                .font(.custom("Kanit-Medium", size: 16))
                                                .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                        }
                                        .padding(.trailing, 0)
                                        .frame(width: 70, alignment: .trailing)
                                        
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("ชั้นที่ 2")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.vertical, -8)
                                            .padding(.top, 12)
                                            .frame(width: 70, alignment: .leading)
                                        
                                        HStack(spacing: 2) {
                                            Text("\(Bool(showData.state2) ?? false ? showData.H2 : "--")")
                                                .font(.custom("Kanit-Medium", size: 16))
                                                .foregroundColor(Bool(showData.state2) ?? false ?
                                                Color(red: 6/255, green: 73/255, blue: 44/255) :
                                                Color(red: 6/255, green: 73/255, blue: 44/255, opacity: 0.5))
                                            
                                            Text("%H")
                                                .font(.custom("Kanit-Medium", size: 16))
                                                .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                        }
                                        .padding(.trailing, 0)
                                        .frame(width: 70, alignment: .trailing)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("ชั้นที่ 3")
                                            .font(.custom("Kanit-Regular", size: 10))
                                            .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                            .padding(.vertical, -8)
                                            .padding(.top, 12)
                                            .frame(width: 70, alignment: .leading)
                                        
                                        HStack(spacing: 2) {
                                            Text("\(Bool(showData.state3) ?? false ? showData.H3 : "--")")
                                                .font(.custom("Kanit-Medium", size: 16))
                                                .foregroundColor(Bool(showData.state3) ?? false ?
                                                Color(red: 6/255, green: 73/255, blue: 44/255) :
                                                Color(red: 6/255, green: 73/255, blue: 44/255, opacity: 0.5))
                                            
                                            Text("%H")
                                                .font(.custom("Kanit-Medium", size: 16))
                                                .foregroundColor(Color(red: 6/255, green: 73/255, blue: 44/255))
                                        }
                                        .padding(.trailing, 0)
                                        .frame(width: 70, alignment: .trailing)
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 6)
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 120, alignment: .topLeading)
                            .padding(.leading, 20)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    })
                    .padding(.top, 120)
                    
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                    Text("ยินดีต้อนรับ")
                        .font(.custom("Kanit-Bold", size: 34))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    Image(systemName: "leaf.fill")
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                })
            }
            
        }
    }
    
//    Date.now.formatted(.dateTime.day().month(.twoDigits).year().hour().minute())
    func dateRange(timeStamp: String) -> Int {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MM/dd/yyyy, HH:mm a"
        let dataDate = timeStamp
        let dateNow = formatter.string(from: Date.now)
        
        let xmas = formatter.date(from: dataDate)
        let newYear = formatter.date(from: dateNow)
        var diffSeconds = newYear!.timeIntervalSinceReferenceDate - xmas!.timeIntervalSinceReferenceDate

        diffSeconds = diffSeconds / (60 * 60 * 24)
        
        return Int(diffSeconds)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
