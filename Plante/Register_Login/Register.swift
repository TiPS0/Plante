//
//  Register.swift
//  IoT_Farm
//
//  Created by Tipso on 19/2/2565 BE.
//

import SwiftUI
import Firebase

struct Register: View {
    @State private var Menu_Fullscreen = false
    
    @Binding var isShow: Bool
    @State var alertShow = false
    
    @State var Email_Register: String = ""
    @State var Password_Register: String = ""
    @State var ReEnter_Password: String = ""
    @State var visible = false
    
    @State var error_title = ""
    @State var error_msg = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(red: 132/255, green: 167/255, blue: 88/255).ignoresSafeArea()
            
            register
            
            Button(action: {
                self.isShow.toggle()
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
            })
            .padding()
            
        }
        .navigationBarHidden(true)
    }
    
    var register: some View {
        ZStack() {
            
            VStack(alignment: .leading, content: {
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("ลงทะเบียนเข้าใช้งาน")
                        .font(.custom("Kanit-Bold", size: 32))
                        .foregroundColor(Color.white)

                    Text("สร้างบัญชีของคุณเพื่อเข้าใช้งาน")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color.white)
                }
                .padding(.top, 124)
                .padding(.leading, 24)
                
                VStack(alignment: .leading, spacing: 18) {
                    HStack() {
                        Image("Email").foregroundColor(.white)

                        ZStack(alignment: .leading) {
                            if Email_Register.isEmpty {
                                Text("Email Address")
                                    .font(.custom("ProximaNovaA-Regular", size: 18))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            TextField("", text: $Email_Register)
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
                            if Password_Register.isEmpty {
                                Text("Password")
                                    .font(.custom("ProximaNovaA-Regular", size: 18))
                                    .foregroundColor(.white.opacity(0.7))
                            }

                            if self.visible {
                                TextField("", text: $Password_Register)
                                    .font(.custom("ProximaNovaA-Regular", size: 18))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                            } else {
                                SecureField("", text: $Password_Register)
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
                    
                    HStack() {
                        Image("Lock").foregroundColor(.white)

                        ZStack(alignment: .leading) {
                            if ReEnter_Password.isEmpty {
                                Text("Re-enter Password")
                                    .font(.custom("ProximaNovaA-Regular", size: 18))
                                    .foregroundColor(.white.opacity(0.7))
                            }

                            if self.visible {
                                TextField("", text: $ReEnter_Password)
                                    .font(.custom("ProximaNovaA-Regular", size: 18))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                            } else {
                                SecureField("", text: $ReEnter_Password)
                                    .font(.custom("ProximaNovaA-Regular", size: 18))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                            }
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
                        if Email_Register.isEmpty || Password_Register.isEmpty {
                            self.error_title = "Invalid Input"
                            self.error_msg = "Your email or passowrd is empty. Please try again."
                            alertShow.toggle()
                            
                            return
                        } else if Password_Register != ReEnter_Password {
                            self.error_title = "Incorrect Password"
                            self.error_msg = "The password you entered is incorrect. Please try again."
                            alertShow.toggle()
                            
                            return
                        } else {
                            Auth.auth().createUser(withEmail: self.Email_Register, password: self.Password_Register) { authResult, err in
                                if err != nil {
                                    self.error_title = "Error"
                                    self.error_msg = err!.localizedDescription
                                    alertShow.toggle()
                                    
                                    return
                                } else {
                                    print("Success Register")
                                    Menu_Fullscreen.toggle()
                                }
                            }
                        }
                    }, label: {
                        Text("ลงทะเบียน")
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

                    Button(action: {
                        self.isShow.toggle()
                    }, label: {
                        Text("มีบัญชีอยู่แล้ว? เข้าสู่ระบบ")
                            .font(.custom("Kanit-Medium", size: 18))
                            .foregroundColor(.white)
                    })
                    .frame(width: UIScreen.main.bounds.width - 54)

                }
                .padding(.top, 170)
                .padding(.leading, 27)
                
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Image("Ellipse-2")
                .resizable()
                .scaledToFill()
            )
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

//struct Register_Previews: PreviewProvider {
//    static var previews: some View {
//        Register()
//    }
//}
