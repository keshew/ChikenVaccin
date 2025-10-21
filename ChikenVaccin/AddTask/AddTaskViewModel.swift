import SwiftUI

class AddTaskViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""

    func saveTask(name: String, note: String, date: String) {
        let task = TaskModel(id: UUID(), name: name, chickenName: "", note: note, date: date)
        UserDefaultsManager.shared.saveTask(task)
        alertMessage = "Task saved successfully"
        showAlert = true
    }
}
