import UIKit

class ClassifiedDetailWireFrame: ClassifiedDetailWireFrameProtocol {
   
    class func createClassifiedDetailModule(for classified: Product) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "ClassifiedDetailViewController") as! ClassifiedDetailViewController
        let presenter: ClassifiedDetailPresenterProtocol = ClassifiedDetailPresenter()
        let wireFrame: ClassifiedDetailWireFrameProtocol = ClassifiedDetailWireFrame()
        view.presenter = presenter
        presenter.view = view
        presenter.classified = classified
        presenter.wireFrame = wireFrame
        return view
    }
    
}
