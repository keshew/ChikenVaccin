import SwiftUI

struct VaccineModel:Identifiable, Codable {
    var id = UUID()
    var name: String
    var chiken: MyChickModel
    var notes: String
    var date: String
}

struct AddVaccinationView: View {
    @StateObject var addVaccinationModel =  AddVaccinationViewModel()
    @State var name: String = ""
    @State var startDate: String = ""
    @State var totalEggs: String = ""
    @State var temp: String = ""
    @State private var showDateDropdown = false
    @State var chiken: String = ""
    @State private var showChikDropdown = false
    @State var chikens = ["Henrietta", "Clucky"]
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
            Color(red: 250/255, green: 229/255, blue: 196/255).ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundStyle(Color(red: 126/255, green: 98/255, blue: 88/255))
                            .frame(width: 20, height: 16)
                    }
                    .pressableButtonStyle()
                    
                    Spacer()
                    
                    Text("Vaccination Schedule")
                        .FontRegular(size: 20)
                }
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Name of the Vaccine")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $name, placeholder: "")
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
                                                    .fill(showChikDropdown ? Color(red: 230/255, green: 218/255, blue: 208/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                                                    .frame(height: 36)
                                                    .cornerRadius(8)
                                                
                                                HStack {
                                                    Text(chiken.isEmpty ? "" : chiken)
                                                        .FontRegular(size: 16)
                                                        .offset(y: 2)
                                                        .foregroundColor(chiken.isEmpty ? Color.gray : Color.black)
                                                    
                                                    Spacer()
                                                    
                                                    Image("pin")
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
                                                            .FontRegular(size: 16)
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
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Notes")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $temp, placeholder: "")
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
                                                    .fill(showDateDropdown ? Color(red: 230/255, green: 218/255, blue: 208/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                                                    .frame(height: 36)
                                                    .cornerRadius(8)
                                                
                                                HStack {
                                                    Text(startDate.isEmpty ? "" : startDate)
                                                        .FontRegular(size: 16)
                                                        .offset(y: 2)
                                                        .foregroundColor(startDate.isEmpty ? Color.gray : Color.black)
                                                    
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
                            Image(.vaccine)
                                .resizable()
                                .frame(width: 130, height: 220)
                                .aspectRatio(contentMode: .fit)
                            
                            Button(action: {
                                addVaccinationModel.saveVaccine(name: name, chikenName: chiken, notes: temp, date: startDate)
                            }) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 126/255, green: 98/255, blue: 88/255),
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
        .alert(isPresented: $addVaccinationModel.showAlert) {
            Alert(title: Text(addVaccinationModel.alertMessage))
        }
        .onAppear {
            chikens = UserDefaultsManager.shared.loadChicks().map { $0.name }
        }
    }
}

#Preview {
    AddVaccinationView()
}

