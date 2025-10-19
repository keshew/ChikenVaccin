import SwiftUI

struct ChikInfoView: View {
    @StateObject var chikInfoModel =  ChikInfoViewModel()

    var body: some View {
        ZStack {
            Color(red: 250/255, green: 229/255, blue: 196/255).ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(.settingsIcon)
                            .resizable()
                            .frame(width: 20, height: 16)
                    }
                    .pressableButtonStyle()
                    
                    Spacer()
                    
                    Text("Today's Overview")
                        .FontLight(size: 20)
                        .offset(y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 223/255, green: 203/255, blue: 160/255),
                                                          Color(red: 223/255, green: 189/255, blue: 148/255)], startPoint: .top, endPoint: .bottom))
                            .frame(height: 360)
                            .overlay {
                                VStack {
                                    HStack {
                                        Image(.sunIcon)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                        
                                        Text("Good Morning!")
                                            .FontBold(size: 24)
                                        .offset(y: 2)
                                    }
                                    .padding(.top)
                                    
                                    Circle()
                                        .fill(LinearGradient(colors: [Color(red: 230/255, green: 200/255, blue: 133/255),
                                                                      Color(red: 233/255, green: 174/255, blue: 120/255)], startPoint: .top, endPoint: .bottom))
                                        .overlay {
                                            TwoRingProgressView(progress: 0.48)
                                        }
                                        .padding(.horizontal)
                                        .padding(.bottom, 20)
                                }
                            }
                            .cornerRadius(15)
                            .padding(.horizontal)
                        
                        HStack {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 223/255, green: 203/255, blue: 160/255),
                                                              Color(red: 223/255, green: 189/255, blue: 148/255)], startPoint: .top, endPoint: .bottom))
                                .frame(height: 100)
                                .overlay {
                                    VStack(spacing: -10) {
                                        Text("18")
                                            .FontExtraBold(size: 40)
                                        
                                        Text("Eggs Collection")
                                            .FontRegular(size: 12)
                                    }
                                }
                                .cornerRadius(15)
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 223/255, green: 203/255, blue: 160/255),
                                                              Color(red: 223/255, green: 189/255, blue: 148/255)], startPoint: .top, endPoint: .bottom))
                                .frame(height: 100)
                                .overlay {
                                    VStack(spacing: -10) {
                                        Text("24")
                                            .FontExtraBold(size: 40)
                                        
                                        Text("Total Chickens")
                                            .FontRegular(size: 12)
                                    }
                                }
                                .cornerRadius(15)
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 223/255, green: 203/255, blue: 160/255),
                                                              Color(red: 223/255, green: 189/255, blue: 148/255)], startPoint: .top, endPoint: .bottom))
                                .frame(height: 100)
                                .overlay {
                                    VStack(spacing: -10) {
                                        Text("2")
                                            .FontExtraBold(size: 40)
                                        
                                        Text("Incubating")
                                            .FontRegular(size: 12)
                                    }
                                }
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                          Color(red: 204/255, green: 206/255, blue: 156/255),
                                                          Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 80)
                            .overlay {
                                HStack {
                                    Image(.fire)
                                        .resizable()
                                        .frame(width: 34, height: 40)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Great production day!")
                                            .FontBold(size: 18, color: Color(red: 102/255, green: 132/255, blue: 0/255))
                                        
                                        Text("Today you collected 10 more eggs than yesterday!")
                                            .FontRegular(size: 12, color: Color(red: 102/255, green: 132/255, blue: 0/255))
                                    }
                                    .padding(.leading, 5)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 10)
                            }
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .padding(.leading, 5)
                            .shadow(color: Color(red: 155/255, green: 207/255, blue: 57/255), radius: 0, x: -5)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 220/255, green: 180/255, blue: 157/255),
                                                          Color(red: 205/255, green: 164/255, blue: 138/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 80)
                            .overlay {
                                HStack {
                                    Image(.attention)
                                        .resizable()
                                        .frame(width: 34, height: 30)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Great production day!")
                                            .FontBold(size: 18, color: Color(red: 159/255, green: 61/255, blue: 0/255))
                                        
                                        Text("Today you collected 10 more eggs than yesterday!")
                                            .FontRegular(size: 12, color: Color(red: 159/255, green: 61/255, blue: 0/255))
                                    }
                                    .padding(.leading, 5)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 10)
                            }
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .padding(.leading, 5)
                            .shadow(color: Color(red: 233/255, green: 145/255, blue: 79/255), radius: 0, x: -5)
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    ChikInfoView()
}

struct TwoRingProgressView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(red: 205/255, green: 153/255, blue: 100/255), lineWidth: 10)
                .frame(width: 220, height: 220)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color(red: 255/255, green: 253/255, blue: 138/255),
                                                    Color(red: 191/255, green: 255/255, blue: 64/255),
                                                    Color(red: 0/255, green: 255/255, blue: 141/255)]),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(340)
                    ),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 220, height: 220)
            
            VStack(spacing: 0) {
                Image(.chikHappy)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 80)
                
                Text("Happy!")
                    .FontBold(size: 35, color: Color(red: 185/255, green: 255/255, blue: 73/255))
                
                Text(String(format: "%.0f%%", min(progress, 1.0) * 100))
                    .FontBold(size: 25, color: Color(red: 26/255, green: 244/255, blue: 103/255))
            }
            .offset(y: 10)
        }
    }
}
