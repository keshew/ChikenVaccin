import SwiftUI

struct AddBatchView: View {
    @StateObject var addBatchModel =  AddBatchViewModel()
    @State var name: String = ""
    @State var startDate: String = ""
    @State var totalEggs: String = ""
    @State var temp: String = ""
    @State private var showDateDropdown = false
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSuccessAlert = false
    @State private var successMessage = ""
    
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
                    
                    Text("New Batch")
                        .FontRegular(size: 20)
                }
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Batch Name")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $name, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Total Eggs")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $totalEggs, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Temperature")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $temp, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Start Date")
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
                                                    Text(startDate.isEmpty ? "" : startDate)
                                                        .FontRegular(size: 16, color: UserDefaults.standard.bool(forKey: "isOns") ? Color.black : Color(red: 126/255, green: 98/255, blue: 88/255))
                                                        .offset(y: 2)
                                                        .foregroundColor(startDate.isEmpty ? Color.gray : Color.black)
                                                    
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
                                                                startDate = date
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
                        }
                        
                        VStack(spacing: 70) {
                            Image(.batch)
                                .resizable()
                                .frame(width: 190, height: 220)
                                .aspectRatio(contentMode: .fit)
                            
                            Button(action: {
                                if !isNumeric(totalEggs) {
                                    alertMessage = "Total Eggs must contain only numbers."
                                    showAlert = true
                                    return
                                }
                                if !isNumeric(temp) {
                                    alertMessage = "Temperature must contain only numbers."
                                    showAlert = true
                                    return
                                }
                                
                                addBatchModel.saveBatch(name: name, startDate: startDate, totalEggs: totalEggs, temp: temp)
                                successMessage = "Batch saved successfully!"
                                showSuccessAlert = true
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
                        }
                    }
                    .padding(.bottom)
                }
            }
            .padding(.horizontal)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .alert(successMessage, isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) { }
        }
        
    }
    
    func isNumeric(_ value: String) -> Bool {
        return !value.isEmpty && value.allSatisfy { $0.isNumber }
    }
}

#Preview {
    AddBatchView()
}

