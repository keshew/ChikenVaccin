import SwiftUI

struct ChikTasksView: View {
    @StateObject var chikTaskModel = ChikTasksViewModel()
    let cellSpacing: CGFloat = 14
    
    @State private var dragAmount: CGFloat = 0
    @State private var bottomSheetOffset: CGFloat = 0
    @State var isChik = false
    @State var isInventory = false
    @State var isBatches = false
    @State var isTasks = false
    @State var isVacc = false
    private let minHeightRatio: CGFloat = 0.52
    private let maxHeightRatio: CGFloat = 0.65
    @State var markedDates: [Date: String] = [:]
    
    func doneDate() {
        markedDates.removeAll()
        
        for chick in UserDefaultsManager.shared.loadChicks() {
            if let date = chick.lastEgg.toDate()?.startOfDay {
                markedDates[date] = "chick"
                print("Added chick date: \(date)")
            } else {
                print("Failed to parse chick date: \(chick.lastEgg)")
            }
        }
        
        for batch in UserDefaultsManager.shared.loadBatches() {
            if let date = batch.expectedHatchData.toDate()?.startOfDay {
                markedDates[date] = "batch"
                print("Added batch date: \(date)")
            } else {
                print("Failed to parse batch date: \(batch.expectedHatchData)")
            }
        }
        
        for vaccine in UserDefaultsManager.shared.loadVaccines() {
            if let date = vaccine.date.toDate()?.startOfDay {
                markedDates[date] = "vaccine"
                print("Added vaccine date: \(date)")
            } else {
                print("Failed to parse vaccine date: \(vaccine.date)")
            }
        }
        
        for item in UserDefaultsManager.shared.loadInventory() {
            if let date = item.expirationDate.toDate()?.startOfDay {
                markedDates[date] = "inventory"
                print("Added inventory date: \(date)")
            } else {
                print("Failed to parse inventory date: \(item.expirationDate)")
            }
        }
        
        for task in UserDefaultsManager.shared.loadTasks() {
            if let date = task.date.toDate()?.startOfDay {
                markedDates[date] = "task"
                print("Added task date: \(date)")
            } else {
                print("Failed to parse task date: \(task.date)")
            }
        }
        
        print("Marked dates count: \(markedDates.count)")
    }
    
    
    var body: some View {
        ZStack {
            if UserDefaults.standard.bool(forKey: "isOns") {
                Color(red: 33/255, green: 34/255, blue: 36/255).ignoresSafeArea()
            } else {
                Color(red: 217/255, green: 205/255, blue: 195/255).ignoresSafeArea()
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            HStack {
                                
                                Spacer()
                                
                                Text("Tasks")
                                    .FontLight(size: 20)
                                    .offset(y: 2)
                            }
                            .padding(.horizontal)
                            
                            Rectangle()
                                .fill(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 52/255, green: 63/255, blue: 98/255) : Color(red: 238/255, green: 223/255, blue: 212/255))
                                .frame(height: 28)
                                .overlay(
                                    HStack(spacing: cellSpacing) {
                                        let calendar = Calendar.current
                                        let today = Date()
                                        let weekdaySymbol = calendar.shortWeekdaySymbols[calendar.component(.weekday, from: today)-1].uppercased()
                                        ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                                            Text(day)
                                                .FontBold(size: 12, color: day == weekdaySymbol ? (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 131/255, green: 44/255, blue: 214/255) : Color(red: 126/255, green: 98/255, blue: 88/255)) : (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 204/255, green: 188/255, blue: 174/255)))
                                                .frame(width: chikTaskModel.cellWidth(for: geometry.size.width, spacing: cellSpacing), height: 28)
                                                .offset(y: 3)
                                        }
                                    }
                                        .padding(.horizontal, geometry.size.width * 0.05)
                                )
                                .padding(.horizontal)
                            
                            ForEach(chikTaskModel.monthsToShow, id: \.self) { monthDate in
                                VStack(spacing: 10) {
                                    HStack {
                                        Text(chikTaskModel.monthYearString(from: monthDate))
                                            .FontRegular(size: 14)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    
                                    VStack(spacing: 15) {
                                        let weeks = chikTaskModel.generateWeeks(for: monthDate)
                                        ForEach(weeks.indices, id: \.self) { weekIndex in
                                            HStack(spacing: cellSpacing) {
                                                ForEach(0..<7, id: \.self) { dayIndex in
                                                    if let date = weeks[weekIndex][dayIndex] {
                                                        let (bgColor, textColor) = colorsForEventType(on: date)
                                                        Text("\(Calendar.current.component(.day, from: date))")
                                                            .FontLight(size: 16, color: textColor)
                                                            .offset(y: 3)
                                                            .frame(width: chikTaskModel.cellWidth(for: geometry.size.width, spacing: cellSpacing), height: 36)
                                                            .background(bgColor)
                                                            .cornerRadius(6)
                                                    } else {
                                                        Rectangle()
                                                            .fill(Color.clear)
                                                            .frame(width: chikTaskModel.cellWidth(for: geometry.size.width, spacing: cellSpacing), height: 36)
                                                    }
                                                }
                                            }
                                            .padding(.horizontal, geometry.size.width * 0.05)
                                        }
                                    }
                                }
                            }
                            
                            Color.clear.frame(height: 50)
                        }
                        .padding(.vertical)
                    }
                    
                    GeometryReader { geometry in
                        let maxHeight = geometry.size.height * maxHeightRatio
                        let minHeight = geometry.size.height * minHeightRatio
                        let collapsedOffset = maxHeight - minHeight
                        
                        VStack {
                            Capsule()
                                .frame(width: 120, height: 6)
                                .foregroundColor(UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 11/255, green: 17/255, blue: 37/255) : Color(red: 236/255, green: 223/255, blue: 213/255))
                                .padding(.top, 8)
                            
                            ScrollView(showsIndicators: false) {
                                if hasNoItems {
                                    VStack(spacing: 25) {
                                        Image(.task)
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        Text("Add any tasks and replenish supplies,\ntracking them here.")
                                            .FontRegular(size: 16)
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(.vertical, 20)
                                } else {
                                    VStack {
                                        ForEach(UserDefaultsManager.shared.loadChicks()) { chick in
                                            Button(action: {
                                                isChik = true
                                            }) {
                                                VStack(spacing: 0) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 139/255, green: 152/255, blue: 190/255),
                                                                                                                                    Color(red: 111/255, green: 127/255, blue: 174/255)] : [Color(red: 204/255, green: 188/255, blue: 174/255),
                                                                                      Color(red: 230/255, green: 210/255, blue: 192/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .topRight]))
                                                        .frame(height: 30)
                                                        .padding(.leading, 8)
                                                        .shadow(color: Color(red: 233/255, green: 145/255, blue: 79/255), radius: 0, x: -8)
                                                        .overlay {
                                                            HStack {
                                                                Text("My chikens")
                                                                    .FontSemiBold(size: 14)
                                                                Spacer()
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                    
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                    Color(red: 28/255, green: 38/255, blue: 69/255)] : [Color(red: 191/255, green: 175/255, blue: 160/255),
                                                                                      Color(red: 226/255, green: 207/255, blue: 190/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight]))
                                                        .frame(height: 50)
                                                        .overlay {
                                                            HStack {
                                                                VStack(alignment: .leading) {
                                                                    Text(chick.name)
                                                                        .FontSemiBold(size: 14)
                                                                    
                                                                    Text("Age in week \(chick.ageInWeek)")
                                                                        .FontRegular(size: 14)
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                                Spacer()
                                                            }
                                                        }
                                                    
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        
                                        ForEach(UserDefaultsManager.shared.loadBatches()) { batch in
                                            Button(action: {
                                                isBatches = true
                                            }) {
                                                VStack(spacing: 0) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 139/255, green: 152/255, blue: 190/255),
                                                                                                                                    Color(red: 111/255, green: 127/255, blue: 174/255)] : [Color(red: 204/255, green: 188/255, blue: 174/255),
                                                                                      Color(red: 230/255, green: 210/255, blue: 192/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .topRight]))
                                                        .frame(height: 30)
                                                        .padding(.leading, 8)
                                                        .shadow(color: Color(red: 78/255, green: 189/255, blue: 233/255), radius: 0, x: -8)
                                                        .overlay {
                                                            HStack {
                                                                Text("Incubation Batches")
                                                                    .FontSemiBold(size: 14)
                                                                Spacer()
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                    
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                    Color(red: 28/255, green: 38/255, blue: 69/255)] : [Color(red: 191/255, green: 175/255, blue: 160/255),
                                                                                      Color(red: 226/255, green: 207/255, blue: 190/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight]))
                                                        .frame(height: 50)
                                                        .overlay {
                                                            HStack {
                                                                VStack(alignment: .leading) {
                                                                    Text("Current day \(batch.currentDay)")
                                                                        .FontSemiBold(size: 14)
                                                                    
                                                                    Text("\(batch.totalEggs) eggs incubating")
                                                                        .FontRegular(size: 14)
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                                Spacer()
                                                            }
                                                        }
                                                    
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        
                                        ForEach(UserDefaultsManager.shared.loadVaccines()) { vaccine in
                                            Button(action: {
                                                isVacc = true
                                            }) {
                                                VStack(spacing: 0) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 139/255, green: 152/255, blue: 190/255),
                                                                                                                                    Color(red: 111/255, green: 127/255, blue: 174/255)] : [Color(red: 204/255, green: 188/255, blue: 174/255),
                                                                                      Color(red: 230/255, green: 210/255, blue: 192/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .topRight]))
                                                        .frame(height: 30)
                                                        .padding(.leading, 8)
                                                        .shadow(color: Color(red: 155/255, green: 207/255, blue: 57/255), radius: 0, x: -8)
                                                        .overlay {
                                                            HStack {
                                                                Text("Vaccination Schedule")
                                                                    .FontSemiBold(size: 14)
                                                                Spacer()
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                    
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                    Color(red: 28/255, green: 38/255, blue: 69/255)] : [Color(red: 191/255, green: 175/255, blue: 160/255),
                                                                                      Color(red: 226/255, green: 207/255, blue: 190/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight]))
                                                        .frame(height: 50)
                                                        .overlay {
                                                            HStack {
                                                                VStack(alignment: .leading) {
                                                                    Text("\(vaccine.name)")
                                                                        .FontSemiBold(size: 14)
                                                                    
                                                                    Text("\(vaccine.notes)")
                                                                        .FontRegular(size: 14)
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                                Spacer()
                                                            }
                                                        }
                                                    
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        
                                        ForEach(UserDefaultsManager.shared.loadInventory()) { item in
                                            Button(action: {
                                                isInventory = true
                                            }) {
                                                VStack(spacing: 0) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 139/255, green: 152/255, blue: 190/255),
                                                                                                                                    Color(red: 111/255, green: 127/255, blue: 174/255)] : [Color(red: 204/255, green: 188/255, blue: 174/255),
                                                                                      Color(red: 230/255, green: 210/255, blue: 192/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .topRight]))
                                                        .frame(height: 30)
                                                        .padding(.leading, 8)
                                                        .shadow(color: Color(red: 233/255, green: 197/255, blue: 78/255), radius: 0, x: -8)
                                                        .overlay {
                                                            HStack {
                                                                Text("Medicine Inventory")
                                                                    .FontSemiBold(size: 14)
                                                                Spacer()
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                    
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                    Color(red: 28/255, green: 38/255, blue: 69/255)] : [Color(red: 191/255, green: 175/255, blue: 160/255),
                                                                                      Color(red: 226/255, green: 207/255, blue: 190/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight]))
                                                        .frame(height: 50)
                                                        .overlay {
                                                            HStack {
                                                                VStack(alignment: .leading) {
                                                                    Text("\(item.name)")
                                                                        .FontSemiBold(size: 14)
                                                                    
                                                                    Text("\(item.notes)")
                                                                        .FontRegular(size: 14)
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                                Spacer()
                                                            }
                                                        }
                                                    
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        
                                        ForEach(UserDefaultsManager.shared.loadTasks()) { task in
                                            Button(action: {
                                                isTasks = true
                                            }) {
                                                VStack(spacing: 0) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 139/255, green: 152/255, blue: 190/255),
                                                                                                                                    Color(red: 111/255, green: 127/255, blue: 174/255)] : [Color(red: 204/255, green: 188/255, blue: 174/255),
                                                                                      Color(red: 230/255, green: 210/255, blue: 192/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .topRight]))
                                                        .frame(height: 30)
                                                        .padding(.leading, 8)
                                                        .shadow(color: Color(red: 155/255, green: 207/255, blue: 57/255), radius: 0, x: -8)
                                                        .overlay {
                                                            HStack {
                                                                Text("Tasks")
                                                                    .FontSemiBold(size: 14)
                                                                Spacer()
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                    
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 97/255),
                                                                                                                                    Color(red: 28/255, green: 38/255, blue: 69/255)] : [Color(red: 191/255, green: 175/255, blue: 160/255),
                                                                                      Color(red: 226/255, green: 207/255, blue: 190/255)], startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight]))
                                                        .frame(height: 50)
                                                        .overlay {
                                                            HStack {
                                                                VStack(alignment: .leading) {
                                                                    Text("\(task.name)")
                                                                        .FontSemiBold(size: 14)
                                                                    
                                                                    Text("\(task.note)")
                                                                        .FontRegular(size: 14)
                                                                }
                                                                .padding(.horizontal)
                                                                
                                                                Spacer()
                                                            }
                                                        }
                                                    
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        
                                        Color.clear.frame(height: 250)
                                    }
                                    
                                    .padding(.vertical, 20)
                                }
                            }
                        }
                        .frame(width: geometry.size.width , height: maxHeight)
                        .background(LinearGradient(colors: UserDefaults.standard.bool(forKey: "isOns") ? [Color(red: 52/255, green: 63/255, blue: 98/255),
                                                                                                          Color(red: 20/255, green: 23/255, blue: 37/255)] : [Color(red: 247/255, green: 235/255, blue: 227/255),
                                                            Color(red: 190/255, green: 177/255, blue: 167/255)], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .offset(y: max(dragAmount + bottomSheetOffset, 500))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragAmount = value.translation.height
                                }
                                .onEnded { value in
                                    withAnimation(.interactiveSpring()) {
                                        if -value.translation.height > (collapsedOffset / 2) {
                                            bottomSheetOffset = UIScreen.main.bounds.width > 900 ? 800 : UIScreen.main.bounds.width > 750 ? 800 : UIScreen.main.bounds.width > 720 ? 600 : UIScreen.main.bounds.width > 410 ? 500 : 480
                                        } else {
                                            bottomSheetOffset = UIScreen.main.bounds.width > 900 ? 1220 : UIScreen.main.bounds.width > 750 ? 1070 : UIScreen.main.bounds.width > 720 ? 100 : UIScreen.main.bounds.width > 410 ? 770 : 690
                                        }
                                        dragAmount = 0
                                    }
                                }
                        )
                        .onAppear {
                            bottomSheetOffset = UIScreen.main.bounds.width > 900 ? 1220 : UIScreen.main.bounds.width > 750 ? 1070 : UIScreen.main.bounds.width > 720 ? 1000 : UIScreen.main.bounds.width > 410 ? 770 : 690
                        }
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isTasks, content: {
            ChickTasksView()
        })
        .fullScreenCover(isPresented: $isInventory, content: {
            ChikInventoryView()
        })
        .fullScreenCover(isPresented: $isVacc, content: {
            ChikVaccineView()
        })
        .onAppear {
            doneDate()
        }
    }
    
    let hasNoItems =
    UserDefaultsManager.shared.loadChicks().isEmpty &&
    UserDefaultsManager.shared.loadBatches().isEmpty &&
    UserDefaultsManager.shared.loadVaccines().isEmpty &&
    UserDefaultsManager.shared.loadInventory().isEmpty &&
    UserDefaultsManager.shared.loadTasks().isEmpty
    
    func colorsForEventType(on date: Date) -> (bgColor: Color, textColor: Color) {
        if let event = markedDates.first(where: { Calendar.current.isDate($0.key, inSameDayAs: date) }) {
            let eventType = event.value
            switch eventType {
            case "chick":
                return (Color(red: 233/255, green: 145/255, blue: 79/255).opacity(0.5), Color.white)
            case "batch":
                return (Color(red: 78/255, green: 189/255, blue: 233/255).opacity(0.5), Color.white)
            case "vaccine":
                return (Color(red: 155/255, green: 207/255, blue: 57/255).opacity(0.5), Color.white)
            case "inventory":
                return (Color(red: 233/255, green: 197/255, blue: 78/255).opacity(0.5), Color.white)
            case "task":
                return (Color(red: 155/255, green: 207/255, blue: 57/255).opacity(0.5), Color.white)
            default:
                return (.clear, .black)
            }
        } else {
            let isToday = Calendar.current.isDate(date, inSameDayAs: Date())
            return (
                isToday ? (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 204/255, green: 188/255, blue: 174/255)) : (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 44/255, green: 49/255, blue: 62/255) : Color(red: 238/255, green: 223/255, blue: 212/255)),
                isToday ? (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255)) : (UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255))
            )
        }
    }
}

#Preview {
    ChikTasksView()
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

extension String {
    func toDate(format: String = "MM.dd.yyyy") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
