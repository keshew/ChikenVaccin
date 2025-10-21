import Foundation

struct MyChickModel: Identifiable, Codable {
    var id = UUID()
    var image: String
    var name: String
    var ageInWeek: String
    var totalEggs: Int
    var eggsThisWeek: Int
    var lastEgg: String
    var statusChik: ChickStatus
}

enum ChickStatus: String, Codable {
    case Healthy = "Healthy"
    case NeedAttention = "Needs attention"
}

struct BatchModel: Identifiable, Codable {
    var id = UUID()
    var totalEggs: String
    var currentDay: Int
    var temperature: String
    var humidity: String
    var expectedHatchData: String
    var batchStatus: BatchStatus
}

enum BatchStatus: String, Codable {
    case Active = "Active"
    case Hatching = "Hatching"
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let totalEggs = "totalEggs"
        static let totalChicks = "totalChicks"
        static let incubationEggs = "incubationEggs"
        static let chicksArray = "chicksArray"
        static let batchesArray = "batchesArray"
        static let vaccinesArray = "vaccinesArray"
        static let inventoryArray = "inventoryArray"
        static let lastStockUpdate = "lastStockUpdate"
        static let tasksArray = "tasksArray"
    }
    
    var totalEggs: Int {
        get { defaults.integer(forKey: Keys.totalEggs) }
        set { defaults.set(newValue, forKey: Keys.totalEggs) }
    }
    
    var totalChicks: Int {
        get { defaults.integer(forKey: Keys.totalChicks) }
        set { defaults.set(newValue, forKey: Keys.totalChicks) }
    }
    
    var incubationEggs: Int {
        get { defaults.integer(forKey: Keys.incubationEggs) }
        set { defaults.set(newValue, forKey: Keys.incubationEggs) }
    }
    
    // MARK: - Работа с массивом куриц
    
    func saveChick(_ chick: MyChickModel) {
        var chicks = loadChicks()
        chicks.append(chick)
        saveChicksArray(chicks)
    }
    
    func loadChicks() -> [MyChickModel] {
        guard let data = defaults.data(forKey: Keys.chicksArray) else { return [] }
        return (try? JSONDecoder().decode([MyChickModel].self, from: data)) ?? []
    }
    
    private func saveChicksArray(_ chicks: [MyChickModel]) {
        if let data = try? JSONEncoder().encode(chicks) {
            defaults.set(data, forKey: Keys.chicksArray)
        }
    }
    
    func updateChick(_ chick: MyChickModel) {
        var chicks = loadChicks()
        if let index = chicks.firstIndex(where: { $0.id == chick.id }) {
            chicks[index] = chick
            saveChicksArray(chicks)
        }
    }
    
    func deleteChick(_ chick: MyChickModel) {
        var chicks = loadChicks()
        chicks.removeAll { $0.id == chick.id }
        saveChicksArray(chicks)
    }
    
    func checkAndUpdateChicksStatus() {
        var chicks = loadChicks()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        for i in 0..<chicks.count {
            if let lastEggDate = dateFormatter.date(from: chicks[i].lastEgg) {
                let daysSinceLastEgg = Calendar.current.dateComponents([.day], from: lastEggDate, to: Date()).day ?? 0
                if daysSinceLastEgg > 2 && chicks[i].statusChik == .Healthy {
                    chicks[i].statusChik = .NeedAttention
                }
            }
        }
        saveChicksArray(chicks)
    }
    
    // MARK: - Работа с инкубационными яйцами (BatchModel)
    
    func saveBatch(_ batch: BatchModel) {
        var batches = loadBatches()
        batches.append(batch)
        saveBatchesArray(batches)
    }
    
    func loadBatches() -> [BatchModel] {
        guard let data = defaults.data(forKey: Keys.batchesArray) else { return [] }
        return (try? JSONDecoder().decode([BatchModel].self, from: data)) ?? []
    }
    
    private func saveBatchesArray(_ batches: [BatchModel]) {
        if let data = try? JSONEncoder().encode(batches) {
            defaults.set(data, forKey: Keys.batchesArray)
        }
    }
    
    func updateBatch(_ batch: BatchModel) {
        var batches = loadBatches()
        if let index = batches.firstIndex(where: { $0.id == batch.id }) {
            batches[index] = batch
            saveBatchesArray(batches)
        }
    }
    
    func deleteBatch(_ batch: BatchModel) {
        var batches = loadBatches()
        batches.removeAll { $0.id == batch.id }
        saveBatchesArray(batches)
    }
    
    func updateCurrentDayForBatches() {
        var batches = loadBatches()
        for i in 0..<batches.count {
            batches[i].currentDay = batches[i].currentDay + 1
        }
        saveBatchesArray(batches)
    }
    
    //MARK: - VACNIE
    
    func saveVaccine(_ vaccine: VaccineModel) {
        var vaccines = loadVaccines()
        vaccines.append(vaccine)
        saveVaccinesArray(vaccines)
    }
    
    func loadVaccines() -> [VaccineModel] {
        guard let data = defaults.data(forKey: Keys.vaccinesArray) else { return [] }
        return (try? JSONDecoder().decode([VaccineModel].self, from: data)) ?? []
    }
    
    private func saveVaccinesArray(_ vaccines: [VaccineModel]) {
        if let data = try? JSONEncoder().encode(vaccines) {
            defaults.set(data, forKey: Keys.vaccinesArray)
        }
    }
    
    func deleteVaccine(_ vaccine: VaccineModel) {
        var vaccines = loadVaccines()
        vaccines.removeAll { $0.id == vaccine.id }
        saveVaccinesArray(vaccines)
    }
    
    func saveInventory(_ item: InvenrtoryModel) {
        var inventory = loadInventory()
        inventory.append(item)
        saveInventoryArray(inventory)
    }
    
    func loadInventory() -> [InvenrtoryModel] {
        guard let data = defaults.data(forKey: Keys.inventoryArray) else { return [] }
        return (try? JSONDecoder().decode([InvenrtoryModel].self, from: data)) ?? []
    }
    
    private func saveInventoryArray(_ inventory: [InvenrtoryModel]) {
        if let data = try? JSONEncoder().encode(inventory) {
            defaults.set(data, forKey: Keys.inventoryArray)
        }
    }
    
    func updateInventory(_ item: InvenrtoryModel) {
        var inventory = loadInventory()
        if let index = inventory.firstIndex(where: { $0.id == item.id }) {
            inventory[index] = item
            saveInventoryArray(inventory)
        }
    }
    
    func deleteInventory(_ item: InvenrtoryModel) {
        var inventory = loadInventory()
        inventory.removeAll { $0.id == item.id }
        saveInventoryArray(inventory)
    }
    
    func shouldDecreaseStock() -> Bool {
        if let lastDate = defaults.object(forKey: Keys.lastStockUpdate) as? Date {
            let elapsed = Date().timeIntervalSince(lastDate)
            return elapsed >= 24 * 3600
        }
        return true // если дата не установлена, считаем, что можно обновлять
    }
    
    func updateStockDate() {
        defaults.set(Date(), forKey: Keys.lastStockUpdate)
    }
    
    func decreaseStockIfNeeded() {
        guard shouldDecreaseStock() else { return }
        var updatedInventory = loadInventory()
        for i in 0..<updatedInventory.count {
            if let currentStock = Double(updatedInventory[i].stock) {
                let decreased = max(0, currentStock - currentStock * 0.1)
                updatedInventory[i].stock = String(format: "%.1f", decreased)
            }
        }
        saveInventoryArray(updatedInventory)
        updateStockDate()
    }
    
    func saveTask(_ task: TaskModel) {
        var tasks = loadTasks()
        tasks.append(task)
        saveTasksArray(tasks)
    }
    
    func loadTasks() -> [TaskModel] {
        guard let data = defaults.data(forKey: Keys.tasksArray) else { return [] }
        return (try? JSONDecoder().decode([TaskModel].self, from: data)) ?? []
    }
    
    private func saveTasksArray(_ tasks: [TaskModel]) {
        if let data = try? JSONEncoder().encode(tasks) {
            defaults.set(data, forKey: Keys.tasksArray)
        }
    }
    
    func updateTask(_ task: TaskModel) {
        var tasks = loadTasks()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasksArray(tasks)
        }
    }
    
    func deleteTask(_ task: TaskModel) {
        var tasks = loadTasks()
        tasks.removeAll { $0.id == task.id }
        saveTasksArray(tasks)
    }
}

