//
//  MainMenu.swift
//  IoT_Farm
//
//  Created by Tipso on 22/2/2565 BE.
//

import SwiftUI

struct MainMenu: View {
    @State var selectedTab = "หน้าหลัก"
// หน้าหลัก การทำงานแต่ละชั้น อุณหภูมิ แหล่งความรู้เพิ่มเติม แนะนำการใช้งาน
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            Color(red: 132/255, green: 167/255, blue: 88/255).ignoresSafeArea()
            
            SideMenu(selectedTab: $selectedTab)
            
            ZStack() {
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical, 30)
                
                Color.white
                    .opacity(0.4)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical, 60)
                
                ViewMenu(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
            }
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 120 : 0)
            .ignoresSafeArea()
            .overlay(
                Button(action: {
                    withAnimation(.spring()) {showMenu.toggle()}
                }, label: {
                    VStack(spacing: 5) {
                        Capsule()
                            .fill(showMenu ? Color.white : Color.black)
                            .frame(width: 30, height: 3)
                            .rotationEffect(.init(degrees: showMenu ? -45 : 0))
                            .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
                        
                        VStack(spacing: 5) {
                            Capsule()
                                .fill(showMenu ? Color.white : Color.black)
                                .frame(width: 30, height: 3)
                            Capsule()
                                .fill(showMenu ? Color.white : Color.black)
                                .frame(width: 30, height: 3)
                                .offset(y: showMenu ? -8 : 0)
                        }
                        .rotationEffect(.init(degrees: showMenu ? 45 : 0))
                    }
                    .frame(width: 40, height: 40)
                })
                .padding(.leading), alignment: .topLeading
            )
            
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}

extension View {
    func getRect()->CGRect {
        
        return UIScreen.main.bounds
    }
}
