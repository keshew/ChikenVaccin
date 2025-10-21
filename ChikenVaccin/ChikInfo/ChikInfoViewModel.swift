import SwiftUI

class ChikInfoViewModel: ObservableObject {
    let contact = ChikInfoModel()
    @Published var totalEggs: Int = 0
    @Published var totalChicks: Int = 0
    @Published var incubatingCount: Int = 0
    @Published var isOn: Bool {
        didSet {
            UserDefaults.standard.set(isOn, forKey: "isOns")
        }
    }
    @Published var isNotifOn: Bool {
        didSet {
            UserDefaults.standard.set(isNotifOn, forKey: "isNotifOn")
        }
    }
    @Published var isVib: Bool {
        didSet {
            UserDefaults.standard.set(isVib, forKey: "isVib")
        }
    }
    @Published var isSounds: Bool {
        didSet {
            UserDefaults.standard.set(isSounds, forKey: "isSoundOn")
        }
    }
    
    init() {
        self.isOn = UserDefaults.standard.bool(forKey: "isOns")
        self.isNotifOn = UserDefaults.standard.bool(forKey: "isNotifOn")
        self.isVib = UserDefaults.standard.bool(forKey: "isVib")
        self.isSounds = UserDefaults.standard.bool(forKey: "isSounds")
        loadData()
    }

    func loadData() {
        let chicks = UserDefaultsManager.shared.loadChicks()
        totalEggs = chicks.reduce(0) { $0 + $1.totalEggs }
        totalChicks = chicks.count

        let batches = UserDefaultsManager.shared.loadBatches()
        incubatingCount = batches.filter { $0.batchStatus == .Hatching }.count
    }
}
