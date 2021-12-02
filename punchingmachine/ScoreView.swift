//
//  ScoreView.swift
//  punchingmachine
//
//  Created by Shelshoker on 2021/12/01.
//

import SwiftUI
import GoogleMobileAds

struct ScoreView: View {
    @Binding var shouldPopToRootView : Bool
    let punching_score : Double
    
    var body: some View {
        Color(hex: 0xFDFFF7).ignoresSafeArea().overlay(
            ZStack{
                ScrollView{
                    VStack{
                        Spacer().frame(height:144)
                        
                        Text("Way to Go !!").foregroundColor(Color(hex: 0x50514F)).font(.system(size: 56, weight: .heavy, design: .rounded)).padding(6).scaledToFill()
                        Text("Your Score was").foregroundColor(Color(hex: 0x50514F)).font(.system(size: 28, weight: .heavy, design: .rounded)).padding(6).scaledToFill()
                        Text("\(Int(round(self.punching_score)))").foregroundColor(Color(hex: 0x50514F)).font(.system(size: 105, weight: .heavy, design: .rounded)).padding(6).scaledToFill()
                        
                        Button(action: {
                            self.shouldPopToRootView = false
                        }) {
                            Text("TRY AGAIN").font(.system(size: 42, weight: .heavy, design: .rounded)).scaledToFill()
                        }.buttonStyle(RoundedRectangleButtonStyle()).scaledToFill()
                        
                        Spacer().frame(height:144)
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

//struct ScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreView()
//    }
//}
