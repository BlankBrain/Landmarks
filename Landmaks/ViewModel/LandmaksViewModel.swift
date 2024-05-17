//
//  LandmaksViewModel.swift
//  Landmaks
//
//  Created by Md. Mehedi Hasan on 17/5/24.
//

import Foundation
import Combine

final class LandmaksViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var landMarks: [ LandmaksModel] = []
    init() {
        self.setupBindings()
    }
    deinit {
    }
    func cancelAllCancellables(){
        self.cancellables.forEach({$0.cancel()})
    }
    func setupBindings() {
        self.landMarks = getLandmarks()
    }
    
    func getLandmarks() -> [LandmaksModel]  {
      
    guard let url = Bundle.main.url(forResource: "landmarkData", withExtension: "json") else {
            fatalError("Unable to locate landmarks.json in bundle.")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([LandmaksModel].self, from: data)
        } catch {
            fatalError("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
    
}
