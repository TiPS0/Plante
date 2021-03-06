//
//  Knowledge.swift
//  IoT_Farm
//
//  Created by Tipso on 1/4/2565 BE.
//

import SwiftUI

struct Knowledge: View {
    @State var info: Bool = false
    
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

                    Text("แหล่งความรู้เพิ่มเติม")
                        .font(.custom("Kanit-Bold", size: 32))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.top, -56)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                VStack(alignment: .leading, content: {
                    Text("ความรู้เบื้องต้นการปลูกพืชผัก")
                        .font(.custom("Kanit-Medium", size: 16))
                        .padding(.leading, 22)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack() {
                            ForEach(0 ..< 3) { index in
                                NavigationLink(
                                    destination: plantPage(index: index),
                                    label: {
                                        plantScroll(image: Image("plant-\(index)"), index: index)
                                    })
                            }
                            .padding(.trailing, 6)
                        }
                        .padding(.leading)
                    })
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 6)
                    
                    Text("สาระน่ารู้เรื่องพืชผัก")
                        .font(.custom("Kanit-Medium", size: 16))
                        .padding(.leading, 22)
                        .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack() {
                            ForEach(0 ..< 4) { index in
                                NavigationLink(
                                    destination: trickPage(index: index),
                                    label: {
                                        trickScroll(image: Image("help-\(index)"), index: index)
                                    })
                            }
                            .padding(.trailing, 6)
                        }
                        .padding(.leading)
                    })
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 6)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 50)
                
                
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
                        .padding(.top, 4)
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                })
            }
        }
        .popupNavigationView(horizontalPadding: 40, show: $info) {
            VStack(alignment: .leading) {
                Text("แหล่งความรู้เพิ่มเติม")
                    .font(.custom("Kanit-Bold", size: 24))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    .padding(.top, -56)
                
                Text("เป็นพื้นที่เกี่ยวกับแหล่งความรู้ของการปลูกพืชผักในด้านต่างๆ ซึ่งจะแบ่งออกเป็น 2 ส่วน ได้แก่ ส่วนความรู้เบื้องต้นการปลูกพืชผักและส่วนสาระน่ารู้เรื่องพืชผัก ซึ่งภายในพื้นที่แหล่งความรู้นี้จะมีข้อมูลต่างๆ เกี่ยวกับการเพาะปลูกที่จำเป็น เช่น วิธีการเพาะปลูกเบื้องต้น การดูแลรักษา เป็นต้น รวมถึงสาระความรู้อื่นๆ ที่เกี่ยวข้องกับการเพาะปลูก")
                    .font(.custom("Kanit-Regular", size: 16))
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                
            }
            .padding(.horizontal, 26)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
                            .padding(.top, 6)
                            .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    })
                }
            }
        }
        
    }
}

struct Knowledge_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}

struct plantScroll: View {
    let image: Image
    let index: Int
    
    let titles = ["โหระพา", "พริก", "กรีนโอ๊ค"]
    let subtitles = ["Basil", "Chili", "Green Oak"]
    
    var body: some View {
        VStack() {
            image
                .resizable()
                .frame(width: 160, height: 150)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 4)
            
            Text("\(titles[index])")
                .font(.custom("Kanit-Bold", size: 20))
                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)
            
