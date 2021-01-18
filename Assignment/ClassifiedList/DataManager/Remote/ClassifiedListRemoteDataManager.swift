import Foundation
import Alamofire

class ClassifiedListRemoteDataManager: ClassifiedListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: ClassifiedListRemoteDataManagerOutputProtocol?
    
    func retrieveClassifiedList() {
        
        AF.request(Endpoints.Classifieds.fetch.url).validate().responseDecodable(of: ClassifiedResponseModel.self) { (response) in
            
            switch response.result {
            case .success:
                guard let productList = response.value else {
                   return
                }
                self.remoteRequestHandler?.onProductRetrieved(productList.productList)
            case .failure:
                self.remoteRequestHandler?.onError(errorMessage: response.error!.localizedDescription)
            }
            
        }
    }
}
