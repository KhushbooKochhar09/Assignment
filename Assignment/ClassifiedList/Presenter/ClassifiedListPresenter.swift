class ClassifiedListPresenter: ClassifiedListPresenterProtocol {
    func fetchClassifiedList() {
        interactor?.showLoading()
        interactor?.retrieveClassifiedList()
    }
    
    func showClassifiedDetail(product: Product) {
        wireFrame?.presentClassifiedDetailScreen(view: view!, product: product)
    }
    
    weak var view: ClassifiedListViewProtocol?
    var interactor: ClassifiedListInteractorInputProtocol?
    var wireFrame: ClassifiedListWireFrameProtocol?

}

extension ClassifiedListPresenter: ClassifiedListInteractorOutputProtocol {
    
    func showNoDataLabel() {
        view?.showNoDataLabel()
    }
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    func didRetrieveClassifieds(products: [Product]) {
        view?.showProducts(with: products)
    }
    
    func onError(errorMessage: String) {
        view?.showError(errorMessage: errorMessage)
    }
    
}
