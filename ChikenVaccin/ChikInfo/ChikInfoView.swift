import SwiftUI

struct ChikInfoView: View {
    @StateObject var chikInfoModel =  ChikInfoViewModel()
    @State var isShow = false
    @State var isOn = false
    @State var isNotifOn = false
    @State var isVib = false
    @State var isSounds = false
    
    
    var body: some View {
        ZStack {
            Color(red: 250/255, green: 229/255, blue: 196/255).ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            isShow.toggle()
                        }
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
                            .frame(height: 330)
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
                                        Text("\(chikInfoModel.totalEggs)")
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
                                        Text("\(chikInfoModel.totalChicks)")
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
                                        Text("\(chikInfoModel.incubatingCount)")
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
                                            .FontBold(size: 16, color: Color(red: 102/255, green: 132/255, blue: 0/255))
                                        
                                        Text("Remember to check on your chickens daily for their health and egg production.")
                                            .FontRegular(size: 11, color: Color(red: 102/255, green: 132/255, blue: 0/255))
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
                                        Text("Vaccination")
                                            .FontBold(size: 16, color: Color(red: 159/255, green: 61/255, blue: 0/255))
                                        
                                        Text("Track incubating batches to know when to expect new hatchlings.")
                                            .FontRegular(size: 11, color: Color(red: 159/255, green: 61/255, blue: 0/255))
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
                        
                        Color.clear.frame(height: 55)
                    }
                    .padding(.bottom)
                }
            }
            
            if isShow {
                Color.black.opacity(0.6).ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            LinearGradient(colors: [Color(red: 247/255, green: 235/255, blue: 227/255),
                                                    Color(red: 190/255, green: 177/255, blue: 167/255)], startPoint: .top, endPoint: .bottom)
                            .frame(width: 350, height: 45)
                            .overlay {
                                HStack {
                                    Text("Settings")
                                        .FontBold(size: 24)
                                        .offset(y: 2)
                                        .padding(.leading, 50)
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation {
                                            isShow.toggle()
                                        }
                                    }) {
                                        Image(.settingsIcon)
                                            .resizable()
                                            .scaleEffect(x: -1)
                                            .frame(width: 20, height: 16)
                                    }
                                    .pressableButtonStyle()
                                    
                                }
                                .padding(.horizontal)
                            }
                            .clipShape(
                                RoundedCorners(radius: 12, corners: [.topRight, .bottomRight])
                            )
                            
                            Spacer()
                        }
                        
                        VStack {
                            LinearGradient(colors: [Color(red: 247/255, green: 235/255, blue: 227/255),
                                                    Color(red: 190/255, green: 177/255, blue: 167/255)], startPoint: .top, endPoint: .bottom)
                            .frame(width: 350, height: 55)
                            .overlay {
                                HStack {
                                    Text("Theme")
                                        .FontBold(size: 24)
                                        .offset(y: 2)
                                        .padding(.leading, 25)
                                    
                                    HStack {
                                        Image(.sun2)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 16, height: 16)
                                        
                                        Toggle("", isOn: $isOn)
                                            .toggleStyle(CustomToggleStyle())
                                            .frame(width: 48)
                                        
                                        Image(.moon)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 12, height: 16)
                                            .padding(.leading, 5)
                                    }
                                    .padding(.leading)
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                            .clipShape(
                                RoundedCorners(radius: 12, corners: [.allCorners])
                            )
                        }
                        
                        VStack {
                            LinearGradient(colors: [Color(red: 247/255, green: 235/255, blue: 227/255),
                                                    Color(red: 190/255, green: 177/255, blue: 167/255)], startPoint: .top, endPoint: .bottom)
                            .frame(width: 350, height: 145)
                            .overlay {
                                HStack(spacing: 20) {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text("Notifications")
                                            .FontBold(size: 16)
                                            .offset(y: 2)
                                            .padding(.leading, 25)
                                        
                                        Text("Vibration")
                                            .FontBold(size: 16)
                                            .offset(y: 2)
                                            .padding(.leading, 25)
                                        
                                        Text("Sounds")
                                            .FontBold(size: 16)
                                            .offset(y: 2)
                                            .padding(.leading, 25)
                                    }
                                    
                                    VStack(spacing: 20) {
                                        HStack(spacing: 5) {
                                            Image(.offIcn)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                            
                                            Toggle("", isOn: $isNotifOn)
                                                .toggleStyle(CustomToggleStyle())
                                                .frame(width: 48)
                                            
                                            Image(.onIcn)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                                .padding(.leading, 10)
                                        }
                                        
                                        HStack(spacing: 5) {
                                            Image(.offIcn)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                            
                                            Toggle("", isOn: $isVib)
                                                .toggleStyle(CustomToggleStyle())
                                                .frame(width: 48)
                                            
                                            Image(.onIcn)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                                .padding(.leading, 10)
                                        }
                                        
                                        HStack(spacing: 5) {
                                            Image(.offIcn)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                            
                                            Toggle("", isOn: $isSounds)
                                                .toggleStyle(CustomToggleStyle())
                                                .frame(width: 48)
                                            
                                            Image(.onIcn)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                                .padding(.leading, 10)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                            .clipShape(
                                RoundedCorners(radius: 12, corners: [.allCorners])
                            )
                        }
                    }
                    .padding(.top)
                }
                .transition(.move(edge: .leading))
            }
        }
    }
}

#Preview {
    ChikInfoView()
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 126/255, green: 98/255, blue: 88/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                .frame(width: 48, height: 20)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? Color(red: 204/255, green: 188/255, blue: 174/255) : Color(red: 126/255, green: 98/255, blue: 88/255))
                        .frame(width: 20, height: 20)
                        .offset(x: configuration.isOn ? 15 : -15)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct RoundedCornersSecond: Shape {
    var radius: CGFloat = 8
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct TwoRingProgressView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(red: 205/255, green: 153/255, blue: 100/255), lineWidth: 10)
                .frame(width: 200, height: 200)
            
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
                .frame(width: 200, height: 200)
            
            VStack(spacing: 0) {
                Image(.chikHappy)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 70)
                
                Text("Happy!")
                    .FontBold(size: 35, color: Color(red: 185/255, green: 255/255, blue: 73/255))
                
                Text(String(format: "%.0f%%", min(progress, 1.0) * 100))
                    .FontBold(size: 25, color: Color(red: 26/255, green: 244/255, blue: 103/255))
            }
            .offset(y: 10)
        }
    }
}
