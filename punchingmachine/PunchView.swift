//
//  PunchView.swift
//  punchingmachine
//
//  Created by Shelshoker on 2021/12/01.
//

import SwiftUI
import GoogleMobileAds

struct PunchView: View {
    @Binding var rootIsActive : Bool
    @ObservedObject var sensor = MotionSensor()
    @State var timeRemaining = 4
    @State var degress = -90.0
    @State var showScoreView = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationLink(destination: ScoreView(shouldPopToRootView: self.$rootIsActive, punching_score: self.sensor.punch_score), isActive: $showScoreView, label: {
            EmptyView()
        })
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    self.showScoreView.toggle()
                }
            }
        Color(hex: 0xFDFFF7).ignoresSafeArea().overlay(
            ZStack{
                //            VStack {
                //                Text("Score : \(self.sensor.punch_score)")
                //                Text(sensor.xStr)
                //                Text(sensor.yStr)
                //                Text(sensor.zStr)
                //                Button(action: {
                //                    self.sensor.isStarted ? self.sensor.stop() : self.sensor.start()
                //                    Foundation.UserDefaults.standard.set(99, forKey: "best_score")
                //                }) {
                //                    self.sensor.isStarted ? Text("STOP") : Text("START")
                //                }
                //                Text("Time: \(max(0,timeRemaining-1))")
                //                    .onReceive(timer) { _ in
                //                        if timeRemaining > 0 {
                //                            timeRemaining -= 1
                //                        }
                //                        if timeRemaining == 2 {
                //                            self.sensor.start()
                //                        }
                //                        if timeRemaining == 0 {
                //                            self.sensor.stop()
                //                            self.sensor.score()
                //                        }
                //                    }
                //            }
                Text("\(max(0,timeRemaining-1))")
                    .foregroundColor(Color(hex: 0x50514F)).font(.system(size: 198, weight: .heavy, design: .rounded)).padding(6).scaledToFill()
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        }
                        if timeRemaining == 2 {
                            self.sensor.start()
                        }
                        if timeRemaining == 0 {
                            self.sensor.stop()
                            self.sensor.score()
                        }
                    }
                Circle()
                    .trim(from: 0.0, to: 0.4)
                    .stroke(Color(.darkGray), style: StrokeStyle(lineWidth:20, lineCap: .round))
                    .scaledToFit()
                    .frame(width: 320,
                           height: 320,
                           alignment: .center)
                    .rotationEffect(Angle(degrees: degress))
                    .onAppear(perform: {self.start()})
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        GADBannerViewController().frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height).scaledToFill()
                        Spacer()
                    }
                }
            }.navigationBarHidden(true)
        )
    }
    func start() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0/360, repeats: true) { timer in
            withAnimation {
                self.degress += 1.0
            }
            if self.degress == 360.0 {
                self.degress = 0.0
            }
        }
    }
}

//struct PunchView_Previews: PreviewProvider {
//    static var previews: some View {
//        PunchView()
//    }
//}
