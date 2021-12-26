//
//  ContentView.swift
//  punchingmachine
//
//  Created by Shelshoker on 2021/12/01.
//

import SwiftUI
import GoogleMobileAds

class ScoreObject: ObservableObject {
    @Published var best_score = Foundation.UserDefaults.standard.integer(forKey: "best_score")
}

struct ContentView: View {
    @StateObject var score_obj = ScoreObject()
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView{
            Color(hex: 0xFDFFF7).ignoresSafeArea().overlay(
                ZStack{
                    HStack{
                        Spacer()
                        VStack{
                            Spacer().frame(height:24)
                            Text("Best Score : \(score_obj.best_score)").foregroundColor(Color(hex: 0x50514F)).font(.system(size: 28, weight: .heavy, design: .rounded)).padding(6).scaledToFill()
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
                                Text("スマホを持って空中にパンチしよう！").font(.system(size: 12, weight: .medium, design: .rounded)).scaledToFill()
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
        }.environmentObject(score_obj).navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
