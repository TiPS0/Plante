//
//  Operation.swift
//  IoT_Farm
//
//  Created by Tipso on 21/3/2565 BE.
//

import SwiftUI
import HalfASheet
import FirebaseDatabase

struct Operation: View {
    @ObservedObject var showData = dataFirebase()
    
    @State var toggleField1: Bool = false
    @State var toggleField2: Bool = false
    @State var toggleField3: Bool = false
    @State var textField: String = ""
    
    @State var toggleActive1: Bool = false
    @State var toggleLight1: Bool = false
    @State var toggleWater1: Bool = false
    
    @State var toggleActive2: Bool = false
    @State var toggleLight2: Bool = false
    @State var toggleWater2: Bool = false
    
    @State var toggleActive3: Bool = false
    @State var toggleLight3: Bool = false
    @State var toggleWater3: Bool = false
    
    @State var isShowing = false
    @State var light = 0.0
    @State var water = 20.0
    @State var page: Int = 0
    
    @State var alertShow = false
    @State var error_title = ""
    @State var error_msg = ""
    
    init() {
        self.showData.fetchData()
    }
    
    var body: some View {
        NavigationView {
            
            ZStack() {
                Color(red: 241/255, green: 249/255, blue: 235/255).ignoresSafeArea()
                
                ZStack() {
                    Color(.white)
                        .frame(maxWidth: .infinity, maxHeight: 160, alignment: .top)
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 6)
                        .padding(.top, -150)

                    Text("การทำงานแต่ละชั้น")
                        .font(.custom("Kanit-Bold", size: 32))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.top, -56)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                TabView {
                    VStack(alignment: .leading, content: {
                        HStack() {
                            
                            Text("\(showData.name1)")
                                .font(.custom("Kanit-Regular", size: 22))
                                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.7))
                                .frame(maxHeight: 22)
                            
                            Button(action: {
                                self.toggleField1.toggle()
                            }, label: {
                                Image("pen")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))

                            })
                            .frame(width: 36, height: 36)
                            .background(Color(red: 132/255, green: 167/255, blue: 88/255, opacity: 0.3))
                            .cornerRadius(20)
                            
                            Button(action: {
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: "en_US")
                                dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm a"
                                
                                self.toggleActive1 = Bool(showData.state1) ?? false
                                
                                if toggleActive1 == false {
                                    self.toggleActive1.toggle()
                                    
                                    let ref: DatabaseReference = Database.database().reference()

                                    ref.child("Analog").child("Level1").updateChildValues([
                                        "state" : "\(toggleActive1)",
                                        "date" : "\(Date.now.formatted(.dateTime.weekday(.wide).month(.wide).day().year()))",
                                        "timeStamp" : "\(dateFormatter.string(from: Date.now))"
                                    ])
                                } else {
                                    self.error_title = "Are You Sure You Want to Disable This?"
                                    self.error_msg = "All this data will be deleted and reset permanently."
                                    
                                    alertShow.toggle()
                                }
                            }, label: {
                                Rectangle()
                                    .foregroundColor(Bool(showData.state1) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)
                                    .frame(width: 68, height: 34, alignment: .center)
                                    .overlay(
                                        Circle()
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                                        .padding(.all, 4)
                                        .offset(x: Bool(showData.state1) ?? false ? 16 : -16, y: 0)
                                        .animation(Animation.linear(duration: 0.2), value: toggleActive1)
                                    )
                                    .overlay(
                                        Text(Bool(showData.state1) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 14))
                                            .foregroundColor(.white)
                                            .offset(x: Bool(showData.state1) ?? false ? -14 : 14, y: 0)
                                            .animation(Animation.linear(duration: 0.2), value: Bool(showData.state1))
                                    )
                                    .cornerRadius(20)
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .alert(isPresented: $alertShow) {
                                Alert(
                                    title: Text(error_title),
                                    message: Text(error_msg),
                                    primaryButton: .destructive(Text("Delete"), action: {
                                        self.toggleActive1.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level1").updateChildValues([
                                            "state" : "\(toggleActive1)",
                                            "light" : "false",
                                            "water" : "false",
                                            "date" : "false",
                                            "timeStamp" : "false"
                                        ])
                                    }),
                                    secondaryButton: .cancel())
                            }
                        }
                        
                        VStack(alignment: .center) {
                            Image(Bool(showData.state1) ?? false ? "plant-pot-2" : "plant-pot-1")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 4)
                            
                            Text(Bool(showData.state1) ?? false ? "\(showData.date1)" : "--")
                                .font(.custom("Kanit-Medium", size: 14))
                                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.6))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 14) {
                            HStack() {
                                Text("ระยะเวลาปลูก")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 110, alignment: .leading)
                                
                                Text(Bool(showData.state1) ?? false ? "\(dateRange(timeStamp: showData.timeS1))" : "--")
                                    .font(.custom("Kanit-Bold", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 50, height: 20, alignment: .trailing)
                                
                                Text("วัน")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            
                            HStack() {
                                Text("ความชื้นในดิน")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 110, alignment: .leading)
                                
                                Text(Bool(showData.state1) ?? false ? showData.H1 : "--")
                                    .font(.custom("Kanit-Bold", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 50, alignment: .trailing)
                                
                                Text("%H")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                        }
                        .padding(.top, 30)
                        
                        VStack(spacing: 30) {
                            VStack() {
                                HStack() {
                                    Text("ระบบไฟ")
                                        .font(.custom("Kanit-Medium", size: 24))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button(action: {
                                        self.toggleLight1 = Bool(showData.light1) ?? false
                                        self.toggleLight1.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level1").updateChildValues([
                                            "light" : "\(toggleLight1)"
                                        ])
                                    }, label: {
                                        Text(Bool(showData.light1) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 30))
                                            .foregroundColor(.white)
                                            .frame(width: 130, height: 42)
                                            .background(Bool(showData.light1) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)

                                    })
                                    .disabled(Bool(showData.state1) ?? false ? false : true)
                                    .overlay(Bool(showData.state1) ?? false ?
                                            Color(.white).opacity(0) :
                                            Color(.white).opacity(0.4))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                                }
                                
                                HStack() {
                                    Text("กำหนดระดับแสง")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .foregroundColor(.black)
                                        .opacity(0.5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(Bool(showData.state1) ?? false ? "มากกว่า \(showData.lightMax1)%" : "--")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .opacity(0.3)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.leading)
                                }
                            }
                            
                            VStack() {
                                HStack() {
                                    Text("การรดน้ำ")
                                        .font(.custom("Kanit-Medium", size: 24))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button(action: {
                                        self.toggleWater1 = Bool(showData.water1) ?? false
                                        self.toggleWater1.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level1").updateChildValues([
                                            "water" : "\(toggleWater1)"
                                        ])
                                    }, label: {
                                        Text(Bool(showData.water1) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 30))
                                            .foregroundColor(.white)
                                            .frame(width: 130, height: 42)
                                            .background(Bool(showData.water1) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)

                                    })
                                    .disabled(Bool(showData.state1) ?? false ? false : true)
                                    .overlay(Bool(showData.state1) ?? false ?
                                            Color(.white).opacity(0) :
                                            Color(.white).opacity(0.4))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                                }
                                
                                HStack() {
                                    Text("กำหนดความชื้นในดิน")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .foregroundColor(.black)
                                        .opacity(0.5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(Bool(showData.state1) ?? false ? "มากกว่า \(showData.waterMax1)%H" : "--")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .opacity(0.3)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.leading)
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal, 20)
                        
                        VStack() {
                            Button(action: {
                                self.page = 1
                                self.light = Double(showData.lightMax1) ?? 0.0
                                self.water = Double(showData.waterMax1) ?? 20.0
                                self.isShowing.toggle()
                            }, label: {
                                VStack(spacing: 6) {
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .opacity(0.25)
                                        .frame(width: 116, height: 1)
                                    
                                    Text("ตั้งค่าการทำงาน")
                                        .font(.custom("Kanit-Medium", size: 18))
                                        .foregroundColor(.black)
                                    
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .opacity(0.25)
                                        .frame(width: 116, height: 1)
                                }
                            })
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        .padding(.top, 4)
                        
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal, 22)
                    .padding(.top, 40)
                    
                    VStack(alignment: .leading, content: {
                        HStack() {
                            
                            Text("\(showData.name2)")
                                .font(.custom("Kanit-Regular", size: 22))
                                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.7))
                                .frame(maxHeight: 22)
                            
                            Button(action: {
                                self.toggleField2.toggle()
                            }, label: {
                                Image("pen")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))

                            })
                            .frame(width: 36, height: 36)
                            .background(Color(red: 132/255, green: 167/255, blue: 88/255, opacity: 0.3))
                            .cornerRadius(20)
                            
                            Button(action: {
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: "en_US")
                                dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm a"
                                
                                self.toggleActive2 = Bool(showData.state2) ?? false
                                
                                if toggleActive2 == false {
                                    self.toggleActive2.toggle()
                                    
                                    let ref: DatabaseReference = Database.database().reference()

                                    ref.child("Analog").child("Level2").updateChildValues([
                                        "state" : "\(toggleActive2)",
                                        "date" : "\(Date.now.formatted(.dateTime.weekday(.wide).month(.wide).day().year()))",
                                        "timeStamp" : "\(dateFormatter.string(from: Date.now))"
                                    ])
                                } else {
                                    self.error_title = "Are You Sure You Want to Disable This?"
                                    self.error_msg = "All this data will be deleted and reset permanently."
                                    
                                    alertShow.toggle()
                                }
                            }, label: {
                                Rectangle()
                                    .foregroundColor(Bool(showData.state2) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)
                                    .frame(width: 68, height: 34, alignment: .center)
                                    .overlay(
                                        Circle()
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                                        .padding(.all, 4)
                                        .offset(x: Bool(showData.state2) ?? false ? 16 : -16, y: 0)
                                        .animation(Animation.linear(duration: 0.2), value: toggleActive2)
                                    )
                                    .overlay(
                                        Text(Bool(showData.state2) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 14))
                                            .foregroundColor(.white)
                                            .offset(x: Bool(showData.state2) ?? false ? -14 : 14, y: 0)
                                            .animation(Animation.linear(duration: 0.2), value: Bool(showData.state2))
                                    )
                                    .cornerRadius(20)
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .alert(isPresented: $alertShow) {
                                Alert(
                                    title: Text(error_title),
                                    message: Text(error_msg),
                                    primaryButton: .destructive(Text("Delete"), action: {
                                        self.toggleActive2.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level2").updateChildValues([
                                            "state" : "\(toggleActive2)",
                                            "light" : "false",
                                            "water" : "false",
                                            "date" : "false",
                                            "timeStamp" : "false"
                                        ])
                                    }),
                                    secondaryButton: .cancel())
                            }
                        }
                        
                        VStack(alignment: .center) {
                            Image(Bool(showData.state2) ?? false ? "plant-pot-2" : "plant-pot-1")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 4)
                            
                            Text(Bool(showData.state2) ?? false ? "\(showData.date2)" : "--")
                                .font(.custom("Kanit-Medium", size: 14))
                                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.6))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 14) {
                            HStack() {
                                Text("ระยะเวลาปลูก")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 110, alignment: .leading)
                                
                                Text(Bool(showData.state2) ?? false ? "\(dateRange(timeStamp: showData.timeS2))" : "--")
                                    .font(.custom("Kanit-Bold", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 50, height: 20, alignment: .trailing)
                                
                                Text("วัน")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            
                            HStack() {
                                Text("ความชื้นในดิน")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 110, alignment: .leading)
                                
                                Text(Bool(showData.state2) ?? false ? showData.H2 : "--")
                                    .font(.custom("Kanit-Bold", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 50, alignment: .trailing)
                                
                                Text("%H")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                        }
                        .padding(.top, 30)
                        
                        VStack(spacing: 30) {
                            VStack() {
                                HStack() {
                                    Text("ระบบไฟ")
                                        .font(.custom("Kanit-Medium", size: 24))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button(action: {
                                        self.toggleLight2 = Bool(showData.light2) ?? false
                                        self.toggleLight2.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level2").updateChildValues([
                                            "light" : "\(toggleLight2)"
                                        ])
                                    }, label: {
                                        Text(Bool(showData.light2) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 30))
                                            .foregroundColor(.white)
                                            .frame(width: 130, height: 42)
                                            .background(Bool(showData.light2) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)

                                    })
                                    .disabled(Bool(showData.state2) ?? false ? false : true)
                                    .overlay(Bool(showData.state2) ?? false ?
                                            Color(.white).opacity(0) :
                                            Color(.white).opacity(0.4))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                                }
                                
                                HStack() {
                                    Text("กำหนดระดับแสง")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .foregroundColor(.black)
                                        .opacity(0.5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(Bool(showData.state2) ?? false ? "มากกว่า \(showData.lightMax2)%" : "--")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .opacity(0.3)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.leading)
                                }
                            }
                            
                            VStack() {
                                HStack() {
                                    Text("การรดน้ำ")
                                        .font(.custom("Kanit-Medium", size: 24))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button(action: {
                                        self.toggleWater2 = Bool(showData.water2) ?? false
                                        self.toggleWater2.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level2").updateChildValues([
                                            "water" : "\(toggleWater2)"
                                        ])
                                    }, label: {
                                        Text(Bool(showData.water2) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 30))
                                            .foregroundColor(.white)
                                            .frame(width: 130, height: 42)
                                            .background(Bool(showData.water2) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)

                                    })
                                    .disabled(Bool(showData.state2) ?? false ? false : true)
                                    .overlay(Bool(showData.state2) ?? false ?
                                            Color(.white).opacity(0) :
                                            Color(.white).opacity(0.4))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                                }
                                
                                HStack() {
                                    Text("กำหนดความชื้นในดิน")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .foregroundColor(.black)
                                        .opacity(0.5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(Bool(showData.state2) ?? false ? "มากกว่า \(showData.waterMax2)%H" : "--")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .opacity(0.3)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.leading)
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal, 20)
                        
                        VStack() {
                            Button(action: {
                                self.page = 2
                                self.light = Double(showData.lightMax2) ?? 0.0
                                self.water = Double(showData.waterMax2) ?? 20.0
                                self.isShowing.toggle()
                            }, label: {
                                VStack(spacing: 6) {
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .opacity(0.25)
                                        .frame(width: 116, height: 1)
                                    
                                    Text("ตั้งค่าการทำงาน")
                                        .font(.custom("Kanit-Medium", size: 18))
                                        .foregroundColor(.black)
                                    
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .opacity(0.25)
                                        .frame(width: 116, height: 1)
                                }
                            })
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        .padding(.top, 4)
                        
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal, 22)
                    .padding(.top, 40)
                    
                    VStack(alignment: .leading, content: {
                        HStack() {
                            
                            Text("\(showData.name3)")
                                .font(.custom("Kanit-Regular", size: 22))
                                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.7))
                                .frame(maxHeight: 22)
                            
                            Button(action: {
                                self.toggleField3.toggle()
                            }, label: {
                                Image("pen")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))

                            })
                            .frame(width: 36, height: 36)
                            .background(Color(red: 132/255, green: 167/255, blue: 88/255, opacity: 0.3))
                            .cornerRadius(20)
                            
                            Button(action: {
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: "en_US")
                                dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm a"
                                
                                self.toggleActive3 = Bool(showData.state3) ?? false
                                
                                if toggleActive3 == false {
                                    self.toggleActive3.toggle()
                                    
                                    let ref: DatabaseReference = Database.database().reference()

                                    ref.child("Analog").child("Level3").updateChildValues([
                                        "state" : "\(toggleActive3)",
                                        "date" : "\(Date.now.formatted(.dateTime.weekday(.wide).month(.wide).day().year()))",
                                        "timeStamp" : "\(dateFormatter.string(from: Date.now))"
                                    ])
                                } else {
                                    self.error_title = "Are You Sure You Want to Disable This?"
                                    self.error_msg = "All this data will be deleted and reset permanently."
                                    
                                    alertShow.toggle()
                                }
                            }, label: {
                                Rectangle()
                                    .foregroundColor(Bool(showData.state3) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)
                                    .frame(width: 68, height: 34, alignment: .center)
                                    .overlay(
                                        Circle()
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                                        .padding(.all, 4)
                                        .offset(x: Bool(showData.state3) ?? false ? 16 : -16, y: 0)
                                        .animation(Animation.linear(duration: 0.2), value: toggleActive3)
                                    )
                                    .overlay(
                                        Text(Bool(showData.state3) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 14))
                                            .foregroundColor(.white)
                                            .offset(x: Bool(showData.state3) ?? false ? -14 : 14, y: 0)
                                            .animation(Animation.linear(duration: 0.2), value: Bool(showData.state3))
                                    )
                                    .cornerRadius(20)
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .alert(isPresented: $alertShow) {
                                Alert(
                                    title: Text(error_title),
                                    message: Text(error_msg),
                                    primaryButton: .destructive(Text("Delete"), action: {
                                        self.toggleActive3.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level3").updateChildValues([
                                            "state" : "\(toggleActive3)",
                                            "light" : "false",
                                            "water" : "false",
                                            "date" : "false",
                                            "timeStamp" : "false"
                                        ])
                                    }),
                                    secondaryButton: .cancel())
                            }
                        }
                        
                        VStack(alignment: .center) {
                            Image(Bool(showData.state3) ?? false ? "plant-pot-2" : "plant-pot-1")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 4)
                            
                            Text(Bool(showData.state3) ?? false ? "\(showData.date3)" : "--")
                                .font(.custom("Kanit-Medium", size: 14))
                                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.6))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 14) {
                            HStack() {
                                Text("ระยะเวลาปลูก")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 110, alignment: .leading)
                                
                                Text(Bool(showData.state3) ?? false ? "\(dateRange(timeStamp: showData.timeS3))" : "--")
                                    .font(.custom("Kanit-Bold", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 50, height: 20, alignment: .trailing)
                                
                                Text("วัน")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            
                            HStack() {
                                Text("ความชื้นในดิน")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 110, alignment: .leading)
                                
                                Text(Bool(showData.state3) ?? false ? showData.H3 : "--")
                                    .font(.custom("Kanit-Bold", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .frame(width: 50, alignment: .trailing)
                                
                                Text("%H")
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                        }
                        .padding(.top, 30)
                        
                        VStack(spacing: 30) {
                            VStack() {
                                HStack() {
                                    Text("ระบบไฟ")
                                        .font(.custom("Kanit-Medium", size: 24))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button(action: {
                                        self.toggleLight3 = Bool(showData.light3) ?? false
                                        self.toggleLight3.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level3").updateChildValues([
                                            "light" : "\(toggleLight3)"
                                        ])
                                    }, label: {
                                        Text(Bool(showData.light3) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 30))
                                            .foregroundColor(.white)
                                            .frame(width: 130, height: 42)
                                            .background(Bool(showData.light3) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)

                                    })
                                    .disabled(Bool(showData.state3) ?? false ? false : true)
                                    .overlay(Bool(showData.state3) ?? false ?
                                            Color(.white).opacity(0) :
                                            Color(.white).opacity(0.4))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                                }
                                
                                HStack() {
                                    Text("กำหนดระดับแสง")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .foregroundColor(.black)
                                        .opacity(0.5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(Bool(showData.state3) ?? false ? "มากกว่า \(showData.lightMax3)%" : "--")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .opacity(0.3)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.leading)
                                }
                            }
                            
                            VStack() {
                                HStack() {
                                    Text("การรดน้ำ")
                                        .font(.custom("Kanit-Medium", size: 24))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button(action: {
                                        self.toggleWater3 = Bool(showData.water3) ?? false
                                        self.toggleWater3.toggle()
                                        
                                        let ref: DatabaseReference = Database.database().reference()

                                        ref.child("Analog").child("Level3").updateChildValues([
                                            "water" : "\(toggleWater3)"
                                        ])
                                    }, label: {
                                        Text(Bool(showData.water3) ?? false ? "ON" : "OFF")
                                            .font(.custom("Kanit-Bold", size: 30))
                                            .foregroundColor(.white)
                                            .frame(width: 130, height: 42)
                                            .background(Bool(showData.water3) ?? false ? Color(red: 181/255, green: 224/255, blue: 140/255) : .gray)

                                    })
                                    .disabled(Bool(showData.state3) ?? false ? false : true)
                                    .overlay(Bool(showData.state3) ?? false ?
                                            Color(.white).opacity(0) :
                                            Color(.white).opacity(0.4))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                                }
                                
                                HStack() {
                                    Text("กำหนดความชื้นในดิน")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .foregroundColor(.black)
                                        .opacity(0.5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(Bool(showData.state3) ?? false ? "มากกว่า \(showData.waterMax3)%H" : "--")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .opacity(0.3)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.leading)
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal, 20)
                        
                        VStack() {
                            Button(action: {
                                self.page = 3
                                self.light = Double(showData.lightMax3) ?? 0.0
                                self.water = Double(showData.waterMax3) ?? 20.0
                                self.isShowing.toggle()
                            }, label: {
                                VStack(spacing: 6) {
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .opacity(0.25)
                                        .frame(width: 116, height: 1)
                                    
                                    Text("ตั้งค่าการทำงาน")
                                        .font(.custom("Kanit-Medium", size: 18))
                                        .foregroundColor(.black)
                                    
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .opacity(0.25)
                                        .frame(width: 116, height: 1)
                                }
                            })
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        .padding(.top, 4)
                        
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal, 22)
                    .padding(.top, 40)
                    
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 660)
                .padding(.vertical, -20)
                
                HalfASheet(isPresented: $isShowing) {
                    VStack() {
                        Text("ตั้งค่าการทำงาน")
                            .font(.custom("Kanit-Bold", size: 18))
                            .foregroundColor(.black)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top)
                    
                    VStack() {
                        VStack() {
                            HStack() {
                                Text("กำหนดระดับแสง :")
                                    .font(.custom("Kanit-Medium", size: 16))
                                
                                Text("\(Int(light)) %")
                                    .font(.custom("Kanit-Bold", size: 16))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.bottom, -4)
                            
                            HStack() {
                                Text("0%")
                                    .font(.custom("Kanit-Bold", size: 20))
                                    .opacity(0.4)
                                    .frame(width: 42, alignment: .leading)
                                    
                                Slider(value: $light, in: 0...50)
                                    .accentColor(Color(red: 181/255, green: 224/255, blue: 140/255))
                                    .frame(width: 240)
                                Text("50%")
                                    .font(.custom("Kanit-Bold", size: 20))
                                    .opacity(0.4)
                                    .frame(width: 42, alignment: .leading)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        VStack() {
                            HStack() {
                                Text("กำหนดความชื้นในดิน :")
                                    .font(.custom("Kanit-Medium", size: 16))
                                
                                Text("\(Int(water)) %H")
                                    .font(.custom("Kanit-Bold", size: 16))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.bottom, -4)
                            
                            HStack() {
                                Text("20%")
                                    .font(.custom("Kanit-Bold", size: 20))
                                    .opacity(0.4)
                                    .frame(width: 42, alignment: .leading)
                                    
                                Slider(value: $water, in: 20...80)
                                    .accentColor(Color(red: 181/255, green: 224/255, blue: 140/255))
                                    .frame(width: 240)
                                Text("80%")
                                    .font(.custom("Kanit-Bold", size: 20))
                                    .opacity(0.4)
                                    .frame(width: 42, alignment: .leading)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical)
                        
                        
                        
                        Button(action: {
                            switch page {
                            case 1 :
                                let ref: DatabaseReference = Database.database().reference()

                                ref.child("Analog").child("Level1").updateChildValues([
                                    "lightMax" : "\(Int(light))",
                                    "waterMax" : "\(Int(water))"
                                ])
                            case 2 :
                                let ref: DatabaseReference = Database.database().reference()

                                ref.child("Analog").child("Level2").updateChildValues([
                                    "lightMax" : "\(Int(light))",
                                    "waterMax" : "\(Int(water))"
                                ])
                            case 3 :
                                let ref: DatabaseReference = Database.database().reference()

                                ref.child("Analog").child("Level3").updateChildValues([
                                    "lightMax" : "\(Int(light))",
                                    "waterMax" : "\(Int(water))"
                                ])
                            default:
                                print("Error Default")
                            }
                            
                            self.isShowing.toggle()
                        }, label: {
                            Rectangle()
                                .frame(width: 280, height: 50)
                                .foregroundColor(Color(red: 132/255, green: 167/255, blue: 88/255))
                                .cornerRadius(10)
                                .overlay(
                                    Text("Update")
                                        .font(.custom("Kanit-Bold", size: 20))
                                        .foregroundColor(.white)
                                )
                        })
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 20)
                }
                .height(.fixed(340))
                .backgroundColor(.white)
                .animation(.default, value: isShowing)
                .ignoresSafeArea()
                
            }
        }
        .popupNavigationView(horizontalPadding: 40, verticalPadding: 3.5, show: $toggleField1) {
            VStack(alignment: .leading) {
                Text("แก้ไขข้อมูล")
                    .font(.custom("Kanit-Bold", size: 26))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    .padding(.top, 26)
                
                Text("โปรดระบุชื่อที่ต้องการเปลี่ยน")
                    .font(.custom("Kanit-Regular", size: 16))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                
                TextField("\(showData.name1)", text: $textField)
                    .font(.custom("Kanit-Medium", size: 18))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(height: 2)
                    .padding(.top, -10)
                
                HStack(spacing: 10) {
                    Button(action: {
                        withAnimation {
                            textField = ""
                            self.toggleField1.toggle()
                        }
                    }, label: {
                        Text("ยกเลิก")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 90, height: 40)
                            .background(.gray)
                    })
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                    
                    Button(action: {
                        if (textField.isEmpty) {
                            textField = "\(showData.name1)"
                        }

                        let ref: DatabaseReference = Database.database().reference()

                        ref.child("Analog").child("Level1").updateChildValues([
                            "name" : textField
                        ])
                        
                        withAnimation {
                            textField = ""
                            self.toggleField1.toggle()
                        }
                    }, label: {
                        Text("ยืนยัน")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 90, height: 40)
                            .background(Color(red: 181/255, green: 224/255, blue: 140/255))
                    })
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal, 26)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationBarHidden(true)
        }
        .popupNavigationView(horizontalPadding: 40, verticalPadding: 3.5, show: $toggleField2) {
            VStack(alignment: .leading) {
                Text("แก้ไขข้อมูล")
                    .font(.custom("Kanit-Bold", size: 26))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    .padding(.top, 26)
                
                Text("โปรดระบุชื่อที่ต้องการเปลี่ยน")
                    .font(.custom("Kanit-Regular", size: 16))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                
                TextField("\(showData.name2)", text: $textField)
                    .font(.custom("Kanit-Medium", size: 18))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(height: 2)
                    .padding(.top, -10)
                
                HStack(spacing: 10) {
                    Button(action: {
                        withAnimation {
                            textField = ""
                            self.toggleField2.toggle()
                        }
                    }, label: {
                        Text("ยกเลิก")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 90, height: 40)
                            .background(.gray)
                    })
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                    
                    Button(action: {
                        if (textField.isEmpty) {
                            textField = "\(showData.name2)"
                        }

                        let ref: DatabaseReference = Database.database().reference()

                        ref.child("Analog").child("Level2").updateChildValues([
                            "name" : textField
                        ])
                        
                        withAnimation {
                            textField = ""
                            self.toggleField2.toggle()
                        }
                    }, label: {
                        Text("ยืนยัน")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 90, height: 40)
                            .background(Color(red: 181/255, green: 224/255, blue: 140/255))
                    })
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal, 26)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationBarHidden(true)
        }
        .popupNavigationView(horizontalPadding: 40, verticalPadding: 3.5, show: $toggleField3) {
            VStack(alignment: .leading) {
                Text("แก้ไขข้อมูล")
                    .font(.custom("Kanit-Bold", size: 26))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    .padding(.top, 26)
                
                Text("โปรดระบุชื่อที่ต้องการเปลี่ยน")
                    .font(.custom("Kanit-Regular", size: 16))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                
                TextField("\(showData.name3)", text: $textField)
                    .font(.custom("Kanit-Medium", size: 18))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(height: 2)
                    .padding(.top, -10)
                
                HStack(spacing: 10) {
                    Button(action: {
                        withAnimation {
                            textField = ""
                            self.toggleField3.toggle()
                        }
                    }, label: {
                        Text("ยกเลิก")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 90, height: 40)
                            .background(.gray)
                    })
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                    
                    Button(action: {
                        if (textField.isEmpty) {
                            textField = "\(showData.name3)"
                        }

                        let ref: DatabaseReference = Database.database().reference()

                        ref.child("Analog").child("Level3").updateChildValues([
                            "name" : textField
                        ])
                        
                        withAnimation {
                            textField = ""
                            self.toggleField3.toggle()
                        }
                    }, label: {
                        Text("ยืนยัน")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 90, height: 40)
                            .background(Color(red: 181/255, green: 224/255, blue: 140/255))
                    })
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal, 26)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationBarHidden(true)
        }
    }
    
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

struct Operation_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
//        Operation()
    }
}
