import UIKit

class ClassifiedListWireFrame: ClassifiedListWireFrameProtocol {
    func presentClassifiedDetailScreen(view: ClassifiedListViewProtocol, product: Product) {
        let classifiedDetailViewController = ClassifiedDetailWireFrame.createClassifiedDetailModule(for: product)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(classifiedDetailViewController, animated: true)
        }
    }
    
    static func createClassifiedListModule() -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "ClassifiedListViewController") as! ClassifiedListViewController
        let navController = UINavigationController(rootViewController: view)
        let presenter: ClassifiedListPresenterProtocol & ClassifiedListInteractorOutputProtocol = ClassifiedListPresenter()
        let interactor: ClassifiedListInteractorInputProtocol & ClassifiedListRemoteDataManagerOutputProtocol = ClassifiedListInteractor()
        let remoteDataManager: ClassifiedListRemoteDataManagerInputProtocol = ClassifiedListRemoteDataManager()
        let wireFrame: ClassifiedListWireFrameProtocol = ClassifiedListWireFrame()
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return navController
    }
    
}
