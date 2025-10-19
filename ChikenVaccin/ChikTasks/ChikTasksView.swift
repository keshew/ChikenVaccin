import SwiftUI

struct ChikTasksView: View {
    @StateObject var chikTaskModel = ChikTasksViewModel()
    let cellSpacing: CGFloat = 14
    
    @State private var dragAmount: CGFloat = 0
    @State private var bottomSheetOffset: CGFloat = 0
    
    private let minHeightRatio: CGFloat = 0.52
    private let maxHeightRatio: CGFloat = 0.65
    
    var body: some View {
        ZStack {
            Color(red: 221/255, green: 202/255, blue: 185/255).ignoresSafeArea()
            
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            HStack {
                                Button(action: {
                                    
                                }) {
                                    Image(.settingsIcon)
                                        .resizable()
                                        .frame(width: 20, height: 16)
                                }
                                .pressableButtonStyle()
                                
                                Spacer()
                                
                                Text("Tasks")
                                    .FontLight(size: 20)
                                    .offset(y: 2)
                            }
                            .padding(.horizontal)
                            
                            Rectangle()
                                .fill(Color(red: 238/255, green: 223/255, blue: 212/255))
                                .frame(height: 28)
                                .overlay(
                                    HStack(spacing: cellSpacing) {
                                        let calendar = Calendar.current
                                        let today = Date()
                                        let weekdaySymbol = calendar.shortWeekdaySymbols[calendar.component(.weekday, from: today)-1].uppercased()
                                        ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                                            Text(day)
                                                .FontBold(size: 12, color: day == weekdaySymbol ? Color(red: 126/255, green: 98/255, blue: 88/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
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
                                                        let isToday = Calendar.current.isDate(date, inSameDayAs: Date())
                                                        Text("\(Calendar.current.component(.day, from: date))")
                                                            .FontLight(size: 16, color: isToday ? Color(red: 126/255, green: 98/255, blue: 88/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                                                            .offset(y: 3)
                                                            .frame(width: chikTaskModel.cellWidth(for: geometry.size.width, spacing: cellSpacing), height: 36)
                                                            .background(isToday ? Color(red: 204/255, green: 188/255, blue: 174/255) : Color(red: 238/255, green: 223/255, blue: 212/255))
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
                                .foregroundColor(Color(red: 236/255, green: 223/255, blue: 213/255))
                                .padding(.top, 8)
                            
                            ScrollView(showsIndicators: false) {
                                if 1 == 1 {
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
                                        
                                    }
                                    .padding(.vertical, 20)
                                }
                            }
                        }
                        .frame(width: geometry.size.width , height: maxHeight)
                        .background(LinearGradient(colors: [Color(red: 247/255, green: 235/255, blue: 227/255),
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
                                            bottomSheetOffset = 500
                                        } else {
                                            bottomSheetOffset = 770
                                        }
                                        dragAmount = 0
                                    }
                                }
                        )
                        .onAppear {
                            bottomSheetOffset = 770
                        }
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
            }
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
