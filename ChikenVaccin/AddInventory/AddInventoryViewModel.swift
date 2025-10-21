import SwiftUI
import Combine

class AddInventoryViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func saveInventoryItem(name: String, type: String, notes: String, supplier: String, stock: String, expirationDate: String) {
        let digitsSet = CharacterSet.decimalDigits
        if stock.rangeOfCharacter(from: digitsSet.inverted) != nil {
            alertMessage = "Field Stock must contains only number"
            showAlert = true
            return
        }
        
        let item = InvenrtoryModel(name: name, type: type, notes: notes, supplier: supplier, stock: stock, expirationDate: expirationDate)
        UserDefaultsManager.shared.saveInventory(item)
        
        alertMessage = "Inventory item saved successfully"
        showAlert = true
    }
}

