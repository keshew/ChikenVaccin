import SwiftUI

class ChickTasksViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []

    init() {
        loadTasks()
    }

    func loadTasks() {
        tasks = UserDefaultsManager.shared.loadTasks()
    }

    func deleteTask(_ task: TaskModel) {
        UserDefaultsManager.shared.deleteTask(task)
        loadTasks()
    }
}

