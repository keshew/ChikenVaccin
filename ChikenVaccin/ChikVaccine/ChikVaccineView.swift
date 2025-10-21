import SwiftUI

struct ChikVaccineView: View {
    @StateObject var chikVaccineModel =  ChikVaccineViewModel()
    @State private var menusShown = [UUID: Bool]()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            if UserDefaults.standard.bool(forKey: "isOns") {
                Color(red: 33/255, green: 34/255, blue: 36/255).ignoresSafeArea()
            } else {
                Color(red: 217/255, green: 205/255, blue: 195/255).ignoresSafeArea()
            }
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundStyle(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255))
                            .frame(width: 20, height: 16)
                    }
                    .pressableButtonStyle()
                    
                    Spacer()
                    
                    Text("Vaccination Schedule")
                        .FontLight(size: 20)
                        .offset(y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(chikVaccineModel.vaccines, id: \.id) { chick in
                            let (color, labelText, shadowColor) = statusColorAndText(for: chick.date)
                            ZStack(alignment: .topTrailing) {
                                Rectangle()
                                    .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                               Color(red: 28/255, green: 38/255, blue: 69/255)] : [Color(red: 247/255, green: 235/255, blue: 227/255),
                                                                                                                                                                                      Color(red: 190/255, green: 177/255, blue: 167/255)], startPoint: .top, endPoint: .bottom))
                                    .frame(height: !chick.notes.isEmpty ? 220 : 150)
                                    .overlay {
                                        VStack(alignment: .leading, spacing: 10) {
                                            HStack {
                                                Image("vaccine")
                                                    .resizable()
                                                    .frame(width: 25, height: 40)
                                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                                    .background(Color(red: 230/255, green: 212/255, blue: 197/255))
                                                    .cornerRadius(8)
                                                
                                                VStack(alignment: .leading) {
                                                    Text(chick.name)
                                                        .FontRegular(size: 18)
                                                    
                                                    Text(chick.chiken.name)
                                                        .FontRegular(size: 18)
                                                }
                                                .padding(.leading, 5)
                                                
                                                Spacer()
                                                
                                                Text(labelText)
                                                    .FontRegular(size: 12, color: .white)
                                                    .padding(EdgeInsets(top: 3, leading: 25, bottom: 3, trailing: 25))
                                                    .background(color)
                                                    .cornerRadius(18)
                                                    .padding(.trailing, 10)
                                                    .lineLimit(1)
                                                    .minimumScaleFactor(0.6)
                                                
                                                Button(action: {
                                                    withAnimation {
                                                        menusShown[chick.id] = !(menusShown[chick.id] ?? false)
                                                    }
                                                }) {
                                                    Image("edit")
                                                        .resizable()
                                                        .frame(width: 6, height: 20)
                                                }
                                            }
                                            
                                            if !chick.notes.isEmpty {
                                                Rectangle()
                                                    .fill(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 27/255, green: 46/255, blue: 70/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                                                    .overlay {
                                                        HStack {
                                                            VStack(alignment: .leading, spacing: 0) {
                                                                Text("Notes")
                                                                    .FontRegular(size: 10, color: Color(red: 95/255, green: 132/255, blue: 24/255))
                                                                
                                                                VStack(spacing: -8) {
                                                                    Text(chick.notes)
                                                                        .FontLight(size: 18)
                                                                }
                                                                
                                                            }
                                                            Spacer()
                                                        }
                                                        .padding(.horizontal)
                                                    }
                                                    .cornerRadius(12)
                                                    .frame(height: 70)
                                            }
                                            
                                            VStack(alignment: .leading) {
                                                Text("Due Date")
                                                    .FontLight(size: 10)
                                                
                                                Text("\(dateByAddingThreeMonths(to: chick.date) ?? chick.date)")
                                                    .FontExtraBold(size: 20)
                                            }
                                        }
                                        .padding(.horizontal, 20)
                                    }
                                    .cornerRadius(15)
                                    .padding(.horizontal)
                                    .padding(.leading, 5)
                                    .shadow(color: shadowColor, radius: 0, x: -5)
                                
                                Group {
                                    if menusShown[chick.id] == true {
                                        VStack(alignment: .trailing, spacing: 5) {
                                            Button(action: {
                                                withAnimation {
                                                    UserDefaultsManager().deleteVaccine(chick)
                                                    chikVaccineModel.loadVaccines()
                                                }
                                            }) {
                                                Text("Delete")
                                                    .FontLight(size: 12)
                                                
                                            }
                                            .offset(y: 1)
                                        }
                                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
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
    
    func dateByAddingThreeMonths(to dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        guard let date = formatter.date(from: dateString) else { return nil }
        if let newDate = Calendar.current.date(byAdding: .month, value: 3, to: date) {
            return formatter.string(from: newDate)
        }
        return nil
    }

    func statusColorAndText(for dateString: String) -> (color: Color, text: String, shadowColor: Color) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        guard let date = formatter.date(from: dateString) else {
            return (Color.green, "Due", Color(red: 155/255, green: 207/255, blue: 57/255))
        }
        guard let checkDate = Calendar.current.date(byAdding: .month, value: 3, to: date) else {
            return (Color.green, "Due", Color(red: 155/255, green: 207/255, blue: 57/255))
        }
        if Date() > checkDate {
            return (Color.red, "Overdue", Color.red)
        } else {
            return (Color(red: 155/255, green: 207/255, blue: 57/255), "Due", Color(red: 155/255, green: 207/255, blue: 57/255))
        }
    }
}

#Preview {
    ChikVaccineView()
}