            Text("\(subtitles[index])")
                .font(.custom("Kanit-Regular", size: 16))
                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(width: 160)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct trickScroll: View {
    let image: Image
    let index: Int
    
    let titles = ["การปลูกผักด้วยหลอด LED", "อาการพืชใบเหลือง", "ผักปลอดภัยดูอย่างไร", "กัญชงคืออะไร?"]
    
    var body: some View {
        VStack() {
            image
                .resizable()
                .frame(width: 160, height: 150)
                .cornerRadius(20)
            
            Text("\(titles[index])")
                .font(.custom("Kanit-Medium", size: 16))
                .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                .frame(maxWidth: 160, maxHeight: 50, alignment: .center)
                .padding(.top, 4)
        }
        .padding(.bottom)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct plantPage: View {
    @Environment(\.presentationMode) var presentationMode
    
    let index: Int
    
    let titles = ["โหระพา", "พริก", "กรีนโอ๊ค"]
    let subtitles = ["Thai Basil", "Chili", "Green Oak"]
    
    let info = [
        "   โหระพา เป็นพืชล้มลุกอายุสั้น ความสูงประมาณ 40-60 เซนติเมตร ลำต้นมีลักษณะเป็นสี่เหลี่ยมและมีขนาดเล็ก แตกกิ่งก้านเป็นสีม่วงอมแดง มีขนอ่อนๆ ตามลำต้น มีกิ่งก้านเป็นทรงพุ่ม ก้านอ่อนสีม่วง-แดง แตกแขนงออกเป็นคู่ตรงข้ามกัน มีใบแทงออกตามข้อเดี่ยว ลักษณะเป็นใบเดี่ยว รูปไข่ สีเขียวเข้มมองเห็นเส้นใบชัดเจน ความกว้างประมาณ 3-4 เซนติเมตร ความยาวประมาณ 6 เซนติเมตร ปลายใบแหลม โคนใบมน ขอบใบหยักคล้ายฟันเลื่อนและมีกลิ่นหอม ออกดอกเป็นช่อที่ปลายยอด แต่ละช่อดอกเรียงเป็นชั้น ชั้นละ 6-8 ดอก ดอกสีขาวอมม่วง ในดอกมีเมล็ด 3-4 เมล็ด ลักษณะเมล็ดคล้ายหยดน้ำ ขนาดประมาณ 1 มิลลิเมตร สีน้ำตาลเข้ม มีเมือกหุ้ม เมื่อนำมาแช่น้ำเมือกจะพองตัวออกคล้ายเมล็ดแมงลัก",
        "   พริกเป็นไม้ล้มลุกความสูงประมาณ 1-2.5 ฟุต มีลำต้นหลักเพียงต้นเดียว แต่จะแตกกิ่งออกไปเรื่อย ๆ เป็นพุ่มขนาดเล็ก ออกเป็นใบเดี่ยว ทรงกลมรี และปลายแหลม ออกดอกตรมง่ามใบสีขาว 1-3 ดอก มีผลสีเขียว เมื่อโตเต็มที่จะเปลี่ยนสี เป็นสีแดง ส้มหรือแดง ผิวเรียบลื่นเป็นมัน ภายในผลมีแกนเมล็ดตรงกลาง ขนาดแตกต่างออกไปตามสายพันธุ์ แบ่งความเผ็ดตามปริมาณสารแคปไซซินหรือสารให้ความเผ็ดในพริก 3  ระดับ มีหน่วยเป็นสโกวิลล์ (Scoville)  ดังนี้ \n - พริกเผ็ดมาก มักเป็นพริกขนาดเล็ก เช่น พันธุ์ตาบาสโก นิยมนำมาสกัดเป็นน้ำมันหอมระเหย ระดับความเผ็ดอยู่ในช่วง 70,000 - 175,000 สโกวิลล์ \n - พริกเผ็ดกลาง ส่วนใหญ่จะเป็นพริกที่นำมาทำอาหาร เช่น พริกขี้หนู พริกจินดา พริกชี้ฟ้า เป็นต้น ระดับความเผ็ดอยู่ในช่วง 35,000 - 70,000 สโกวิลล์ \n - พริกเผ็ดน้อยหรือไม่เผ็ด เป็นพริกขนาดใหญ่ มีลักษณะผลกลม สั้น เช่น พริกหวานกับพริกหยวก ระดับความเผ็ดอยู่ในช่วง 0 - 35,000 สโกวิลล์",
        "   ผักสลัดกรีนโอ๊ค ใบมีเขียวอ่อนหรือเขียวเข้ม (ตามลักษณะของสายพันธุ์) ขอบใบหยัก มีลำต้นอวบสั้น ช่วงข้อถี่ มีระบบรากแก้วที่สามารถเจริญลงไปในดินได้อย่างรวดเร็ว ช่อดอกเป็นแบบ Panicle สูง 2-4 ฟุต ประกอบด้วย ดอก 10 - 25 ดอกต่อช่อ เป็นดอกสมบูรณ์เพศกลีบดอกสีเหลืองหรือขาวปนเหลือง ดอกจะบานช่วงเช้า โดยเฉพาะในช่วงที่อุณหภูมิต่ำ"
    ]
    
    let guide = [
        "   โหระพาเป็นพืชที่ปลูกง่าย โดยโหระพาจะขึ้นได้ดีในดินร่วนซุยที่มีความอุดมสมบูรณ์และระบายน้ำได้ดีเป็นพิเศษ ต้องทำการเตรียมขุดดินให้ลึกประมาณ 20-25 เซนติเมตร ย่อยให้ละเอียดพร้อมเก็บเศษวัชพืชออกให้เรียบร้อย จากนั้นก็ปล่อยทิ้งไว้ประมาณ 7-10 วัน แล้วใส่ปุ๋ยคอก/ปุ๋ยหมักและปุ๋ยเคมีลงไปให้ทั่ว คลุกให้เข้ากัน เสร็จแล้วก็ลงมือปลูก โดยนิยม 2 วิธี ได้แก่ \n 1. การเพาะกล้าและย้ายปลูก: หว่านเมล็ดแล้วใช้แกลบหรือฟางคลุมพร้อมรดน้ำตามทันที จากนั้นก็หมั่นรดน้ำทุกเช้า-เย็น จนมีอายุ 20-25 วัน จึงทำการถอนกล้าแล้วเด็ดยอดเพื่อย้ายปลูก โดยถ้าปลูกในแปลงควรเว้นระยะให้ห่างประมาณ 20-30 เซนติเมตร ถ้าปลูกในกระถางก็กระถางละ 1-2 ต้น \n 2. การปักชำโหระพา: ตัดกิ่งโหระพาที่โตเต็มที่หรือยาวประมาณ 5-10 เซนติเมตร เด็ดใบออกและเหลือไว้เพียงบางส่วน นำไปปักชำลงในแปลงหรือกระถาง จากนั้นใช้หญ้าแห้งหรือฟางคลุมแล้วรดน้ำตามทันที \n   โหระพาเป็นพืชที่ดูแลง่าย โตเร็ว ชอบความชื้นสูงและสม่ำเสมอ แดดไม่จัด จึงต้องคอยรดน้ำทุกวัน แต่อย่าปล่อยให้ท่วมขังจนเกินไป อีกทั้งในช่วงแรกควรพรวนดินและกำจัดศัตรูพืชออกทุก 1-2 สัปดาห์ โดยระวังไม่ให้กระทบต้นและราก \n   สำหรับการเก็บเกี่ยวต้นโหระพาสามารถเก็บเกี่ยวได้หลังจากปลูกประมาณ 30-35 วัน โดยใช้มีดคม ๆ ตัดกิ่งให้ห่างจากยอดลงมาประมาณ 10-15 เซนติเมตร สามารถเก็บเกี่ยวได้ทุก ๆ 15-20 วัน ไปจนถึงอายุ 7-8 เดือน",
        "   1. เตรียมเมล็ดพริกให้พร้อมก่อนลงปลูก: นำพริกพันธุ์ที่จะปลูกไปแช่ในน้ำอุ่นไว้ประมาณ 1 วันและนำออกมาผึ่งแดดอีกครึ่งวัน ก่อนแกะเมล็ดพริกออกมาปลูก \n  2. เพาะต้นกล้าพริกก่อนปลูกจริง: ผสมดินร่วนปนทรายเข้ากับปุ๋ยหมักสูตรโพแทสเซียมสูงกว่าไนโตรเจนลงในกระถางเพาะต้นกล้าพริก ขุดหลุมดินในกระถางให้ลึกประมาณ ½ นิ้ว แล้วหย่อนเมล็ดพริกที่เตรียมไว้ลงในหลุมประมาณ 3-4 เมล็ด กลบดิน รดน้ำให้ชุ่มทุกวัน พร้อมกับสังเกตว่าดินระบายน้ำได้ดีหรือไม่ และที่สำคัญต้องวางกระถางเพาะไว้ในที่ที่มีแดดส่องถึง \n   พริกเป็นพืชที่ชอบแสงแดด ฉะนั้นควรวางกระถางปลูกต้นพริกในที่ที่มีแดดส่องถึง รดน้ำให้ชุ่มแต่อย่าแฉะทุกวันเช้า-เย็น และเมื่อพริกเริ่มติดดอกและออกผลแข็งแรงแล้ว ให้เปลี่ยนไปรดน้ำแบบวันเว้นวัน และหมั่นใส่ปุ๋ยเดือนละครั้ง แต่เลี่ยงการใส่ปุ๋ยใต้โคนต้นพริกโดยตรง เพราะจะทำให้รากเน่าและต้นพริกตายได้ ในการเก็บเกี่ยวเม็ดพริกก็ขึ้นอยู่กับสายพันธุ์ที่นำมาปลูก แต่สำหรับพริกขี้หนูจะออกดอกและให้ผลประมาณเดือนที่ 2-3 ของการปลูก",
        "   1. นำดินเพาะใส่ถาดหลุมให้เต็มไม่ต้องอัดแน่นและรดน้ำให้ชุ่ม \n  2. เจาะหลุมไม่ต้องลึกมาก แล้วหยอดเมล็ดลงหลุม 1-2 เมล็ด จากนั้นกลบเบา ๆ ไม่กดแน่นมาก \n  3. รดน้ำให้ชุ่ม แล้ววางถาดไว้ที่ร่มรำไร (ไม่ควรวางกลางแจ้งโดยตรงเพื่อป้องกันต้นกล้าเฉา และโดนฝน) \n  4. จากนั้นรดน้ำทุกวันช่วงเช้าและเย็น หรือบางวันอากาศร้อนอาจจะ 3 ครั้งก็ได้ โดยสังเกตบริเวณหน้าดิน \n   ในช่วง 2 สัปดาห์แรก ควรให้น้ำในช่วงเช้าและเย็นอย่างสม่ำเสมอ และไม่ควรรดน้ำแฉะจนเกินไป หลังจากปลูกลงแปลงประมาณ 15-20 วันสามารถใส่ปุ๋ยคอกหรือปุ๋ยหมักได้ โดยโรยห่างจากโคนต้น แต่โดยทั่วไปผักสลัดเป็นพืชอายุสั้น หากมีการเตรียมแปลงที่ดีโดยใส่ปุ๋ยให้เพียงพอก่อนปลูกไม่จำเป็นต้องใส่ปุ๋ยเพิ่มหลังจากปลูกก็ได้ สำหรับการเก็บเกี่ยว ควรเลือกเก็บขณะที่ใบยังอ่อน กรอบ ไม่เหนียว กระด้าง ไม่ควรเก็บขณะต้นแก่เพราะจะมีรสขม สำหรับวิธีการตัด จะใช้มีดตัดตรงโคนต้น แล้วตัดแต่งใบเสียทิ้งไป จุ่มน้ำเพื่อให้ยางสีขาวออก และสลัดน้ำออกให้หมด เพราะถ้ามีน้ำขังอยู่จะเน่าเสียได้ง่าย"]
    
    let warning = [
        "   นอกจากวัชพืช เช่น แห้วหมูและผักโขม ที่ต้องคอยระวังและกำจัดแล้ว คนที่ปลูกต้นโหระพาต้องคอยสำรวจตรวจเช็กและใส่ใจดูแลเพื่อป้องกันโรคและแมลงเหล่านี้เอาไว้ด้วย \n• โรคเหี่ยว: เป็นโรคที่ทำให้ใบดำและเหี่ยวตาย สามารถแก้ไขได้ด้วยการฉีดยากำจัดเชื้อรา \n• โรคใบเน่า: เป็นโรคที่ทำให้ใบเป็นแผล มีน้ำและมีเมือก โดยแผลจะค่อย ๆ ลุกลามไปเรื่อย ๆ จนทำให้ต้นเน่าตาย \n• เพลี้ยไฟโหระพา: เป็นเพลี้ยที่ดูดกินน้ำเลี้ยงจากเซลล์พืช ทำให้ใบหรือยอดอ่อนหงิก ส่วนขอบม้วนงอ โดยสามารถแก้ไขได้ด้วยการหมั่นสำรวจและติดกับดักกาวเหนียวสีเหลือง เพื่อดักจับตัวโตเต็มวัย \n• เพลี้ยอ่อนฝ้าย: เป็นเพลี้ยที่ดูดกินน้ำเลี้ยงจากใบและยอด ทำให้มีอาการงอหงิก และชะงักการเจริญเติบโต อีกทั้งยังเป็นพาหะนำไวรัสหลายชนิดมาสู่พืชด้วย โดยจะพบมากในช่วงอากาศแห้งแล้งหรือฤดูหนาว แต่สามารถแก้ไขได้ด้วยการกำจัดวัชพืชเป็นประจำ และถ้าหากพบพืชหงิกงอให้ตัดส่วนนั้น ๆ ออกแล้วนำมาเผาทิ้ง \n• แมลงหวี่ขาวยาสูบ: เป็นแมลงที่ดูดกินน้ำเลี้ยงจากใบ ทำให้ใบเหี่ยวแห้งและต้นแคระแกร็น อีกทั้งยังเป็นพาหะนำเชื้อไวรัสที่ทำให้เกิดโรคด่างเหลืองอีกด้วย พบมากในฤดูแล้ง สามารถแก้ไขได้ด้วยการหมั่นสำรวจและติดกับดักกาวเหนียวสีเหลือง เพื่อดักจับตัวโตเต็มวัย \n• หนอนแมลงวันชอบใบ: เป็นหนอนที่ชอนไชใบจนทำให้เกิดรอยสีขาว แต่ถ้าระบาดรุนแรงอาจจะทำให้ใบร่วงและตายได้ การแก้ไขคือ หมั่นเก็บเศษใบที่ถูกทำลายและร่วงหล่นตามพื้นดินมาเผาทิ้ง จะช่วยลดการแพร่ระบาดได้",
        "   เรื่องที่ต้องระมัดระวังเป็นพิเศษของการปลูกต้นพริกในกระถางคือ อย่าให้มีน้ำขังไม่เช่นนั้นโรคราและโรครากเน่าจะเกิดขึ้นได้ หากพบศัตรูพืชอย่างเพลี้ยไฟ เพลี้ยอ่อน และไรขาวที่ต้นพริก สามารถแก้ปัญหาได้ด้วยการตำใบสะเดา หัวข่า และตะไคร้หอมรวมกัน กรองเอาแต่น้ำไปผสมน้ำเปล่าในอัตรา 1:10 ก่อนนำไปพ่นที่ต้นพริก",
        "   1. โรคใบจุด: เป็นโรคที่มักเกิดขึ้นกับผักประเภทกินใบ อย่างกะหล่ำ ผักกาดต่าง ๆ เป็นต้น ใบของผักจะมีจุดสีเหลืองหรือสีน้ำตาลเป็นจุดเล็ก ๆ และเริ่มขยายขนาดกว้างขึ้น ส่งผลให้พืชผลเจริญเติบโตได้ไม่เต็มที่ และสามารถแพร่เชื้อระบาดไปยังแปลงผักอื่น ๆ อีกได้ \n  2. โรครากเน่า: เป็นโรคที่เกิดจากเชื้อรา ผักสลัดที่เสี่ยงต่อการเกิดโรคนี้คือผักกรีนโอ๊ค เบบี้คอส ผักกาดหอม มะเขือเทศ เป็นต้น มักเกิดขึ้นมากในช่วงฤดูฝน หรือในกรณีที่ปลูกผักสลัดแบบการปลูกบนดิน แล้วมีระบบจัดการระบายน้ำได้ไม่ดี มีน้ำท่วมขัง ส่งผลให้เกิดเชื้อรา โดยการแพร่ระบาดของโรคนี้เป็นไปได้ง่าย \n  3. ผักสลัดใบไหม้: โรคนี้มักเกิดขึ้นกับผักกาดแก้ว ผักกรีนโอ๊ค ผักกาดหอม เป็นต้น สาเหตุที่เกิดโรคใบไหม้ในผักสลัดมีอยู่หลายปัจจัย แต่ปัจจัยที่มักทำให้เกิดได้บ่อยที่สุดก็คือเชื้อโรคและอากาศที่ร้อนจัด"]
    
    var body: some View {
        ZStack() {
            Color(red: 241/255, green: 249/255, blue: 235/255).ignoresSafeArea()
            
            ScrollView {
                Image("plant-\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading) {
                    HStack() {
                        Text("\(titles[index])")
                            .font(.custom("Kanit-Bold", size: 32))
                            .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        
                        Text("ข้อมูลวันที่ April 3, 2022")
                            .font(.custom("Kanit-Medium", size: 14))
                            .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.7))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    Text("\(subtitles[index])")
                        .font(.custom("Kanit-Medium", size: 18))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.top, -42)
                    
                    Text("ข้อมูลน่ารู้")
                        .font(.custom("Kanit-Bold", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.bottom, -4)

                    Text("\(info[index])")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.bottom)
                    
                    Text("วิธีการปลูก")
                        .font(.custom("Kanit-Bold", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.bottom, -4)
                    
                    Text("\(guide[index])")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.bottom)
                    
                    Text("สิ่งที่ต้องระวัง")
                        .font(.custom("Kanit-Bold", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.bottom, -4)
                    
                    Text("\(warning[index])")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(22)
                .background(Color(red: 241/255, green: 249/255, blue: 235/255))
                .cornerRadius(40)
                .padding(.top, -40)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: -10)
            }
            .edgesIgnoringSafeArea(.vertical)
        }
        .toolbar {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.top, 6)
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
            })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct trickPage: View {
    @Environment(\.presentationMode) var presentationMode
    
    let index: Int
    
    let titles = ["การปลูกผักด้วยหลอด LED", "อาการพืชใบเหลือง เกิดจากอะไร แก้ได้อย่างไร", "ผักปลอดภัย ดูอย่างไร", "กัญชงคืออะไร?"]
    
    let info = [
        "   หลอดไฟ LED ที่ใช้ เป็นหลอดไฟที่ออกแบบมาสำหรับการปลูกผักโดยเฉพาะ ช่วยในเรื่องของการเร่งการเจริญเติบโตของพืช การป้องกันต้นยืดเวลาแดดน้อย หรือใช้ในการปลูกผักสำหรับท่านที่ต้องการปลูกผักในบ้านหรือริมระเบียง \n\n  โดยแสงที่ผลิตจะเป็นแสงที่พืชต้องการ เน้นสีแดง (630-660 nm) และสีน้ำเงิน (430-460 nm) โดยมีความยาวคลื่นแสงที่พืชต้องการ (ค่าคลื่นแสงประมาณ 400-700 nm) จะเป็นช่วงที่พืชสามารถสังเคราะห์แสงได้ดีที่สุดและเจริญเติบโตดีที่สุด ส่วนช่วงแสงสีส้ม สีเหลืองและสีเขียวจะเป็นสีที่ไม่จำเป็นต่อการเจริญเติบโตของพืช เนื่องจากเวลาพืชได้รับแสงตามธรรมชาตินั้น พืชจะเลือกใช้ช่วงแสงที่พืชต้องการเท่านั้น นั่นก็คือช่วงแสงสีแดงและน้ำเงิน สำหรับหลอด LED สามารถควบคุมคลื่นความถี่ของแสง ให้เหมาะกับพืชแต่ละชนิดได้ และหากผู้เพาะปลูกเข้าใจว่าพืชที่เพาะปลูกต้องการแสงประเภทไหน จะทำให้พืชใช้แสงได้ 100% จากหลอดไฟที่ได้ทำการเปิดออกมา \n\n  ในต่างประเทศมีการใช้หลอดไฟ LED ในการปลูกผักอย่างแพร่หลาย ณ ปัจจุบัน เนื่องจากสภาพภูมิอากาศในต่างประเทศบางประเทศนั้นแตกต่างจากประเทศไทยเช่น หนาวไปหรือมีเมฆมาก เลยจำเป็นต้องใช้หลอด LED มาช่วยในการปลูกผัก เพราะหลอดไฟ LED ปัจจุบัน ได้มีการพัฒนาให้มีประสิทธิภาพมากขึ้นกว่าหลอดสมัยก่อนหลายเท่าตัว และยังมีเรื่องของความประหยัด อายุการใช้งานที่นานกว่า และความร้อนที่น้อยกว่าหลอดแบบเก่าอีกด้วย",
        "   อาการใบเหลืองในผักสลัดนั้นเกิดได้จากหลายสาเหตุ แต่ส่วนใหญ่แล้วจะเกิดขึ้นเนื่องจากการขาดธาตุอาหารบางอย่าง หลักการในการสังเกตว่าเกิดจากสาเหตุอะไรนั้น จึงควรเริ่มจากตัวสารละลายก่อนเป็นอันดับแรกว่าธาตุอาหารที่เราให้พืชในแปลงปกติดีหรือไม่ เช่น ความถี่ของการเปลี่ยนถ่ายน้ำในถังสารละลาย การเติมธาตุอาหาร การเปลี่ยนยี่ห้อธาตุอาหารที่ใช้ การเก็บรักษาปุ๋ย อายุของปุ๋ยที่ใช้ โดยส่วนใหญ่แล้วอาการใบเหลืองที่พบบ่อยจะเกิดจากการขาดธาตุไนโตรเจนหรือธาตุเหล็กเป็นหลัก อาการใบเหลือจะต่างกันเล็กน้อยคือ หากพืชขาดธาตุไนโตรเจน ใบแก่ที่อยู่ด้านล่างของพืชจะมีสีเหลืองหรือเขียวจาง ใบอ่อนมีสีเขียวมากกว่า ต้นพืชจะโตช้าหรือหยุดชะงัก ในทางกลับกัน หากพืชขาดธาตุเหล็ก ลักษณะอาการที่แสดงที่ใบคือ ใบอ่อนหรือใบส่วนยอดมีสีเหลือง โดยทั่วไปอาการขาดธาตุเหล็กพบบ่อยในช่วงหน้าร้อนเนื่องจากธาตุเหล็กไม่ทนความร้อน ถังสารละลายที่โดนแดดส่องจะส่งผลให้ธาตุเหล็กสลายไป หรืออีกกรณีที่พบบ่อยคือการที่ไม่ได้ปรับค่า pH ของน้ำ หรือปรับไม่สม่ำเสมอ เมื่อค่า pH ของน้ำมีความเป็นด่างสูง เหล็กที่ใส่ลงไปอาจตกตะกอนจนพืชไม่สามารถดูดเข้าไปใช้ได้ \n\n  นอกจากนี้ยังมีธาตุอาหารอีกหลายตัวที่อาจส่งผลให้พืชเกิดอาหารใบเหลือ แต่ลักษณะอาการจะแต่ต่างออกไป เช่น อาการขาดแมงกานีส ผักจะแสดงอาการที่ใบ เช่น เหลืองซีด ใบจะเป็นจุดเล็ก ๆ กระจายทั่วทั่งต้น โดยที่เส้นใบยังคงมีสีเขียวอยู่ ธาตุกำมะถันหากขาดจะสังเกตค่อนข้างยากเพราะอาการคล้ายการขาดไนโตรเจน ใบขนาดเล็กลง ยอดของพืชจะชะงักการเจริญเติบโต ลำต้นและกิ่งก้านลีบเล็ก อาการจะเกิดที่ยอดอ่อนก่อน ส่วนใบล่างยังคงปกติ ถ้าอาการรุนแรงใบล่างก็จะมีอาการด้วยเช่นกัน \n\n  และเนื่องจากอาการผิดปกตินี้สามารถบอกได้ยากว่าเกิดจากการขาดธาตุอาหารตัวไหน ทำให้ยากต่อการแก้ไขแบบเฉพาะเจาะจงที่ธาตุอาหารตัวใดตัวหนึ่ง หากผู้ปลูกทำการปลูกในระบบไฮโดรโปนิกส์ จะแนะนำให้เปลี่ยนสารละลายทั้งหมดจะเป็นการง่ายกว่าที่จะเติมธาตุอาหารตัวใดตัวหนึ่งลงไป",
        "   การดูผักให้ปลอดภัยสามารถทำได้ง่าย ๆ ด้วยตัวเอง ดังนี้ \n\n  1. ควรรู้จักแหล่งที่มาของผักที่ซื้อ ควรมีการรับรองแหล่งที่ปลูกหรือผู้บริโภคควรรู้จักแหล่งที่ปลูกผัก และอีกหนึ่งวิธีคือ การปลูกผักกินเอง โดยสามารถทำได้แม้มีพื้นที่จำกัด ซึ่งผักที่ปลูกได้ง่ายมีทั้งโหระพา กะเพรา พริกขี้หนู เป็นต้น \n  2. ผักมีรูพรุนใช่ว่าจะปลอดภัยเสมอไป ตามหลักความเป็นจริงของการปลูกผัก เพราะอาจเกิดจากการฉีดยาฆ่าแมลงหลายครั้งแต่ไม่สามารถป้องกันแมลงได้ การดมกลิ่นเป็นอีกวิธีหนึ่งที่ช่วยได้ หากผักมีกลิ่นฉุนที่รุนแรง แสดงว่าผักมีสารเคมีปนเปื้อนอยู่ \n  3. กินผักให้ถูกต้องตามฤดูกาล เป็นวิธีที่เหมาะสมมากที่สุด เพราะผักที่ปลูกตามฤดูกาลสภาพอากาศจะเอื้ออำนวยกับการเติบโตของผัก ทำให้มีการฉีดยาฆ่าแมลงน้อย อย่างเช่น ฤดูร้อน สามารถกินชะอม ถั่วพู ถั่วฝักยาว แต่ไม่ควรกินผักคะน้า กวางตุ้ง ขึ้นฉ่าย แต่ฤดูหนาวสามารถกินคะน้า บล็อกโคลี่ได้ ส่วนฤดูฝน สามารถกินได้เกือบทุกชนิด แต่ควรระวังสารเคมีตกค้างจากยากันเชื้อรา เพราะฉะนั้น ควรล้างผักก่อนกินทุกครั้ง นอกจากนี้ควรหันมาบริโภคผักพื้นบ้านให้มากขึ้นเพราะไม่มีสารเคมีตกค้าง อย่างเช่น ตำลึง กระถิน หัวปลี สะเดา ผักกูด เป็นต้น",
        "   ชื่อทางวิทยาศาสตร์คือ Cannabis sativa สามารถใช้เรียกทั้งกัญชงและกัญชา เป็นพืชล้มลุก มีใบแฉก 5-8 แฉก ลำต้นสูง 3-5 เมตร มีสารออกฤทธิ์ต่อจิตประสาทหรือสาร THC มีฤทธิ์ทำให้ติดและเมา แต่มีสรรพคุณทางยา ที่สามารถนำมาพัฒนาเป็นยารักษาโรคได้ โดยการแยกกัญชงและกัญชานั้นดูที่สาร THC เป็นหลัก โดยปริมาณสาร THC หรือสารเมานั้น (Tetrahydrocannabinol) ประเทศไทยกำหนดไว้ที่ 1% ของใบหรือช่อดอกแห้ง (แต่ละประเทศมีการกำหนดที่แตกต่างกัน) โดยหากค่าของสาร THC ไม่เกินร้อยละ 1 ถือว่าเป็นกัญชง (Hemp) แต่ถ้าเกินคือกัญชา (Marijuana) \n\n  กัญชงสายพันธุ์ไทยส่วนใหญ่จะเป็นที่คุ้นเคยหรือรู้จักกันสำหรับการนำไปทำเครื่องนุ่งห่มและสิ่งทอ มากกว่าการนำไปทำยา เนื่องจากกัญชงสายพันธุ์ไทยส่วนใหญ่ มีค่า CBD (Cannabidiol) ที่ต่ำ สำหรับค่า CBD นั้นมีประโยชน์ในด้านของการช่วยให้ผ่อนคลาย จึงถูกนำมาใช้ในการช่วยสำหรับการนอนหลับที่ดีขึ้น \n\n  โดยนำกัญชงนั้นมาสกัด CBD จะต้องมีค่า THC ไม่เกิน 0.2% ถึงจะไม่เป็นยาเสพติด ในต่างประเทศมีผลิตภัณฑ์กัญชงหลากหลายให้เลือกซื้อ ไม่ว่าจะเป็นน้ำมัน ผงกัญชง เมล็ดกัญชงอบแห้ง เครื่องสำอางต่าง ๆ มากมาย"
    ]
    
    var body: some View {
        ZStack() {
            Color(red: 241/255, green: 249/255, blue: 235/255).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, content: {
                    Text("\(titles[index])")
                        .font(.custom("Kanit-Bold", size: 24))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                    
                    Text("ข้อมูลวันที่ April 3, 2022")
                        .font(.custom("Kanit-Medium", size: 14))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255, opacity: 0.7))
                    
                    Image("help-\(index)")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 20)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 6)
                    
                    Text("เนื้อหา")
                        .font(.custom("Kanit-Medium", size: 22))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                        .padding(.bottom, -4)
                    
                    Text("\(info[index])")
                        .font(.custom("Kanit-Regular", size: 16))
                        .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
                })
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal, 22)
                .padding(.top, -40)
            }
        }
        .toolbar {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(red: 66/255, green: 94/255, blue: 21/255))
            })
        }
        .navigationBarBackButtonHidden(true)
    }
}

//extension UINavigationController: UIGestureRecognizerDelegate {
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = self
//    }
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count > 1
//    }
//}

extension View {
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40, verticalPadding: CGFloat = 1.7, show: Binding<Bool>, @ViewBuilder content: @escaping ()->Content) -> some View {
        
        return self
            .overlay {
                if show.wrappedValue {
                    GeometryReader { proxy in
                        
                        Color.primary
                            .opacity(0.2)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView {
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height / verticalPadding, alignment: .center)
                        .cornerRadius(16)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}
