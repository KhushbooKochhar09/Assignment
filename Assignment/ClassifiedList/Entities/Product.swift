import Foundation

struct ClassifiedResponseModel: Decodable {
    var productList: [Product]
    
    enum CodingKeys: String, CodingKey {
      case productList = "results"
    }
}

struct Product: Decodable {

    var imageURL: [String]
    var imageThumbnailURL: [String]
    var price: String
    var name: String

    enum CodingKeys: String, CodingKey {
        case imageThumbnailURL = "image_urls_thumbnails"
        case imageURL = "image_urls"
        case price = "price"
        case name = "name"
    }
}
