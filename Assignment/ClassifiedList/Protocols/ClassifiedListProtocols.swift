import UIKit

protocol ClassifiedListViewProtocol: class {
    var presenter: ClassifiedListPresenterProtocol? {get set}
    // PRESENTER -> VIEW
    func showProducts(with deliveries: [Product])
    func showError(errorMessage: String)
    func showLoading()
    func hideLoading()
    func showNoDataLabel()
}

protocol ClassifiedListWireFrameProtocol: class {
    static func createClassifiedListModule() -> UIViewController
    // PRESENTER -> WIREFRAME
func presentClassifiedDetailScreen(view: ClassifiedListViewProtocol, product: Product)
}

protocol ClassifiedListPresenterProtocol: class {
    var view: ClassifiedListViewProtocol? { get set }
    var interactor: ClassifiedListInteractorInputProtocol? { get set }
    var wireFrame: ClassifiedListWireFrameProtocol? { get set }
    // VIEW -> PRESENTER
    func fetchClassifiedList()
    func showClassifiedDetail(product: Product)
    
}

protocol ClassifiedListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveClassifieds(products: [Product])
    func showLoading()
    func showNoDataLabel()
    func hideLoading()
    func onError(errorMessage: String)
}

protocol ClassifiedListInteractorInputProtocol: class {
    var presenter: ClassifiedListInteractorOutputProtocol? { get set }
    var remoteDatamanager: ClassifiedListRemoteDataManagerInputProtocol? { get set }
    // PRESENTER -> INTERACTOR
    func retrieveClassifiedList()
    func showLoading()
}

protocol ClassifiedListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol ClassifiedListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ClassifiedListRemoteDataManagerOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveClassifiedList()
}

protocol ClassifiedListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onProductRetrieved(_ products: [Product])
    func onError(errorMessage: String)
}
