class ClassifiedDetailPresenter: ClassifiedDetailPresenterProtocol {
    
    weak var view: ClassifiedDetailViewProtocol?
    var wireFrame: ClassifiedDetailWireFrameProtocol?
    var classified: Product?
    
    func showClassifiedDetail() {
        guard let product = classified
            else {return}
        view?.showClassifiedDetail(for: product)
    }
}
