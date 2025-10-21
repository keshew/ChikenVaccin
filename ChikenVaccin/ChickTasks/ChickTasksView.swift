import SwiftUI

struct TaskModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var chickenName: String
    var note: String
    var date: String
    
}

struct ChickTasksView: View {
    @StateObject var chickTasksModel =  ChickTasksViewModel()
    @State private var showMenu = false
    @State private var menusShown = [UUID: Bool]()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color(red: 217/255, green: 205/255, blue: 195/255).ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundStyle(Color(red: 126/255, green: 98/255, blue: 88/255))
                            .frame(width: 20, height: 16)
                    }
                    .pressableButtonStyle()
                    
                    Spacer()
                    
                    Text("Tasks")
                        .FontLight(size: 20)
                        .offset(y: 2)
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(chickTasksModel.tasks, id: \.id) { chick in
                            ZStack(alignment: .topTrailing) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 243/255, green: 230/255, blue: 217/255),
                                                                  Color(red: 230/255, green: 210/255, blue: 192/255)], startPoint: .top, endPoint: .bottom))
                                    .frame(height: chick.date != "" ? 200 : 160)
                                    .overlay {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(chick.name)
                                                        .FontRegular(size: 18)
                                                        .lineLimit(1)
                                                    
//                                                    Text("Stephanie")
//                                                        .FontRegular(size: 14)
                                                }
                                                .padding(.leading, 5)
                                                
                                                Spacer()
                                                
                                                Text("To Do")
                                                    .FontRegular(size: 12, color: .white)
                                                    .padding(EdgeInsets(top: 3, leading: 25, bottom: 3, trailing: 25))
                                                    .background(Color(red: 228/255, green: 196/255, blue: 66/255))
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
                                        
                                                Rectangle()
                                                    .fill(Color(red: 204/255, green: 188/255, blue: 174/255))
                                                    .overlay {
                                                        HStack {
                                                            VStack(alignment: .leading, spacing: 0) {
                                                                Text("Notes")
                                                                    .FontRegular(size: 10)
                                                                
                                                                VStack(spacing: -8) {
                                                                    Text(chick.note)
                                                                        .FontLight(size: 14)
                                                                }
                                                                Spacer()
                                                            }
                                                            .padding(.vertical)
                                                            Spacer()
                                                        }
                                                        .padding(.horizontal)
                                                    }
                                                    .cornerRadius(12)
                                                    .frame(height: 80)
                                            
                                            if chick.date != "" {
                                                VStack(alignment: .leading) {
                                                    Text("Due Date")
                                                        .FontLight(size: 10)
                                                    
                                                    Text(chick.date)
                                                        .FontExtraBold(size: 20)
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 20)
                                    }
                                    .cornerRadius(15)
                                    .padding(.horizontal)
                                
                                Group {
                                    if menusShown[chick.id] == true {
                                        VStack(alignment: .trailing, spacing: 5) {
                                            Button(action: {
                                                withAnimation {
                                                    UserDefaultsManager().deleteTask(chick)
                                                    chickTasksModel.loadTasks()
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
}

#Preview {
    ChickTasksView()
}

