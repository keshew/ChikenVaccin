import SwiftUI

struct ChikIncubatorView: View {
    @StateObject var chikIncubatorModel =  ChikIncubatorViewModel()
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
                    
                    Text("Incubation Batches")
                        .FontLight(size: 20)
                        .offset(y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
                if 1 != 1 {
                    Spacer()
                    
                    VStack(spacing: 23) {
                        Image(.incubator)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 350)
                        
                        Text("Add information about incubators so you\ncan always keep track of them.")
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
                                        .frame(height: 260)
                                        .overlay {
                                            VStack {
                                                HStack {
                                                    Image("incubator")
                                                        .resizable()
                                                        .frame(width: 30, height: 40)
                                                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                                        .background(Color(red: 230/255, green: 212/255, blue: 197/255))
                                                        .cornerRadius(8)
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text("Batch \(index + 1)")
                                                            .FontRegular(size: 18)
                                                        
                                                        Text("12 eggs incubating")
                                                            .FontRegular(size: 14)
                                                    }
                                                    .padding(.leading, 5)
                                                    
                                                    Spacer()
                                                    
                                                    Text(1 == 1 ? "Active" : "Hatching")
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
                                                
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        Rectangle()
                                                            .fill(Color(red: 204/255, green: 188/255, blue: 174/255))
                                                            .overlay {
                                                                VStack(spacing: 5) {
                                                                    HStack {
                                                                        Text("Progress")
                                                                            .FontLight(size: 10)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Text("Day 13 of 21")
                                                                            .FontLight(size: 10)
                                                                    }
                                                                    
                                                                    ZStack(alignment: .leading) {
                                                                        Rectangle()
                                                                            .fill(Color(red: 215/255, green: 198/255, blue: 182/255))
                                                                            .frame(width: 300, height: 8)
                                                                            .cornerRadius(10)
                                                                        
                                                                        Rectangle()
                                                                            .fill(LinearGradient(colors: [Color(red: 200/255, green: 232/255, blue: 67/255),
                                                                                                          Color(red: 174/255, green: 212/255, blue: 72/255),
                                                                                                          Color(red: 138/255, green: 179/255, blue: 4/255)], startPoint: .leading, endPoint: .trailing))
                                                                            .frame(width: 200, height: 8)
                                                                            .cornerRadius(10)
                                                                    }
                                                                    
                                                                    HStack(spacing: 5) {
                                                                        Text("8")
                                                                            .FontSemiBold(size: 18, color: Color(red: 102/255, green: 132/255, blue: 0/255))
                                                                        
                                                                        Text("days left")
                                                                            .FontRegular(size: 14)
                                                                    }
                                                                    
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                            .cornerRadius(12)
                                                            .frame(height: 70)
                                                    }
                                                    
                                                    HStack {
                                                        Rectangle()
                                                            .fill(Color(red: 204/255, green: 188/255, blue: 174/255))
                                                            .overlay {
                                                                VStack(spacing: -3) {
                                                                    Text("Temperature")
                                                                        .FontRegular(size: 10)
                                                                    
                                                                    Text("37.5 C")
                                                                        .FontExtraBold(size: 28)
                                                                }
                                                                .offset(y: 5)
                                                            }
                                                            .cornerRadius(12)
                                                            .frame(height: 55)
                                                        
                                                        Rectangle()
                                                            .fill(Color(red: 204/255, green: 188/255, blue: 174/255))
                                                            .overlay {
                                                                VStack(spacing: -3) {
                                                                    Text("Humidity")
                                                                        .FontRegular(size: 10)
                                                                    
                                                                    Text("55%")
                                                                        .FontExtraBold(size: 28)
                                                                }
                                                                .offset(y: 5)
                                                            }
                                                            .cornerRadius(12)
                                                            .frame(height: 55)
                                                    }
                                                    
                                                    Text("Expected Hatch Date")
                                                        .FontLight(size: 10)
                                                    
                                                    Text("02.05.2024")
                                                        .FontExtraBold(size: 12)
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
                            
                            Color.clear.frame(height: 50)
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
    }
}

#Preview {
    ChikIncubatorView()
}

