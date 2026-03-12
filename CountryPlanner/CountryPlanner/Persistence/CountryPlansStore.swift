import Foundation

final class CountryPlansStore {
    private let fileName = "country_plans.json"
    
    func load() -> [CountryPlan] {
        let url = fileURL()
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CountryPlan].self, from: data)
        } catch {
            // Fail soft on corrupt/legacy files so the app still opens and users can recreate plans.
            print("CountryPlansStore load error: \(error)")
            return []
        }
    }

    func save(_ plans: [CountryPlan]) {
        let url = fileURL()
        
        do {
            let data = try JSONEncoder().encode(plans)
            // Atomic write avoids leaving a partially written JSON file on interruption.
            try data.write(to: url, options: [.atomic])
        } catch {
            print("CountryPlansStore save error: \(error)")
        }
    }

    private func fileURL() -> URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(fileName)
    }
}
