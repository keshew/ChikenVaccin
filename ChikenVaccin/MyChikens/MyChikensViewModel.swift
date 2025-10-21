import SwiftUI

class MyChikensViewModel: ObservableObject {
    @Published var chicks: [MyChickModel] = []

    init() {
        loadChicks()
        NotificationCenter.default.addObserver(forName: Notification.Name("UserResourcesUpdated"), object: nil, queue: .main) { _ in
            self.loadChicks()
        }
    }

    func loadChicks() {
        chicks = UserDefaultsManager.shared.loadChicks()
    }
}

extension MyChickModel {
    var isHealthy: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        guard let lastDate = dateFormatter.date(from: lastEgg) else { return true }
        let days = Calendar.current.dateComponents([.day], from: lastDate, to: Date()).day ?? 0
        return days <= 2
    }
}
