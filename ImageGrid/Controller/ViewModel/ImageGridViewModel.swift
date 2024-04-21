//
//  ImageGridViewModel.swift
//  ImageGrid
//
//  Created by Manick on 15/04/24.
//

import Foundation

protocol ImageGridViewModelInput{
    func callGridListApi()
}

protocol ImageGridViewModelOutput{
    func getTotalNumberOfRows() -> Int?
    func getCoverageImageURL(index : Int) -> String
}

class ImageGridViewModel : ImageGridViewModelInput, ImageGridViewModelOutput{
    
    var limit = ImageGridConstants.imageGettingCount
    var gridListData : [ImageGridModel] = []
    private(set) var reloadCollectionView: ImageGridObservable<Bool> = ImageGridObservable(false)
    private(set) var handleError: ImageGridObservable<String> = ImageGridObservable("")
    private let imageGridrepository : ImageGridRepositoryProtocol
    
    init(repository : ImageGridRepositoryProtocol) {
        self.imageGridrepository = repository
    }
    
    func getTotalNumberOfRows() -> Int?{
        return gridListData.count 
    }
    
    func getCoverageImageURL(index : Int) -> String{
        return gridListData[index].coverageURL 
    }
    
    func callGridListApi() {
        Task {
            do {
                let data = try await self.imageGridrepository.fetchGridListFromAPI(limit: limit)
                gridListData.append(contentsOf: data)
                self.reloadCollectionView.value = true
            } catch let error{
                self.handleError.value = error.localizedDescription
            }
        }

    }

}
