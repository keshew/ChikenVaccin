import SwiftUI

class ChikInventoryViewModel: ObservableObject {
    @Published var inventory: [InvenrtoryModel] = []

    init() {
        loadInventory()
    }

    func loadInventory() {
        inventory = UserDefaultsManager.shared.loadInventory()
    }

    func deleteInventoryItem(_ item: InvenrtoryModel) {
        UserDefaultsManager.shared.deleteInventory(item)
        loadInventory()
    }
}
