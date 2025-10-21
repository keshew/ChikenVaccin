import SwiftUI

struct InvenrtoryModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var notes: String
    var supplier: String
    var stock: String
    var expirationDate: String
}

struct AddInventoryView: View {
    @StateObject var addInventoryModel =  AddInventoryViewModel()
    @State var name: String = ""
    @State var type: String = ""
    @State var notes: String = ""
    @State var supplier: String = ""
    @State var stock: String = ""
    @State var lastEgg: String = ""
    @State private var showDateDropdown = false
    @Environment(\.presentationMode) var presentationMode
    
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
                    
                    Text("Medicine Inventory")
                        .FontRegular(size: 20)
                }
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Name of Medicine")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $name, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Type of Medication")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $type, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Notes")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $notes, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Supplier")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $supplier, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Stock")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $stock, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Expiration Date")
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
                        
                        VStack(spacing: 50) {
                            Image(.inventory)
                                .resizable()
                                .frame(width: 90, height: 150)
                                .aspectRatio(contentMode: .fit)
                            
                            Button(action: {
                                addInventoryModel.saveInventoryItem(name: name, type: type, notes: notes, supplier: supplier, stock: stock, expirationDate: lastEgg)
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
                            .alert(isPresented: $addInventoryModel.showAlert) {
                                Alert(title: Text(addInventoryModel.alertMessage))
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AddInventoryView()
}

