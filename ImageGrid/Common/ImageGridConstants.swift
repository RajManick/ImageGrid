//
//  ImageGridConstants.swift
//  ImageGrid
//
//  Created by Manick on 15/04/24.
//

import Foundation


struct ImageGridConstants {
    
    enum Api {
       public static let girdListURL = "https://acharyaprashant.org/api/v2/content/misc/media-coverages"
    }
    
    enum CellIdentifier {
       public static let imageGridCollectionViewCell = "ImageGridCell"
    }
    
    public static let imageGettingCount = 100
    public static let imagePlaceholder = "dummyImage"
    public static let appName = "ImageGrid"
    public static let listApiErrorHeader = "Fetch List API Error"
    public static let okTitle = "Ok"
}


extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
