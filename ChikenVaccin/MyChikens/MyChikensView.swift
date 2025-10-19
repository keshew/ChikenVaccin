import SwiftUI

struct MyChikensView: View {
    @StateObject var myChikensModel =  MyChikensViewModel()
    @State private var showMenu = false
    var body: some View {
        ZStack {
            if 1 != 1 {
                LinearGradient(colors: [Color(red: 231/255, green: 211/255, blue: 195/255),
                                        Color(red: 235/255, green: 200/255, blue: 173/255)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            } else {
                Color(red: 217/255, green: 205/255, blue: 195/255).ignoresSafeArea()
            }
            
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
                    
                    Text("My Chickens")
                        .FontLight(size: 20)
                        .offset(y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
                
                if 1 != 1 {
                    Spacer()
                    
                    VStack(spacing: 23) {
                        Image(.chik)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 280)
                        
                        Text("Add your chickens here to always\nkeep track of the information.")
                            .FontRegular(size: 14)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 90)
                    
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 15) {
                            ForEach(0..<3, id: \.self) { index in
                                ZStack(alignment: .topTrailing) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 243/255, green: 230/255, blue: 217/255),
                                                                      Color(red: 230/255, green: 210/255, blue: 192/255)], startPoint: .top, endPoint: .bottom))
                                        .frame(height: 270)
                                        .overlay {
                                            VStack {
                                                HStack {
                                                    Image("chikType\(index + 1)")
                                                        .resizable()
                                                        .frame(width: 30, height: 40)
                                                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                                        .background(Color(red: 230/255, green: 212/255, blue: 197/255))
                                                        .cornerRadius(8)
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text("Clucky")
                                                            .FontRegular(size: 18)
                                                        
                                                        Text("Leghorn")
                                                            .FontRegular(size: 14)
                                                    }
                                                    .padding(.leading, 5)
                                                    
                                                    Spacer()
                                                    
                                                    Text(1 == 1 ? "Healhty" : "Needs attention")
                                                        .FontRegular(size: 12, color: .white)
                                                        .padding(EdgeInsets(top: 3, leading: 25, bottom: 3, trailing: 25))
                                                        .background(1 == 1 ? Color(red: 155/255, green: 207/255, blue: 57/255) : Color(red: 233/255, green: 145/255, blue: 79/255))
                                                        .cornerRadius(18)
                                                        .padding(.trailing, 10)
                                                    
                                                    Button(action: {
                                                        withAnimation {
                                                            showMenu.toggle()
                                                        }
                                                    }) {
                                                        Image("edit")
                                                            .resizable()
                                                            .frame(width: 6, height: 20)
                                                    }
                                                }
                                                
                                                VStack {
                                                    HStack {
                                                        ZStack(alignment: .topLeading) {
                                                            Rectangle()
                                                                .fill(LinearGradient(colors: [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                                              Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                                              Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom))
                                                                .overlay {
                                                                    VStack(spacing: 0) {
                                                                        Text("Age")
                                                                            .FontRegular(size: 10, color: Color(red: 95/255, green: 132/255, blue: 24/255))
                                                                        
                                                                        VStack(spacing: -8) {
                                                                            Text("28")
                                                                                .FontExtraBold(size: 24)
                                                                            
                                                                            Text("weeks")
                                                                                .FontLight(size: 14)
                                                                        }
                                                                    }
                                                                }
                                                                .cornerRadius(12)
                                                                .frame(height: 80)
                                                            
                                                            Image(.age)
                                                                .resizable()
                                                                .frame(width: 35, height: 23)
                                                                .offset(x: 5, y: 5)
                                                        }
                                                        
                                                        ZStack(alignment: .topLeading) {
                                                            Rectangle()
                                                                .fill(LinearGradient(colors: [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                                              Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                                              Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom))
                                                                .overlay {
                                                                    VStack(spacing: 0) {
                                                                        Text("Total Eggs")
                                                                            .FontRegular(size: 10, color: Color(red: 95/255, green: 132/255, blue: 24/255))
                                                                        
                                                                        VStack(spacing: -8) {
                                                                            Text("142")
                                                                                .FontExtraBold(size: 24)
                                                                            
                                                                            Text("weeks")
                                                                                .FontLight(size: 14)
                                                                                .hidden()
                                                                        }
                                                                    }
                                                                }
                                                                .cornerRadius(12)
                                                                .frame(height: 80)
                                                            
                                                            Image(.total)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 20, height: 23)
                                                                .offset(x: 5, y: 5)
                                                        }
                                                    }
                                                    
                                                    HStack {
                                                        ZStack(alignment: .topLeading) {
                                                            Rectangle()
                                                                .fill(LinearGradient(colors: [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                                              Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                                              Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom))
                                                                .overlay {
                                                                    VStack(spacing: 0) {
                                                                        Text("This Week")
                                                                            .FontRegular(size: 10, color: Color(red: 95/255, green: 132/255, blue: 24/255))
                                                                        
                                                                        VStack(spacing: -8) {
                                                                            Text("5")
                                                                                .FontExtraBold(size: 24)
                                                                            
                                                                            Text("eggs")
                                                                                .FontLight(size: 14)
                                                                        }
                                                                    }
                                                                }
                                                                .cornerRadius(12)
                                                                .frame(height: 80)
                                                            
                                                            Image(.thisweek)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 17, height: 23)
                                                                .offset(x: 5, y: 5)
                                                        }
                                                        
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                                          Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                                          Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom))
                                                            .overlay {
                                                                VStack(spacing: 0) {
                                                                    Text("Last Egg")
                                                                        .FontRegular(size: 10, color: Color(red: 95/255, green: 132/255, blue: 24/255))
                                                                    
                                                                    VStack(spacing: -8) {
                                                                        Text("Today")
                                                                            .FontExtraBold(size: 24)
                                                                        
                                                                        Text("weeks")
                                                                            .FontLight(size: 14)
                                                                            .hidden()
                                                                    }
                                                                }
                                                            }
                                                            .cornerRadius(12)
                                                            .frame(height: 80)
                                                    }
                                                }
                                            }
                                            .padding(.horizontal, 20)
                                        }
                                        .cornerRadius(15)
                                        .padding(.horizontal)
                                        .padding(.leading, 5)
                                        .shadow(color: 1 == 1 ? Color(red: 155/255, green: 207/255, blue: 57/255) : Color(red: 233/255, green: 145/255, blue: 79/255), radius: 0, x: -5)
                                    
                                    Group {
                                        if showMenu {
                                            VStack(alignment: .trailing, spacing: 5) {
                                                Button(action: {
                                                    
                                                }) {
                                                    Text("Edit")
                                                        .FontLight(size: 12)
                                                }
                                                
                                                Rectangle()
                                                    .fill(Color(red: 204/255, green: 188/255, blue: 174/255))
                                                    .frame(height: 1)
                                                    .cornerRadius(2)
                                                
                                                Button(action: {
                                                    
                                                }) {
                                                    Text("Delete")
                                                        .FontLight(size: 12)
                                                }
                                            }
                                            .padding(EdgeInsets(top: 8, leading: 10, bottom: 10, trailing: 10))
                                            .background(
                                                Rectangle()
                                                    .fill(LinearGradient(
                                                        colors: [Color(red: 243/255, green: 230/255, blue: 217/255),
                                                                 Color(red: 230/255, green: 210/255, blue: 192/255)],
                                                        startPoint: .top, endPoint: .bottom))
                                                    .cornerRadius(8)
                                                    .shadow(radius: 5, y: 3)
                                            )
                                            .frame(width: 80)
                                            .offset(x: -50, y: 30)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
    }
}

#Preview {
    MyChikensView()
}

