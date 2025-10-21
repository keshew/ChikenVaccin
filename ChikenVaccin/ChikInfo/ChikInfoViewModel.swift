import SwiftUI

class ChikInfoViewModel: ObservableObject {
    let contact = ChikInfoModel()
    @Published var totalEggs: Int = 0
    @Published var totalChicks: Int = 0
    @Published var incubatingCount: Int = 0

    init() {
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
