import SwiftUI

struct ChikIncubatorView: View {
    @StateObject var chikIncubatorModel =  ChikIncubatorViewModel()
    @State private var menusShown = [UUID: Bool]()
    
    var body: some View {
        ZStack {
            if chikIncubatorModel.batch.isEmpty {
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
                    
                    Text("Incubation Batches")
                        .FontLight(size: 20)
                        .offset(y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
                if chikIncubatorModel.batch.isEmpty{
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
                            ForEach(chikIncubatorModel.batch, id: \.id) { index in
                                ZStack(alignment: .topTrailing) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                   Color(red: 28/255, green: 38/255, blue: 69/255)] : [Color(red: 247/255, green: 235/255, blue: 227/255),
                                                                                                                                                                                          Color(red: 190/255, green: 177/255, blue: 167/255)], startPoint: .top, endPoint: .bottom))
                                        .frame(height: 260)
                                        .overlay {
                                            VStack {
                                                HStack {
                                                    Image("incubator")
                                                        .resizable()
                                                        .frame(width: 30, height: 40)
                                                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                                        .background(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 20/255, green: 32/255, blue: 46/255) : Color(red: 230/255, green: 212/255, blue: 197/255))
                                                        .cornerRadius(8)
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text("")
                                                            .FontRegular(size: 18)
                                                        
                                                        Text("\(index.totalEggs) eggs incubating")
                                                            .FontRegular(size: 14)
                                                    }
                                                    .padding(.leading, 5)
                                                    
                                                    Spacer()
                                                    
                                                    Text(index.currentDay < 17 ? "Active" : "Hatching")
                                                        .FontRegular(size: 12, color: .white)
                                                        .padding(EdgeInsets(top: 3, leading: 25, bottom: 3, trailing: 25))
                                                        .background(index.currentDay < 17 ? Color(red: 155/255, green: 207/255, blue: 57/255) : Color(red: 233/255, green: 145/255, blue: 79/255))
                                                        .cornerRadius(18)
                                                        .padding(.trailing, 10)
                                                    
                                                    Button(action: {
                                                        withAnimation {
                                                            menusShown[index.id] = !(menusShown[index.id] ?? false)
                                                        }
                                                    }) {
                                                        Image(UserDefaults.standard.bool(forKey: "isOns") ? "editDark" : "edit")
                                                            .resizable()
                                                            .frame(width: 6, height: 20)
                                                    }
                                                }
                                                
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                        Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                                          Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                                          Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom))
                                                            .overlay {
                                                                VStack(spacing: 5) {
                                                                    HStack {
                                                                        Text("Progress")
                                                                            .FontLight(size: 10)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Text("Day \(index.currentDay) of 21")
                                                                            .FontLight(size: 10)
                                                                    }
                                                                    
                                                                    ZStack(alignment: .leading) {
                                                                        Rectangle()
                                                                            .fill( UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 215/255, green: 198/255, blue: 182/255))
                                                                            .frame(width: 300, height: 8)
                                                                            .cornerRadius(10)

                                                                        Rectangle()
                                                                            .fill(LinearGradient(colors: [Color(red: 200/255, green: 232/255, blue: 67/255),
                                                                                                         Color(red: 174/255, green: 212/255, blue: 72/255),
                                                                                                         Color(red: 138/255, green: 179/255, blue: 4/255)],
                                                                                                 startPoint: .leading, endPoint: .trailing))
                                                                            .frame(width: 300 * progressPercent(currentDay: Int(index.currentDay)), height: 8)
                                                                            .cornerRadius(10)
                                                                    }
                                                                    
                                                                    HStack(spacing: 5) {
                                                                        Text("\(daysLeft(currentDay: index.currentDay))")
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
                                                            .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                        Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                                          Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                                          Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom))
                                                            .overlay {
                                                                VStack(spacing: -3) {
                                                                    Text("Temperature")
                                                                        .FontRegular(size: 10)
                                                                    
                                                                    Text("\(index.temperature)C")
                                                                        .FontExtraBold(size: 28)
                                                                }
                                                                .offset(y: 5)
                                                            }
                                                            .cornerRadius(12)
                                                            .frame(height: 55)
                                                        
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                        Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                                          Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                                          Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom))
                                                            .overlay {
                                                                VStack(spacing: -3) {
                                                                    Text("Humidity")
                                                                        .FontRegular(size: 10)
                                                                    
                                                                    Text("\(Int(progressPercent(currentDay: Int(index.currentDay)) * 100))%")
                                                                        .FontExtraBold(size: 28)
                                                                }
                                                                .offset(y: 5)
                                                            }
                                                            .cornerRadius(12)
                                                            .frame(height: 55)
                                                    }
                                                    
                                                    Text("Expected Hatch Date")
                                                        .FontLight(size: 10)
                                                    
                                                    Text(expectedHatchDate(startDateString: index.expectedHatchData))
                                                        .FontExtraBold(size: 12)
                                                }
                                            }
                                            .padding(.horizontal, 20)
                                        }
                                        .cornerRadius(15)
                                        .padding(.horizontal)
                                        .padding(.leading, 5)
                                        .shadow(color: index.currentDay < 17 ? Color(red: 155/255, green: 207/255, blue: 57/255) : Color(red: 233/255, green: 145/255, blue: 79/255), radius: 0, x: -5)
                                    
                                    Group {
                                        if menusShown[index.id] == true {
                                            VStack(alignment: .trailing, spacing: 5) {
                                                Button(action: {
                                                    withAnimation {
                                                        UserDefaultsManager().deleteBatch(index)
                                                        chikIncubatorModel.loadBatches()
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
    
    func expectedHatchDate(startDateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        guard let startDate = formatter.date(from: startDateString) else { return "" }
        
        if let hatchDate = Calendar.current.date(byAdding: .day, value: 21, to: startDate) {
            return formatter.string(from: hatchDate)
        }
        return ""
    }
    
    func progressPercent(currentDay: Int) -> Double {
        return min(Double(currentDay) / 21.0, 1.0)
    }
    
    func daysLeft(currentDay: Int) -> Int {
        return max(21 - currentDay, 0)
    }
}

#Preview {
    ChikIncubatorView()
}

