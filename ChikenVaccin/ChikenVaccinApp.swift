import SwiftUI

@main
struct ChikenVaccinApp: App {
    var body: some Scene {
        WindowGroup {
            ChikTabBarView()
                .onAppear {
                    UserDefaultsManager.shared.checkAndUpdateChicksStatus()
                    UserDefaultsManager.shared.decreaseStockIfNeeded()
                }
        }
    }
}
