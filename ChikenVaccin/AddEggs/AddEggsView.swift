import SwiftUI

struct AddEggsView: View {
    @StateObject var addEggsModel =  AddEggsViewModel()
    @State var name: String = ""
    @State var age: String = ""
    @State var totalEggs: String = ""
    @State var lastEgg: String = ""
    @State var chiken: String = ""
    @State private var showChikDropdown = false
    @State var chikens: [String] = []
    @Environment(\.presentationMode) var presentationMode
    @State private var showDateDropdown = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    
    private var last8Dates: [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        var dates: [String] = []
        let calendar = Calendar.current
        for i in (0...7).reversed() {
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                dates.append(formatter.string(from: date))
            }
        }
        return dates
    }

    var body: some View {
        ZStack {
            if UserDefaults.standard.bool(forKey: "isOns") {
                Color(red: 51/255, green: 62/255, blue: 96/255).ignoresSafeArea()
            } else {
                Color(red: 217/255, green: 205/255, blue: 195/255).ignoresSafeArea()
            }
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundStyle(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255))
                            .frame(width: 20, height: 16)
                    }
                    .pressableButtonStyle()
                    
                    Spacer()
                    
                    Text("Add Eggs")
                        .FontRegular(size: 20)
                }
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Total")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $name, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Date")
                                    .FontRegular(size: 16)
                                
                                ZStack {
                                    VStack(spacing: 0) {
                                        Button(action: {
                                            withAnimation {
                                                showDateDropdown.toggle()
                                            }
                                        }) {
                                            ZStack {
                                                Rectangle()
                                                    .fill(showDateDropdown ? (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 179/255, green: 210/255, blue: 255/255) : Color(red: 230/255, green: 218/255, blue: 208/255)) : (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 179/255, green: 210/255, blue: 255/255) : Color(red: 204/255, green: 188/255, blue: 174/255)))
                                                    .frame(height: 36)
                                                    .cornerRadius(8)
                                                
                                                HStack {
                                                    Text(lastEgg.isEmpty ? "" : lastEgg)
                                                        .FontRegular(size: 16, color: UserDefaults.standard.bool(forKey: "isOns") ? Color.black : Color(red: 126/255, green: 98/255, blue: 88/255))
                                                        .offset(y: 2)
                                                        .foregroundColor(lastEgg.isEmpty ? Color.gray : Color.black)
                                                    
                                                    Spacer()
                                                    
                                                    Image(UserDefaults.standard.bool(forKey: "isOns") ? "pinDark" : "pin")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 18, height: 15)
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                        
                                        if showDateDropdown {
                                            HStack {
                                                VStack(spacing: 0) {
                                                    ForEach(last8Dates, id: \.self) { date in
                                                        Text(date)
                                                            .FontRegular(size: 16, color: UserDefaults.standard.bool(forKey: "isOns") ? Color.black : Color(red: 126/255, green: 98/255, blue: 88/255))
                                                            .onTapGesture {
                                                                lastEgg = date
                                                                showDateDropdown = false
                                                            }
                                                    }
                                                }
                                                .padding(.top, 4)
                                                Spacer()
                                            }
                                            .frame(maxWidth: .infinity)
                                            .padding(.horizontal)
                                            .background(
                                                Color(red: UserDefaults.standard.bool(forKey: "isOns") ? 179/255 : 204/255, green: UserDefaults.standard.bool(forKey: "isOns") ? 210/255 : 188/255, blue: UserDefaults.standard.bool(forKey: "isOns") ? 255/255 : 174/255)
                                                    .clipShape(
                                                        RoundedCorners(radius: 8, corners: [.bottomLeft, .bottomRight])
                                                    )
                                            )
                                            .transition(.opacity.combined(with: .opacity))
                                            .offset(y: -5)
                                        }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Chiken")
                                    .FontRegular(size: 16)
                                
                                ZStack {
                                    VStack(spacing: 0) {
                                        Button(action: {
                                            withAnimation {
                                                showChikDropdown.toggle()
                                            }
                                        }) {
                                            ZStack {
                                                Rectangle()
                                                    .fill(showChikDropdown ? (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 179/255, green: 210/255, blue: 255/255) : Color(red: 230/255, green: 218/255, blue: 208/255)) : (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 179/255, green: 210/255, blue: 255/255) : Color(red: 204/255, green: 188/255, blue: 174/255)))
                                                    .frame(height: 36)
                                                    .cornerRadius(8)
                                                
                                                HStack {
                                                    Text(chiken.isEmpty ? "" : chiken)
                                                        .FontRegular(size: 16, color: UserDefaults.standard.bool(forKey: "isOns") ? Color.black : Color(red: 126/255, green: 98/255, blue: 88/255))
                                                        .offset(y: 2)
                                                        .foregroundColor(chiken.isEmpty ? Color.gray : Color.black)
                                                    
                                                    Spacer()
                                                    
                                                    Image(UserDefaults.standard.bool(forKey: "isOns") ? "pinDark" : "pin")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 18, height: 15)
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                        
                                        if showChikDropdown {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 0) {
                                                    ForEach(chikens, id: \.self) { date in
                                                        Text(date)
                                                            .FontRegular(size: 16, color: UserDefaults.standard.bool(forKey: "isOns") ? Color.black : Color(red: 126/255, green: 98/255, blue: 88/255))
                                                            .onTapGesture {
                                                                chiken = date
                                                                showChikDropdown = false
                                                            }
                                                    }
                                                }
                                                .padding(.top, 4)
                                                Spacer()
                                            }
                                            .frame(maxWidth: .infinity)
                                            .padding(.horizontal)
                                            .background(
                                                Color(red: UserDefaults.standard.bool(forKey: "isOns") ? 179/255 : 204/255, green: UserDefaults.standard.bool(forKey: "isOns") ? 210/255 : 188/255, blue: UserDefaults.standard.bool(forKey: "isOns") ? 255/255 : 174/255)
                                                    .clipShape(
                                                        RoundedCorners(radius: 8, corners: [.bottomLeft, .bottomRight])
                                                    )
                                            )
                                            .transition(.opacity.combined(with: .opacity))
                                            .offset(y: -5)
                                        }
                                    }
                                }
                            }
                        }
                        
                        VStack(spacing: 70) {
                            Image(.incubator)
                                .resizable()
                                .frame(width: 170, height: 220)
                                .aspectRatio(contentMode: .fit)
                            
                            Button(action: {
                                applyEggsUpdate()
                            }) {
                                Rectangle()
                                    .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 139/255, green: 152/255, blue: 190/255),
                                                                                                                Color(red: 111/255, green: 127/255, blue: 174/255)] : [Color(red: 126/255, green: 98/255, blue: 88/255),
                                                                  Color(red: 102/255, green: 74/255, blue: 65/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        Text("Apply")
                                            .FontLight(size: 16, color: .white)
                                            .offset(y: 2)
                                    }
                                    .frame(width: 120, height: 40)
                                    .cornerRadius(20)
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text(alertMessage))
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            let chicks = UserDefaultsManager.shared.loadChicks()
            chikens = chicks.map { $0.name }
        }
    }
    
    func applyEggsUpdate() {
        var chicks = UserDefaultsManager.shared.loadChicks()
        if let index = chicks.firstIndex(where: { $0.name == chiken }) {
            if let eggsCount = Int(name) {
                chicks[index].totalEggs += eggsCount
                chicks[index].eggsThisWeek += eggsCount
                chicks[index].lastEgg = lastEgg
                UserDefaultsManager.shared.updateChick(chicks[index])
                alertMessage = "Update successful"
                showAlert = true
            } else {
                alertMessage = "Invalid eggs count input"
                showAlert = true
            }
        } else {
            alertMessage = "Chicken not found"
            showAlert = true
        }
    }
}

#Preview {
    AddEggsView()
}

