import SwiftUI

class AddVaccinationViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func saveVaccine(name: String, chikenName: String, notes: String, date: String) {
        if name.isEmpty || chikenName.isEmpty || date.isEmpty {
            alertMessage = "Please fill all required fields"
            showAlert = true
            return
        }
        
        let chicks = UserDefaultsManager.shared.loadChicks()
        guard let selectedChick = chicks.first(where: { $0.name == chikenName }) else {
            alertMessage = "Not found"
            showAlert = true
            return
        }
        
        let vaccine = VaccineModel(name: name, chiken: selectedChick, notes: notes, date: date)
        UserDefaultsManager.shared.saveVaccine(vaccine)
        
        alertMessage = "Vaccine saved successfully"
        showAlert = true
    }
}
