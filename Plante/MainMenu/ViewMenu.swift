//
//  ViewMenu.swift
//  IoT_Farm
//
//  Created by Tipso on 24/2/2565 BE.
//

import SwiftUI
import FirebaseDatabase

struct ViewMenu: View {
    @Binding var selectedTab: String
    
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            Home().tag("หน้าหลัก")
            
            Operation().tag("การทำงานแต่ละชั้น")
            
            Temperature().tag("อุณหภูมิ")
            
            Knowledge().tag("แหล่งความรู้เพิ่มเติม")
            
            Help().tag("แนะนำการใช้งาน")
            
        }
    }
}

struct ViewMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
