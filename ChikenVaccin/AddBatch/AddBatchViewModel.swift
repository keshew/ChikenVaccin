import SwiftUI

class AddBatchViewModel: ObservableObject {
    
    func humidityPercentage(currentDay: Int) -> String {
        guard currentDay <= 21 else { return "0%" }
        let percentage = (Double(currentDay) / 21.0) * 100.0
        return String(format: "%.0f%%", percentage)
    }

    
    func saveBatch(name: String, startDate: String, totalEggs: String, temp: String) {
        let humidity = humidityPercentage(currentDay: 1)
        let batch = BatchModel(
            id: UUID(),
            totalEggs: totalEggs,
            currentDay: 1,
            temperature: temp,
            humidity: humidity,
            expectedHatchData: startDate,
            batchStatus: .Active
        )
        UserDefaultsManager.shared.saveBatch(batch)
    }
}
