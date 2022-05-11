//
//  Login.swift
//  IoT_Farm
//
//  Created by Tipso on 19/2/2565 BE.
//

import SwiftUI
import Firebase

struct Login: View {
    @State private var Menu_Fullscreen = false
    @State private var Forgot_Sheet = false
    
    @State var isShow = false
    @State var alertShow = false
    
    @State var Email_Login: String = ""
    @State var Password_Login: String = ""
    @State var visible = false
    
    @State var error_title = ""
    @State var error_msg = ""
    
    var body: some View {
        NavigationView {
            
            ZStack() {
                Color(red: 132/255, green: 167/255, blue: 88/255).ignoresSafeArea()
                
                VStack(alignment: .leading, content: {

                    VStack(alignment: .leading, spacing: 14) {
                        Text("ยินดีต้อนรับกลับมา")
                            .font(.custom("Kanit-Bold", size: 32))
                            .foregroundColor(Color.white)

                        Text("เข้าสู่ระบบเพื่อใช้งาน")
                            .font(.custom("Kanit-Regular", size: 16))
                            .foregroundColor(Color.white)
                    }
                    .padding(.top, 124)
                    .padding(.leading, 24)

                    VStack(alignment: .leading, spacing: 18) {
                        HStack() {
                            Image("Email").foregroundColor(.white)

                            ZStack(alignment: .leading) {
                                if Email_Login.isEmpty {
                                    Text("Email Address")
                                        .font(.custom("ProximaNovaA-Regular", size: 18))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                TextField("", text: $Email_Login)
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

                        HStack() {
                            Image("Lock").foregroundColor(.white)

                            ZStack(alignment: .leading) {
                                if Password_Login.isEmpty {
                                    Text("Password")
                                        .font(.custom("ProximaNovaA-Regular", size: 18))
                                        .foregroundColor(.white.opacity(0.7))
                                }

                                if self.visible {
                                    TextField("", text: $Password_Login)
                                        .font(.custom("ProximaNovaA-Regular", size: 18))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                } else {
                                    SecureField("", text: $Password_Login)
                                        .font(.custom("ProximaNovaA-Regular", size: 18))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                }
                            }

                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye" : "eye.slash")
                                    .foregroundColor(.white)
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

                    Button(action: {
                        Forgot_Sheet.toggle()
                    }, label: {
                        Text("ลืมรหัสผ่านของคุณ?")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                    })
                    .padding(.leading, 24)
                    .sheet(isPresented: $Forgot_Sheet) {
                        Forgot()
                    }

                    VStack(spacing: 12) {
                        Button(action: {
                            if Email_Login.isEmpty || Password_Login.isEmpty {
                                self.error_title = "Invalid Input"
                                self.error_msg = "Your email or passowrd is empty. Please try again."
                                alertShow.toggle()
                                
                                return
                            } else {
                                Auth.auth().signIn(withEmail: self.Email_Login, password: self.Password_Login) { authResult, err in
                                    if err != nil {
                                        self.error_title = "Error"
                                        self.error_msg = err!.localizedDescription
                                        alertShow.toggle()
                                            
                                        return
                                    } else {
                                        Menu_Fullscreen.toggle()
                                    }
                                }
                            }
                        }, label: {
                            Text("เข้าสู่ระบบ")
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
                        .fullScreenCover(isPresented: $Menu_Fullscreen) {
                            MainMenu()
                        }

                        NavigationLink(destination: Register(isShow: self.$isShow), isActive: self.$isShow
                        , label: {
                            Text("ลงทะเบียนใหม่")
                                .font(.custom("Kanit-Medium", size: 18))
                                .foregroundColor(.white)
                        })
                        .frame(width: UIScreen.main.bounds.width - 54)

                    }
                    .padding(.top, 200)
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
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
