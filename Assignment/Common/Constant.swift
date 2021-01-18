import Foundation
import UIKit

struct API {
    static let baseUrl = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Classifieds: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/default/dynamodb-writer"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}

struct Constant {
    
    // MARK: Struct
    
    struct CellIdentifier {
        static let listCell = "ClassifiedTableViewCell"
        static let imageCell = "ClassifiedCollectionViewCell"
        static let imageDetailCell = "ClassifiedDetailCollectionViewCell"
        
    }
    
    struct Endpoint {
        static let deliveries = "/deliveries"
    }
    
    static let tableAccessibilityIdentifier = "table--deliveryTableView"
    static let appToastMessageBackgroundColor = UIColor(red: 217/255.0, green: 96/255.0, blue: 86/255, alpha: 1.0)

}

struct LocalizationConstant {
    static let listVCTitle = NSLocalizedString("listVCTitle", comment: "")
    static let detailVCTitle =  NSLocalizedString("detailVCTitle", comment: "")
    static let internetError = NSLocalizedString("internetError", comment: "")
    static let otherError = NSLocalizedString("otherError", comment: "")
    static let noClassifieds = NSLocalizedString("noClassifieds", comment: "")
    static let noDataError = NSLocalizedString("noDataError", comment: "")
}
