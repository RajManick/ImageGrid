//
//  ImageGridRepository.swift
//  ImageGrid
//
//  Created by Manick on 15/04/24.
//

import Foundation

protocol ImageGridRepositoryProtocol {
    func fetchGridListFromAPI(limit : Int) async throws -> [ImageGridModel]
}

class ImageGridRepository : ImageGridRepositoryProtocol{
    
    func fetchGridListFromAPI(limit : Int) async throws -> [ImageGridModel] {
        let url = URL(string: "\(ImageGridConstants.Api.girdListURL)?limit=\(limit)")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode([ImageGridModel].self, from: data)

        return decoded
    }
    
}
