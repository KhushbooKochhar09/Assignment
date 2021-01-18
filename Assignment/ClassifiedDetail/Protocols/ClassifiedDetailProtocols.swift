import UIKit

protocol ClassifiedDetailViewProtocol: class {
    var presenter: ClassifiedDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showClassifiedDetail(for classified: Product)
}

protocol ClassifiedDetailWireFrameProtocol: class {
    static func createClassifiedDetailModule(for classified: Product) -> UIViewController
}

protocol ClassifiedDetailPresenterProtocol: class {
    var view: ClassifiedDetailViewProtocol? { get set }
    var wireFrame: ClassifiedDetailWireFrameProtocol? { get set }
    var classified: Product? { get set }
    
    // VIEW -> PRESENTER
    func showClassifiedDetail()
}
