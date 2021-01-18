class ClassifiedListInteractor: ClassifiedListInteractorInputProtocol {

    weak var presenter: ClassifiedListInteractorOutputProtocol?
    var remoteDatamanager: ClassifiedListRemoteDataManagerInputProtocol?
    
    func retrieveClassifiedList() {
        guard ConnectivityManager.isConnectedToInternet() else {
            self.updateOnError(error: LocalizationConstant.internetError)
            return
        }
        remoteDatamanager?.retrieveClassifiedList()
    }
    
    func showLoading() {
        presenter?.showLoading()
    }
    
    func updateOnError(error: String) {
        presenter?.hideLoading()
        presenter?.onError(errorMessage: error)
    }
}

extension ClassifiedListInteractor: ClassifiedListRemoteDataManagerOutputProtocol {
    
    func onProductRetrieved(_ products: [Product]) {
        presenter?.hideLoading()
        presenter?.didRetrieveClassifieds(products: products)
    }
    
    func onError(errorMessage: String) {
        self.updateOnError(error: errorMessage)
    }
    
}
