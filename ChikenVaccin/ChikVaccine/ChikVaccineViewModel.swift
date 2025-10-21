import SwiftUI

class ChikVaccineViewModel: ObservableObject {
    @Published var vaccines: [VaccineModel] = []

    init() {
        loadVaccines()
    }

    func loadVaccines() {
        vaccines = UserDefaultsManager.shared.loadVaccines()
    }

    func deleteVaccine(_ vaccine: VaccineModel) {
        UserDefaultsManager.shared.deleteVaccine(vaccine)
        loadVaccines()
    }
}
