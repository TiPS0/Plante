//
//  Forgot.swift
//  IoT_Farm
//
//  Created by Tipso on 21/2/2565 BE.
//

import SwiftUI
import Firebase

struct Forgot: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var alertShow = false
    
    @State var Email_Forgot: String = ""
    
    @State var error_title = ""
    @State var error_msg = ""
    
    var body: some View {
        ZStack() {
            Color(red: 132/255, green: 167/255, blue: 88/255).ignoresSafeArea()
            
            VStack() {
                Capsule()
                    .fill(Color.white)
                    .frame(width: 80, height: 4)
                    .padding(.top)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(alignment: .leading, content: {
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("ลืมรหัสผ่าน?")
                        .font(.custom("Kanit-Bold", size: 32))
                        .foregroundColor(Color.white)

                    Text("กรุณาป้อนที่อยู่อีเมลของคุณในช่องด้านล่าง")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color.white)
                    Text("เพื่อรับลิงก์สำหรับกำหนดรหัสผ่านใหม่")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color.white)
                        .padding(.top, -14.0)
                }
                .padding(.top, 80)
                .padding(.leading, 24)
                
                VStack(alignment: .leading, spacing: 18) {
                    HStack() {
                        Image("Email").foregroundColor(.white)

                        ZStack(alignment: .leading) {
                            if Email_Forgot.isEmpty {
                                Text("Email Address")
                                    .font(.custom("ProximaNovaA-Regular", size: 18))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            TextField("", text: $Email_Forgot)
                                .font(.custom("ProximaNovaA-Regular", size: 18))
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .keyboardType(.emailAddress)
                        }
                    }
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(height: 2)
                        .padding(.top, -18)
                }
                .padding(.top, 64)
                .padding(.bottom, -10)
                .padding(.horizontal, 24)
                
                VStack(spacing: 12) {
                    Button(action: {
                        if Email_Forgot.isEmpty{
                            self.error_title = "Invalid Input"
                            self.error_msg = "Your email is empty. Please try again."
                            alertShow.toggle()
                            
                            return
                        } else {
                            Auth.auth().sendPasswordReset(withEmail: self.Email_Forgot) { [self] err in
                                if err != nil {
                                    self.error_title = "Error"
                                    self.error_msg = err!.localizedDescription
                                    alertShow.toggle()
                                    
                                    return
                                } else {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }, label: {
                        Text("ยืนยัน")
                            .font(.custom("Kanit-Bold", size: 18))
                            .foregroundColor(Color(red: 53/255, green: 116/255, blue: 24/255))
                            .padding(.vertical, 14)
                            .frame(width: UIScreen.main.bounds.width - 54)
                    })
                    .background(Color.white)
                    .cornerRadius(10)
                    .alert(isPresented: $alertShow) {
                        Alert(title: Text(error_title), message: Text(error_msg), dismissButton: .cancel())
                    }

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("ย้อนกลับเพื่อเข้าสู่ระบบ")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                    })
                    .frame(width: UIScreen.main.bounds.width - 54)

                }
                .padding(.top, 280)
                .padding(.leading, 27)
                
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Image("Ellipse-1")
                .resizable()
                .scaledToFill()
            )
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct Forgot_Previews: PreviewProvider {
    static var previews: some View {
        Forgot()
    }
}
