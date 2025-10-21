import SwiftUI

struct AddChikView: View {
    @StateObject var addChikModel = AddChikViewModel()
    @State var name: String = ""
    @State var age: String = ""
    @State var totalEggs: String = ""
    @State var lastEgg: String = ""
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
                    
                    Text("Add Chiken")
                        .FontRegular(size: 20)
                }
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Name")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $name, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Age (weeks)")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $age, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Total Eggs")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $totalEggs, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Last Egg")
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
                                                    .fill(showDateDropdown ? (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 188/255, green: 199/255, blue: 238/255) : Color(red: 230/255, green: 218/255, blue: 208/255)) : (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 204/255, green: 188/255, blue: 174/255)))
                                                    .frame(height: 36)
                                                    .cornerRadius(8)
                                                
                                                HStack {
                                                    Text(lastEgg.isEmpty ? "" : lastEgg)
                                                        .FontRegular(size: 16)
                                                        .offset(y: 2)
                                                        .foregroundColor(lastEgg.isEmpty ? Color.gray : Color.black)
                                                    
                                                    Spacer()
                                                    
                                                    Image("pin")
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
                                                            .FontRegular(size: 16)
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
                                                Color(red: 204/255, green: 188/255, blue: 174/255)
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
                            Image(.chikHappy)
                                .resizable()
                                .frame(width: 150, height: 220)
                                .aspectRatio(contentMode: .fit)
                            
                            Button(action: {
                                if !isNumeric(age) {
                                    alertMessage = "Age must contain only numbers."
                                    showAlert = true
                                    return
                                }
                                if !isNumeric(totalEggs) {
                                    alertMessage = "Total Eggs must contain only numbers."
                                    showAlert = true
                                    return
                                }

                                successMessage = "Chick saved successfully!"
                                showSuccessAlert = true
                                addChikModel.saveChick(name: name, age: age, totalEggs: totalEggs, lastEgg: lastEgg)
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
    AddChikView()
}

struct RoundedCorners: Shape {
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

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                .frame(height: 36)
                .cornerRadius(8)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .frame(height: 36)
            .font(.custom("Quicksand-Regular", size: 15))
            .cornerRadius(8)
            .foregroundStyle(.black)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .FontRegular(size: 16, color: Color(red: 153/255, green: 173/255, blue: 200/255))
                    .frame(height: 36)
                    .padding(.leading, 30)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}
