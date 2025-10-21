import SwiftUI

class ChikIncubatorViewModel: ObservableObject {
    let contact = ChikIncubatorModel()
    @Published var batch: [BatchModel] = []

    init() {
        loadBatches()
        NotificationCenter.default.addObserver(forName: Notification.Name("UserResourcesUpdated"), object: nil, queue: .main) { _ in
            self.loadBatches()
        }
    }

    func loadBatches() {
        batch = UserDefaultsManager.shared.loadBatches()
    }
}
