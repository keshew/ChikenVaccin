import SwiftUI

struct MyChikensView: View {
    @StateObject var myChikensModel =  MyChikensViewModel()
    @State private var showMenu = false
    @State private var menusShown = [UUID: Bool]()
    
    func lastEggFormatted(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        
        guard let date = formatter.date(from: dateString) else {
            return dateString
        }
        
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfEggDate = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: startOfEggDate, to: startOfToday)
        let days = components.day ?? 0
        
        if days == 0 {
            return "Today"
        } else {
            return "\(days) days ago"
        }
    }
    
    
    var body: some View {
        ZStack {
            if myChikensModel.chicks.isEmpty {
                if UserDefaults.standard.bool(forKey: "isOns") {
                    Color(red: 33/255, green: 34/255, blue: 36/255).ignoresSafeArea()
                } else {
                    LinearGradient(colors: [Color(red: 231/255, green: 211/255, blue: 195/255),
                                            Color(red: 235/255, green: 200/255, blue: 173/255)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                }
            } else {
                if UserDefaults.standard.bool(forKey: "isOns") {
                    Color(red: 33/255, green: 34/255, blue: 36/255).ignoresSafeArea()
                } else {
                    Color(red: 217/255, green: 205/255, blue: 195/255).ignoresSafeArea()
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("My Chickens")
                        .FontLight(size: 20)
                        .offset(y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
                
                if myChikensModel.chicks.isEmpty {
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
                            ForEach(myChikensModel.chicks, id: \.id) { chick in
                                ZStack(alignment: .topTrailing) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                   Color(red: 28/255, green: 38/255, blue: 69/255)] : [Color(red: 247/255, green: 235/255, blue: 227/255),
                                                                                                                                                                                          Color(red: 190/255, green: 177/255, blue: 167/255)], startPoint: .top, endPoint: .bottom))
                                        .frame(height: 270)
                                        .overlay {
                                            VStack {
                                                HStack {
                                                    Image(chick.image)
                                                        .resizable()
                                                        .frame(width: 30, height: 40)
                                                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                                        .background(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 20/255, green: 32/255, blue: 46/255) : Color(red: 230/255, green: 212/255, blue: 197/255))
                                                        .cornerRadius(8)
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(chick.name)
                                                            .FontRegular(size: 18)
                                                    }
                                                    .padding(.leading, 5)
                                                    
                                                    Spacer()
                                                    
                                                    Text(chick.isHealthy ? "Healthy" : "Needs attention")
                                                        .FontRegular(size: 12, color: .white)
                                                        .padding(EdgeInsets(top: 3, leading: 25, bottom: 3, trailing: 25))
                                                        .background(chick.isHealthy ? Color(red: 155/255, green: 207/255, blue: 57/255) : Color(red: 233/255, green: 145/255, blue: 79/255))
                                                        .cornerRadius(18)
                                                        .padding(.trailing, 10)
                                                        .lineLimit(1)
                                                        .minimumScaleFactor(0.6)
                                                    
                                                    Button(action: {
                                                        withAnimation {
                                                            menusShown[chick.id] = !(menusShown[chick.id] ?? false)
                                                        }
                                                    }) {
                                                        Image(UserDefaults.standard.bool(forKey: "isOns") ? "editDark" : "edit")
                                                            .resizable()
                                                            .frame(width: 6, height: 20)
                                                    }
                                                }
                                                
                                                VStack {
                                                    HStack {
                                                        ZStack(alignment: .topLeading) {
                                                            Rectangle()
                                                                .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                            Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 204/255, green: 188/255, blue: 174/255)], startPoint: .top, endPoint: .bottom))
                                                                .overlay {
                                                                    VStack(spacing: 0) {
                                                                        Text("Age")
                                                                            .FontRegular(size: 10, color: Color(red: 95/255, green: 132/255, blue: 24/255))
                                                                        
                                                                        VStack(spacing: -8) {
                                                                            Text("\(chick.ageInWeek)")
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
                                                                .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                            Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 204/255, green: 188/255, blue: 174/255)], startPoint: .top, endPoint: .bottom))
                                                                .overlay {
                                                                    VStack(spacing: 0) {
                                                                        Text("Total Eggs")
                                                                            .FontRegular(size: 10, color: Color(red: 95/255, green: 132/255, blue: 24/255))
                                                                        
                                                                        VStack(spacing: -8) {
                                                                            Text("\(chick.eggsThisWeek)")
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
                                                                .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                            Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 204/255, green: 188/255, blue: 174/255)], startPoint: .top, endPoint: .bottom))
                                                                .overlay {
                                                                    VStack(spacing: 0) {
                                                                        Text("This Week")
                                                                            .FontRegular(size: 10, color: Color(red: 95/255, green: 132/255, blue: 24/255))
                                                                        
                                                                        VStack(spacing: -8) {
                                                                            Text("\(chick.eggsThisWeek)")
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
                                                            .fill(chick.isHealthy ? LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                                          Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                                                            Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                                                            Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom) : LinearGradient(colors: [Color(red: 220/255, green: 189/255, blue: 157/255),
                                                                                                                                                                                                                                Color(red: 205/255, green: 164/255, blue: 138/255)], startPoint: .top, endPoint: .bottom))
                                                            .overlay {
                                                                VStack(spacing: 0) {
                                                                    Text("Last Egg")
                                                                        .FontRegular(size: 10, color: chick.isHealthy ? Color(red: 95/255, green: 132/255, blue: 24/255) : Color(red: 159/255, green: 61/255, blue: 0/255))
                                                                    
                                                                    VStack(spacing: -8) {
                                                                        Text(lastEggFormatted(from: chick.lastEgg))
                                                                            .FontExtraBold(size: 24, color: chick.isHealthy ? Color(red: 95/255, green: 132/255, blue: 24/255) : Color(red: 159/255, green: 61/255, blue: 0/255))
                                                                        
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
                                        .shadow(color: chick.isHealthy ? Color(red: 155/255, green: 207/255, blue: 57/255) : Color(red: 233/255, green: 145/255, blue: 79/255), radius: 0, x: -5)
                                    
                                    Group {
                                        if menusShown[chick.id] == true {
                                            VStack(alignment: .trailing, spacing: 5) {
                                                Button(action: {
                                                    withAnimation {
                                                        UserDefaultsManager().deleteChick(chick)
                                                        myChikensModel.loadChicks()
                                                    }
                                                }) {
                                                    Text("Delete")
                                                        .FontLight(size: 12, color: UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 51/255, green: 53/255, blue: 63/255) : Color(red: 126/255, green: 98/255, blue: 88/255))
                                                }
                                            }
                                            .padding(EdgeInsets(top: 8, leading: 10, bottom: 10, trailing: 10))
                                            .background(
                                                Rectangle()
                                                    .fill(LinearGradient(
                                                        colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 171/255, green: 181/255, blue: 210/255)] : [Color(red: 243/255, green: 230/255, blue: 217/255),
                                                                                                                                                                      Color(red: 230/255, green: 210/255, blue: 192/255)],
                                                        startPoint: .top, endPoint: .bottom))
                                                    .cornerRadius(8)
                                                    .shadow(radius: 5, y: 3)
                                            )
                                            .frame(width: 80)
                                            .offset(x: -30, y: 40)
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
    MyChikensView()
}

