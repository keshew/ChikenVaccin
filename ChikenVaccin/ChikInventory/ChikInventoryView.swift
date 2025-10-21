import SwiftUI

struct ChikInventoryView: View {
    @StateObject var chikInventoryModel =  ChikInventoryViewModel()
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
                        .FontLight(size: 20)
                        .offset(y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
               ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(chikInventoryModel.inventory, id: \.id) { chick in
                            ZStack(alignment: .topTrailing) {
                                let (statusText, statusColor) = stockStatus(for: chick.stock)
                                let progressWidth = progressBarWidth(for: chick.stock, maxWidth: 330)
                                let gradient = progressBarColor(for: chick.stock)
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 210/255, green: 213/255, blue: 157/255),
                                                                  Color(red: 204/255, green: 206/255, blue: 156/255),
                                                                  Color(red: 193/255, green: 198/255, blue: 137/255)], startPoint: .top, endPoint: .bottom))
                                    .frame(height: 230)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Image(.inventory)
                                                    .resizable()
                                                    .frame(width: 25, height: 40)
                                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                                    .background(Color(red: 230/255, green: 212/255, blue: 197/255))
                                                    .cornerRadius(8)
                                                
                                                VStack(alignment: .leading) {
                                                    Text(chick.name)
                                                        .FontRegular(size: 18)
                                                    
                                                    Text(chick.type)
                                                        .FontRegular(size: 14)
                                                }
                                                .padding(.leading, 5)
                                                
                                                Spacer()
                                                
                                                Text(statusText)
                                                    .FontRegular(size: 12, color: .white)
                                                    .padding(EdgeInsets(top: 3, leading: 25, bottom: 3, trailing: 25))
                                                    .background(statusColor)
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
                                            
                                            VStack {
                                                HStack {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                    Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 204/255, green: 188/255, blue: 174/255)], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            VStack(spacing: 7) {
                                                                HStack {
                                                                    Text("Stock Level")
                                                                        .FontRegular(size: 10)
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Text("\(chick.stock) g")
                                                                        .FontRegular(size: 10)
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                                ZStack(alignment: .leading) {
                                                                    Rectangle()
                                                                        .fill(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 215/255, green: 198/255, blue: 182/255))
                                                                        .frame(width: 330, height: 8)
                                                                        .cornerRadius(10)
                                                                    Rectangle()
                                                                        .fill(gradient)
                                                                        .frame(width: progressWidth, height: 8)
                                                                        .cornerRadius(10)
                                                                }
                                                            }
                                                        }
                                                        .cornerRadius(12)
                                                        .frame(height: 60)
                                                }
                                                
                                                HStack {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                    Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 204/255, green: 188/255, blue: 174/255)], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            VStack(spacing: 0) {
                                                                Text("Expire Date")
                                                                    .FontRegular(size: 10)
                                                                
                                                                VStack(spacing: -8) {
                                                                    Text(chick.expirationDate)
                                                                        .FontExtraBold(size: 22)
                                                                }
                                                            }
                                                        }
                                                        .cornerRadius(12)
                                                        .frame(height: 65)
                                                    
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                    Color(red: 28/255, green: 38/255, blue: 69/255)] :  [Color(red: 204/255, green: 188/255, blue: 174/255)], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            VStack(spacing: 0) {
                                                                Text("Supplier")
                                                                    .FontRegular(size: 10)
                                                                
                                                                VStack(spacing: -8) {
                                                                    Text(chick.supplier)
                                                                        .FontExtraBold(size: 22)
                                                                }
                                                            }
                                                        }
                                                        .cornerRadius(12)
                                                        .frame(height: 65)
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 20)
                                    }
                                    .cornerRadius(15)
                                    .padding(.horizontal)
                                    .padding(.leading, 5)
                                    .shadow(color: statusColor, radius: 0, x: -5)
                                
                                Group {
                                    if menusShown[chick.id] == true {
                                        VStack(alignment: .trailing, spacing: 5) {
                                            Button(action: {
                                                withAnimation {
                                                    UserDefaultsManager().deleteInventory(chick)
                                                    chikInventoryModel.loadInventory()
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
    
    func stockStatus(for stockString: String) -> (text: String, color: Color) {
        guard let stock = Double(stockString) else {
            return ("Out of stock", .red)
        }
        switch stock {
        case _ where stock == 0:
            return ("Out of stock", Color(red: 207/255, green: 58/255, blue: 58/255))
        case _ where stock < 20:
            return ("Low stock", Color(red: 233/255, green: 145/255, blue: 79/255))
        default:
            return ("In stock", Color(red: 155/255, green: 207/255, blue: 57/255))
        }
    }

    func progressBarWidth(for stockString: String, maxWidth: CGFloat) -> CGFloat {
        if let stock = Double(stockString) {
            let maxStock = 100.0
            return CGFloat(min(max(stock / maxStock, 0), 1)) * maxWidth
        }
        return 0
    }

    func progressBarColor(for stockString: String) -> LinearGradient {
        let (_, color) = stockStatus(for: stockString)
        switch color {
        case Color(red: 207/255, green: 58/255, blue: 58/255):
            return LinearGradient(colors: [.red, .red.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
        case Color(red: 233/255, green: 145/255, blue: 79/255):
            return LinearGradient(colors: [.orange, .orange.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
        default:
            return LinearGradient(colors: [Color(red: 200/255, green: 232/255, blue: 67/255),
                                           Color(red: 174/255, green: 212/255, blue: 72/255),
                                           Color(red: 138/255, green: 179/255, blue: 4/255)],
                                  startPoint: .leading, endPoint: .trailing)
        }
    }

}

#Preview {
    ChikInventoryView()
}

