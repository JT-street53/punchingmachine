//
//  ContentView.swift
//  punchingmachine
//
//  Created by Shelshoker on 2021/12/01.
//

import SwiftUI
import GoogleMobileAds

var best_score = Foundation.UserDefaults.standard.integer(forKey: "best_score")

struct ContentView: View {
//    @State var best_score: Int = Foundation.UserDefaults.standard.integer(forKey: "best_score")
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView{
            Color(hex: 0xFDFFF7).ignoresSafeArea().overlay(
                ZStack{
                    HStack{
                        Spacer()
                        VStack{
                            Spacer().frame(height:24)
                            Text("Your Best Score : \(best_score)").foregroundColor(Color(hex: 0x50514F)).font(.system(size: 28, weight: .heavy, design: .rounded)).padding(6).scaledToFill()
                            Spacer()
                        }
                        Spacer().frame(width:3)
                    }
                    ScrollView{
                        VStack{
                            Spacer().frame(height:121)
                            Image("icon").padding(6).scaledToFill()
                            Text("Punching\nMachine").multilineTextAlignment(.center).foregroundColor(Color(hex: 0x50514F)).font(.system(size: 56, weight: .heavy, design: .rounded)).padding(6).scaledToFill()
                            
                            NavigationLink(
                                destination: PunchView(rootIsActive: self.$isActive),
                                isActive: self.$isActive
                            ) {
                                Text("PUNCH").font(.system(size: 42, weight: .heavy, design: .rounded)).scaledToFill()
                            }.isDetailLink(false).buttonStyle(RoundedRectangleButtonStyle()).scaledToFill()
                            
//                            Button(action: {
//                                best_score = Int(floor(555.5))
//                                Foundation.UserDefaults.standard.set(555.5, forKey: "best_score")
//                            }) {
//                                Text("START 555.5")
//                            }
//                            Button(action: {
//                                best_score = Int(floor(3.33))
//                                Foundation.UserDefaults.standard.set(3.33, forKey: "best_score")
//                            }) {
//                                Text("START 3.33")
//                            }
                            Spacer()
                        }
                    }
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            GADBannerViewController().frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height).scaledToFill()
                            Spacer()
                        }
                    }
                }
            ).navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
