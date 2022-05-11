//
//  SideMenu.swift
//  IoT_Farm
//
//  Created by Tipso on 23/2/2565 BE.
//

import SwiftUI
import Firebase

struct SideMenu: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedTab: String
    @Namespace var animation
    
    @State var alertShow = false
    
    @State var signoutError = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            
            VStack(alignment: .leading, spacing: 14) {
                TabButton(image: "house", title: "หน้าหลัก", selectedTab: $selectedTab, animation: animation)
                
                Rectangle().fill(.white).frame(width: 200, height: 1)
                
                TabButton(image: "tray.2", title: "การทำงานแต่ละชั้น", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "thermometer", title: "อุณหภูมิ", selectedTab: $selectedTab, animation: animation)
                
                Rectangle().fill(.white).frame(width: 200, height: 1)
                
                TabButton(image: "text.book.closed", title: "แหล่งความรู้เพิ่มเติม", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "questionmark.circle", title: "แนะนำการใช้งาน", selectedTab: $selectedTab, animation: animation)
                
            }
            .padding(.leading, -10)
            .padding(.top, 60)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 6 ) {
                Button(action: {
                    do {
                        alertShow.toggle()
                        try Auth.auth().signOut()
                        
                    } catch let signOutError as NSError  {
                        print("Error signing out: %@", signOutError)
                    }
                }, label: {
                    HStack(spacing: 10) {
                        Image(systemName: "rectangle.portrait.and.arrow.right").font(.title2).frame(width: 30)
                        Text("ออกจากระบบ").font(.custom("Kanit-Bold", size: 16))
                    }
                    .foregroundColor(.white)
                    .padding([.leading, .bottom],10)
                })
                .alert(isPresented: $alertShow) {
                    Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to logout?"),
                        primaryButton: .destructive(Text("Log Out"), action: {
                            presentationMode.wrappedValue.dismiss()
                        }),
                        secondaryButton: .cancel()
                    )
                }
                
                Text("App Version 1.1.0")
                    .font(.custom("Kanit-Medium", size: 12))
                    .foregroundColor(.white)
                    .opacity(0.8)
                    .padding(.leading, 10)
            }
            
            
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}

struct TabButton: View {
    var image: String
    var title: String
    
    @Binding var selectedTab: String
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){selectedTab = title}
        }, label: {
            HStack(spacing: 10) {
                Image(systemName: image).font(.title2).frame(width: 30)
                Text(title).font(.custom("Kanit-Bold", size: 16))
            }
            .foregroundColor(selectedTab == title ? Color(red: 0.518, green: 0.655, blue: 0.345) : .white)
            .padding(.vertical,12)
            .padding(.horizontal,20)
            .background(
                ZStack() {
                    if selectedTab == title {
                        Color.white.opacity(selectedTab == title ? 1 : 0)
                            .clipShape(customCorners(corners: [.topRight, .bottomRight], radius: 12))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
        })
        
    }
}

struct customCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
