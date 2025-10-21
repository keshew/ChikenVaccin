import SwiftUI

class AddChikViewModel: ObservableObject {
    let contact = AddChikModel()
    
    func saveChick(name: String, age: String, totalEggs: String, lastEgg: String) {
        let totalEggsInt = Int(totalEggs) ?? 0
        let chick = MyChickModel(
            image: ["chikType1", "chikType2", "chikType3"].randomElement()!,
            name: name,
            ageInWeek: age,
            totalEggs: totalEggsInt,
            eggsThisWeek: 0,
            lastEgg: lastEgg,
            statusChik: .Healthy
        )
        
        UserDefaultsManager.shared.saveChick(chick)
    }
}
