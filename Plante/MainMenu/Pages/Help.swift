//
//  Help.swift
//  IoT_Farm
//
//  Created by Tipso on 1/4/2565 BE.
//

import SwiftUI

struct Help: View {
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

                    Text("แนะนำการใช้งาน")
                        .font(.custom("Kanit-Bold", size: 32))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.top, -56)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                VStack(alignment: .leading, content: {
                    TabView {
                        Group {
                            Image("page-1")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-2")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                        }
                        
                        Group {
                            Image("page-3")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-4")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-5")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-6")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-7")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-8")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-9")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                        }
                        
                        Group {
                            Image("page-10")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-11")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-12")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-13")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-14")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                            Image("page-15")
                                .resizable()
                                .frame(width: 310, height: 600)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 6)
                        }
                        
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 700)
                    .padding(.vertical, -20)
                })
            
            }
        }
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
