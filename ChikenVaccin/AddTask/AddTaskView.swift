import SwiftUI

struct AddTaskView: View {
    @StateObject var addTaskModel =  AddTaskViewModel()
    @State var name: String = ""
    @State var age: String = ""
    @State var totalEggs: String = ""
    @State var lastEgg: String = ""
    @State private var showDateDropdown = false
    //    @State var status: String = ""
    @State private var showStatusDropdown = false
    //    @State var statuses = ["To Do", "Done"]
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
                        NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundStyle(Color(red: 126/255, green: 98/255, blue: 88/255))
                            .frame(width: 20, height: 16)
                    }
                    .pressableButtonStyle()
                    
                    Spacer()
                    
                    Text("New Task")
                        .FontRegular(size: 20)
                }
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Task Title")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $name, placeholder: "")
                            }
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Notes")
                                    .FontRegular(size: 16)
                                
                                CustomTextFiled(text: $age, placeholder: "")
                            }
                            
                            //                            VStack(alignment: .leading, spacing: 0) {
                            //                                Text("Status")
                            //                                    .FontRegular(size: 16)
                            //
                            //                                ZStack {
                            //                                    VStack(spacing: 0) {
                            //                                        Button(action: {
                            //                                            withAnimation {
                            //                                                showStatusDropdown.toggle()
                            //                                            }
                            //                                        }) {
                            //                                            ZStack {
                            //                                                Rectangle()
                            //                                                    .fill(showStatusDropdown ? Color(red: 230/255, green: 218/255, blue: 208/255) : Color(red: 204/255, green: 188/255, blue: 174/255))
                            //                                                    .frame(height: 36)
                            //                                                    .cornerRadius(8)
                            //
                            //                                                HStack {
                            //                                                    Text(status.isEmpty ? "" : status)
                            //                                                        .FontRegular(size: 16)
                            //                                                        .offset(y: 2)
                            //                                                        .foregroundColor(status.isEmpty ? Color.gray : Color.black)
                            //
                            //                                                    Spacer()
                            //
                            //                                                    Image("pin")
                            //                                                        .resizable()
                            //                                                        .aspectRatio(contentMode: .fit)
                            //                                                        .frame(width: 18, height: 15)
                            //                                                }
                            //                                                .padding(.horizontal)
                            //                                            }
                            //                                        }
                            //
                            //                                        if showStatusDropdown {
                            //                                            HStack {
                            //                                                VStack(spacing: 0) {
                            //                                                    ForEach(statuses, id: \.self) { date in
                            //                                                        Text(date)
                            //                                                            .FontRegular(size: 16)
                            //                                                            .onTapGesture {
                            //                                                                status = date
                            //                                                                showStatusDropdown = false
                            //                                                            }
                            //                                                    }
                            //                                                }
                            //                                                .padding(.top, 4)
                            //                                                Spacer()
                            //                                            }
                            //                                            .frame(maxWidth: .infinity)
                            //                                            .padding(.horizontal)
                            //                                            .background(
                            //                                                Color(red: 204/255, green: 188/255, blue: 174/255)
                            //                                                    .clipShape(
                            //                                                        RoundedCorners(radius: 8, corners: [.bottomLeft, .bottomRight])
                            //                                                    )
                            //                                            )
                            //                                            .transition(.opacity.combined(with: .opacity))
                            //                                            .offset(y: -5)
                            //                                        }
                            //                                    }
                            //                                }
                            //                            }
                            
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
                            Image(.addTask)
                                .resizable()
                                .frame(width: 160, height: 220)
                                .aspectRatio(contentMode: .fit)
                                .shadow(radius: 2)
                            
                            Button(action: {
                                addTaskModel.saveTask(name: name, note: age, date: lastEgg)
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
                            .alert(isPresented: $addTaskModel.showAlert) {
                                Alert(title: Text(addTaskModel.alertMessage))
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
    AddTaskView()
}

