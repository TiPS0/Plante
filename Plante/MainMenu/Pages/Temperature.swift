//
//  Temperature.swift
//  IoT_Farm
//
//  Created by Tipso on 20/3/2565 BE.
//

import SwiftUI
import FirebaseDatabase

struct Temperature: View {
    @ObservedObject var showData = dataFirebase()
    
    @State var info: Bool = false
    
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
                    
                    Text("อุณหภูมิ")
                        .font(.custom("Kanit-Bold", size: 32))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.top, -56)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                VStack() {
                    VStack() {
                        Text("\(Int(Float(showData.celsius) ?? 0))°c")
                            .font(.custom("Kanit-Medium", size: 100))
                            .foregroundColor(.black)
                            .padding(.top, 50)

                        Text("Average Temperature")
                            .font(.custom("ProximaNovaA-Regular", size: 14))
                            .foregroundColor(.primary)
                            .opacity(0.6)
                            .padding(.top , -116)

                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                ZStack(alignment: .leading) {
                    HStack() {
                        VStack(alignment: .leading) {
                            Text("หน่วยวัดอุณหภูมิ")
                                .font(.custom("Kanit-Medium", size: 18))
                                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            
                            Text("Last Updated: \(showData.date)")
                                .font(.custom("ProximaNovaA-Regular", size: 12))
                                .foregroundColor(.primary)
                                .opacity(0.6)
                                .padding(.top, -18)
                        }
                        
                        Button(action: {
                            let ref: DatabaseReference = Database.database().reference()
                            
                            ref.child("data").updateChildValues([
                                "process" : true,
                                "updated" : "\(Date.now.formatted(.dateTime.month().day().hour().minute()))"
                            ])
                        }, label: {
                            Text("Refresh")
                                .font(.custom("Kanit-Medium", size: 16))
                                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                .frame(width: 80, height: 30)
                                .background(Color(red: 132/255, green: 167/255, blue: 88/255, opacity: 0.4))
                                .cornerRadius(20)

                        })
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 24)
                    }
                    .padding(.leading, 22)
                    .padding(.top, -140)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        HStack() {  // "°C"
                            ZStack() {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color(red: 132/255, green: 167/255, blue: 88/255, opacity: 0.4))
                                    .cornerRadius(50)
                                
                                Image(systemName: "thermometer")
                                    .resizable()
                                    .frame(width: 16, height: 26)
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Celsius")
                                    .font(.custom("Kanit-Medium", size: 20))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .padding(.bottom, -14)
                                
                                Text("เซลเซียส")
                                    .font(.custom("Kanit-Regular", size: 14))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.8))
                            }
                            .padding(.leading, 8)
                            
                            HStack() {
//                                Text("12.34")
                                Text("\(showData.celsius)")
                                    .font(.custom("Kanit-Medium", size: 22))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                
                                Text("°C")
                                    .font(.custom("Kanit-Medium", size: 28))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 26)
                        }
                        
                        HStack() {  // "°F"
                            ZStack() {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color(red: 132/255, green: 167/255, blue: 88/255, opacity: 0.4))
                                    .cornerRadius(50)
                                
                                Image(systemName: "thermometer")
                                    .resizable()
                                    .frame(width: 16, height: 26)
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Fahrenheit")
                                    .font(.custom("Kanit-Medium", size: 20))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .padding(.bottom, -14)
                                
                                Text("ฟาเรนไฮต์")
                                    .font(.custom("Kanit-Regular", size: 14))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.8))
                            }
                            .padding(.leading, 8)
                            
                            HStack() {
//                                Text("12.34")
                                Text("\(showData.fahrenheit)")
                                    .font(.custom("Kanit-Medium", size: 22))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                
                                Text("°F")
                                    .font(.custom("Kanit-Medium", size: 28))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 26)
                        }
                        
                        HStack() {  // "%H"
                            ZStack() {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color(red: 132/255, green: 167/255, blue: 88/255, opacity: 0.4))
                                    .cornerRadius(50)
                                
                                Image(systemName: "humidity")
                                    .resizable()
                                    .frame(width: 22, height: 16)
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Humidity")
                                    .font(.custom("Kanit-Medium", size: 20))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                    .padding(.bottom, -14)
                                
                                Text("ความชื้น")
                                    .font(.custom("Kanit-Regular", size: 14))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.8))
                            }
                            .padding(.leading, 8)
                            
                            HStack() {
                                Text("\(showData.humidity)")
                                    .font(.custom("Kanit-Medium", size: 22))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                                
                                Text("%")
                                    .font(.custom("Kanit-Medium", size: 28))
                                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 26)
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.top, 50)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 130)
                
                VStack() {
                    Image("plant-vector")
                        .resizable()
                        .frame(width: 340, height: 160)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 6)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, -40)
                
            }
            .toolbar {
                Button(action: {
                    withAnimation {
                        self.info.toggle()
                    }
                }, label: {
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.top, 6)
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                })
            }
            
        }
        .popupNavigationView(horizontalPadding: 40, show: $info) {
            TabView {
                VStack(alignment: .leading) {
                    Text("อุณหภูมิคืออะไร?")
                        .font(.custom("Kanit-Bold", size: 24))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.top, -50)
                    
                    Text("อุณหภูมิคือ ตัวชี้วัดความร้อนหรือความเย็น ซึ่งเป็นการวัดพลังงานจลน์เฉลี่ยของอนุภาคในวัตถุซึ่งเป็นพลังงานประเภทหนึ่ง ถ้าเราต้องการระบุว่าของร้อนหรือเย็นจริงๆ เราต้องใช้คำว่า “อุณหภูมิ” สำหรับการใช้อุณหภูมิแทนคำว่าร้อนหรือเย็นจะช่วยลดความสับสนตลอดจนแง่มุมส่วนใหญ่ในชีวิตประจำวัน อุณหภูมิจะวัดโดยเครื่องวัดอุณหภูมิหรือเทอร์โมมิเตอร์ หน่วยการวัดอุณหภูมิที่พบมากที่สุดคือองศาเซลเซียส(°C) ฟาเรนไฮต์(°F) และเคลวิน(K) ซึ่งส่วนใหญ่จะใช้เพื่อวัตถุประสงค์ทางวิทยาศาสตร์")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 26)
                
                VStack(alignment: .leading) {
                    Text("ความชื้นในอากาศคืออะไร?")
                        .font(.custom("Kanit-Bold", size: 24))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.top, -50)
                    
                    Text("ความชื้นในอากาศคือ ปริมาณไอน้ำที่มีอยู่ในอากาศบริเวณใดบริเวณหนึ่ง  ซึ่งมีสัดส่วนที่แตกต่างกันไปในแต่ละสถานที่ ถ้าอากาศมีความชื้นต่ำ น้ำจะเกิดการระเหย แต่ถ้าอากาศมีความชื้นสูง น้ำจะระเหยได้น้อย ขณะที่น้ำเกิดการระเหยจะทำให้อุณหภูมิของสิ่งแวดล้อมลดต่ำลง เนื่องจากน้ำที่ระเหยจะดูดความร้อนจากสิ่งต่าง ๆ ไปใช้ในการระเหยนั่นเอง")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 26)
                
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .padding(.top, -50)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            self.info.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    })
                }
            }
        }
    }
}

struct Temperature_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
//        Temperature()
    }
}
