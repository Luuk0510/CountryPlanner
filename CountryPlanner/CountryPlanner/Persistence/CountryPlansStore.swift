import Foundation

final class CountryPlansStore {
    private let fileName = "country_plans.json"
    private var canPersist = true
    
    func load() -> [CountryPlan] {
        do {
            let url = try fileURL()
            
            guard FileManager.default.fileExists(atPath: url.path) else {
                canPersist = true
                return []
            }
            
            let data = try Data(contentsOf: url)
            let plans = try JSONDecoder().decode([CountryPlan].self, from: data)
            canPersist = true
            return plans
        } catch {
            canPersist = false
            // Fail soft on corrupt/legacy files so the app still opens and users can recreate plans.
            print("CountryPlansStore load error: \(error)")
            return []
        }
    }

    func save(_ plans: [CountryPlan]) {
        guard canPersist else {
            print("CountryPlansStore save skipped because the last load failed.")
            return
        }
        
        do {
            let url = try fileURL()
            let data = try JSONEncoder().encode(plans)
            // Atomic write avoids leaving a partially written JSON file on interruption.
            try data.write(to: url, options: [.atomic])
        } catch {
            print("CountryPlansStore save error: \(error)")
        }
    }

    private func fileURL() throws -> URL {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw CocoaError(.fileNoSuchFile)
        }
        return dir.appendingPathComponent(fileName)
    }
}
