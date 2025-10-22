import SwiftUI

struct ChikTabBarView: View {
    @StateObject var chikTabBarModel =  ChikTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Info
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Info {
                    ChikInfoView()
                } else if selectedTab == .Chickens {
                    MyChikensView()
                } else if selectedTab == .Incubator {
                    ChikIncubatorView()
                } else if selectedTab == .Tasks {
                    ChikTasksView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChikTabBarView()
}

struct MyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.06303*height))
        path.addCurve(to: CGPoint(x: 0.01389*width, y: 0), control1: CGPoint(x: 0, y: 0.02822*height), control2: CGPoint(x: 0.00622*width, y: 0))
        path.addLine(to: CGPoint(x: 0.83807*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.85336*width, y: 0.06205*height), control1: CGPoint(x: 0.8457*width, y: 0), control2: CGPoint(x: 0.85176*width, y: 0.0282*height))
        path.addCurve(to: CGPoint(x: 0.91991*width, y: 0.29622*height), control1: CGPoint(x: 0.85913*width, y: 0.1846*height), control2: CGPoint(x: 0.88144*width, y: 0.29622*height))
        path.addCurve(to: CGPoint(x: 0.9847*width, y: 0.06212*height), control1: CGPoint(x: 0.95836*width, y: 0.29622*height), control2: CGPoint(x: 0.97932*width, y: 0.18464*height))
        path.addCurve(to: CGPoint(x: 0.99989*width, y: 0), control1: CGPoint(x: 0.98619*width, y: 0.02817*height), control2: CGPoint(x: 0.99226*width, y: 0))
        path.addLine(to: CGPoint(x: 1.02315*width, y: 0))
        path.addCurve(to: CGPoint(x: 1.03704*width, y: 0.06303*height), control1: CGPoint(x: 1.03081*width, y: 0), control2: CGPoint(x: 1.03704*width, y: 0.02822*height))
        path.addLine(to: CGPoint(x: 1.03704*width, y: 0.93487*height))
        path.addCurve(to: CGPoint(x: 1.02315*width, y: 0.9979*height), control1: CGPoint(x: 1.03704*width, y: 0.96968*height), control2: CGPoint(x: 1.03081*width, y: 0.9979*height))
        path.addLine(to: CGPoint(x: 0.01389*width, y: 0.9979*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.93487*height), control1: CGPoint(x: 0.00622*width, y: 0.9979*height), control2: CGPoint(x: 0, y: 0.96968*height))
        path.addLine(to: CGPoint(x: 0, y: 0.06303*height))
        path.closeSubpath()
        return path
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    @State private var isOns: Bool = UserDefaults.standard.bool(forKey: "isOns")
    enum TabType: Int {
        case Info
        case Chickens
        case Incubator
        case Tasks
        case Add
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                MyIcon()
                    .fill(LinearGradient(colors: isOns ? [Color(red: 25/255, green: 26/255, blue: 27/255),
                                                                                                Color(red: 38/255, green: 40/255, blue: 45/255)] : [Color(red: 243/255, green: 230/255, blue: 217/255),
                                                  Color(red: 230/255, green: 210/255, blue: 192/255)], startPoint: .top, endPoint: .bottom))
                    .frame(height: 100)
                    .offset(x: -10, y: 35)
                    .shadow(color: .black.opacity(isOns ? 0 : 0.3), radius: 5, y: -5)
                    .ignoresSafeArea(edges: .bottom)
            }
            
            HStack(spacing: UIScreen.main.bounds.width > 900 ? 175 : UIScreen.main.bounds.width > 750 ? 135 : UIScreen.main.bounds.width > 720 ? 115 : UIScreen.main.bounds.width > 410 ? 50 : 42) {
                TabBarItem(imageName: "tab1", tab: .Info, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Chickens, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Incubator, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .Tasks, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab5", tab: .Add, selectedTab: $selectedTab)
            }
            .padding(.top, 10)
            .frame(height: 60)
        }
        .onAppear {
                  NotificationCenter.default.addObserver(forName: Notification.Name("UserResourcesUpdated"),
                                                         object: nil,
                                                         queue: .main) { _ in
                      self.isOns = UserDefaults.standard.bool(forKey: "isOns")
                  }
              }
              .onDisappear {
                  NotificationCenter.default.removeObserver(self,
                                                            name: Notification.Name("UserResourcesUpdated"),
                                                            object: nil)
              }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    @State var isShow = false
    @State var isEgg = false
    @State var isTask = false
    @State var isChik = false
    @State var isBatch = false
    @State var isVacc = false
    @State var isMed = false
    @State private var isOns: Bool = UserDefaults.standard.bool(forKey: "isOns")
    
    var body: some View {
        Button(action: {
            if tab == .Add {
                withAnimation {
                    isShow.toggle()
                }
            } else {
                selectedTab = tab
            }
        }) {
            VStack(spacing: 12) {
                VStack {
                    if tab == .Add {
                        ZStack {
                            Image(isOns ? (isShow ? "\(imageName)PickedDark" : "\(imageName)Dark") : (isShow ? "\(imageName)Picked2" : imageName))
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    } else {
                        Image(isOns ? (selectedTab == tab ? "\(imageName)PickedDark" : "\(imageName)Dark") : (selectedTab == tab ? "\(imageName)Picked" : imageName))
                            .resizable()
                            .frame(width: tab == .Incubator ? 18 : 24, height: 24)
                    }
                    
                    Text("\(tab)")
                        .FontRegular(
                            size: 12,
                            color: isOns ? (selectedTab == tab
                                    ? Color(red: 171/255, green: 181/255, blue: 210/255)
                                    : isShow ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 51/255, green: 54/255, blue: 65/255)) : (selectedTab == tab
                            ? Color(red: 126/255, green: 98/255, blue: 88/255)
                            : isShow ? Color(red: 126/255, green: 98/255, blue: 88/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                        )
                        .offset(y: tab == .Add ? 13 : 0)
                }
            }
            .overlay {
                if tab == .Add && isShow {
                    VStack(alignment: .trailing, spacing: 5) {
                        Button(action: {
                            isEgg = true
                        }) {
                            HStack {
                                Image(isOns ? "tab3Dark" : "tab3Picked")
                                    .resizable()
                                    .frame(width: 12, height: 16)
                                
                                Spacer()
                                
                                Text("Eggs")
                                    .FontLight(size: 12)
                            }
                        }
                        
                        Rectangle()
                            .fill(isOns ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                            .frame(height: 1)
                            .cornerRadius(2)
                        
                        Button(action: {
                            isTask = true
                        }) {
                            HStack {
                                Image(isOns ? "tab4Dark" : "tab4Picked")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                
                                Spacer()
                                
                                Text("Task")
                                    .FontLight(size: 12)
                            }
                        }
                        
                        Rectangle()
                            .fill(isOns ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                            .frame(height: 1)
                            .cornerRadius(2)
                        
                        Button(action: {
                            isChik = true
                        }) {
                            HStack {
                                Image(isOns ? "tab2Dark" : "tab2Picked")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                
                                Spacer()
                                
                                Text("Chiken")
                                    .FontLight(size: 12)
                            }
                        }
                        
                        Rectangle()
                            .fill(isOns ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                            .frame(height: 1)
                            .cornerRadius(2)
                        
                        Button(action: {
                            isBatch = true
                        }) {
                            HStack {
                                Image(isOns ? "tab1Dark" : "tab1Picked")
                                    .resizable()
                                    .frame(width: 14, height: 16)
                                
                                Spacer()
                                
                                Text("Batch")
                                    .FontLight(size: 12)
                            }
                        }
                        
                        Rectangle()
                            .fill(isOns ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                            .frame(height: 1)
                            .cornerRadius(2)
                        
                        Button(action: {
                            isVacc = true
                        }) {
                            HStack(spacing: 0) {
                                Image(isOns ? "ukol" : "vaccination")
                                    .resizable()
                                    .frame(width: 12, height: 16)
                                
                                Spacer()
                                
                                Text("Vaccination")
                                    .FontLight(size: 8)
                            }
                        }
                        
                        Rectangle()
                            .fill(isOns ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                            .frame(height: 1)
                            .cornerRadius(2)
                        
                        Button(action: {
                            isMed = true
                        }) {
                            HStack {
                                Image(isOns ? "medic" : "medice")
                                    .resizable()
                                    .frame(width: 14, height: 16)
                                
                                Spacer()
                                
                                Text("Medicine")
                                    .FontLight(size: 10)
                            }
                        }
                        
                        Rectangle()
                            .fill(isOns ? Color(red: 52/255, green: 63/255, blue: 97/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                            .frame(height: 1)
                            .cornerRadius(2)
                    }
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 10, trailing: 10))
                    .background(
                        Rectangle()
                            .fill(LinearGradient(
                                colors: isOns ? [Color(red: 139/255, green: 152/255, blue: 190/255),
                                                                                       Color(red: 111/255, green: 127/255, blue: 174/255)] : [Color(red: 247/255, green: 235/255, blue: 227/255),
                                         Color(red: 190/255, green: 177/255, blue: 167/255)],
                                startPoint: .top, endPoint: .bottom))
                            .cornerRadius(8)
                            .shadow(radius: 5, y: 3)
                    )
                    .frame(width: 80)
                    .offset(x: -20, y: -140)
                }
            }
        }
        .offset(y: tab == .Add ? -20 : 0)
        .pressableButtonStyle()
        .onAppear {
                  NotificationCenter.default.addObserver(forName: Notification.Name("UserResourcesUpdated"),
                                                         object: nil,
                                                         queue: .main) { _ in
                      self.isOns = UserDefaults.standard.bool(forKey: "isOns")
                  }
              }
              .onDisappear {
                  NotificationCenter.default.removeObserver(self,
                                                            name: Notification.Name("UserResourcesUpdated"),
                                                            object: nil)
              }
        .fullScreenCover(isPresented: $isEgg) {
            AddEggsView()
        }
        .fullScreenCover(isPresented: $isTask) {
            AddTaskView()
        }
        .fullScreenCover(isPresented: $isChik) {
            AddChikView()
        }
        .fullScreenCover(isPresented: $isBatch) {
            AddBatchView()
        }
        .fullScreenCover(isPresented: $isVacc) {
            AddVaccinationView()
        }
        .fullScreenCover(isPresented: $isMed) {
            AddInventoryView()
        }
    }
}
