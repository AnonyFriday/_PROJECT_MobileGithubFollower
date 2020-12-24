

import UIKit

class GFLoadableProperties {
    fileprivate var containerView: UIView!
}

protocol GFLoadable: AnyObject {
    
    var loadableProperties: GFLoadableProperties { get }
    
    func showLoadingView()
    func dismissLoadingView()
    func showEmptyState(message: String, in view: UIView)
    
}

extension GFLoadable where Self: UIViewController{

    func showLoadingView() {
        loadableProperties.containerView    = .init(frame: view.bounds)
        self.view.addSubview(loadableProperties.containerView)

        loadableProperties.containerView.backgroundColor       = . secondarySystemBackground
        loadableProperties.containerView.alpha                 = 0.0


        let activityIndicator               = UIActivityIndicatorView(frame: loadableProperties.containerView.bounds)
        loadableProperties.containerView.addSubview(activityIndicator)

        activityIndicator.color             = . systemGreen
        activityIndicator.style             = .large
        activityIndicator.center            = loadableProperties.containerView.center
        activityIndicator.startAnimating()

        UIView.animate(withDuration: 0.25) { [self] in
            loadableProperties.containerView.alpha = 0.8
        }
    }

    
    func dismissLoadingView() {
        DispatchQueue.main.async { [self] in
            loadableProperties.containerView.removeFromSuperview()
            loadableProperties.containerView   = nil
        }
    }

    
    func showEmptyState(message: String, in view: UIView){
        let emptyState = GFEmptyStateView(message: message, in: view)
        view.addSubview(emptyState)
    }
}


//class GFDataLoadingVC: UIViewController {
//
//    private var containerView: UIView!
//
//    //MARK: - Show/ Dismiss LoadingView
//    func showLoadingView() {
//        containerView                   = .init(frame: self.view.bounds)
//        self.view.addSubview(containerView)
//
//        containerView.backgroundColor   = .secondarySystemBackground
//        containerView.alpha             = 0
//
//        let activityIndicator            = UIActivityIndicatorView(frame: containerView.bounds)
//        containerView.addSubview(activityIndicator)
//
//        activityIndicator.center        = containerView.center
//        activityIndicator.style         = .large
//        activityIndicator.color         = .systemGreen
//
//        activityIndicator.startAnimating()
//        UIView.animate(withDuration: 0.75, delay: 0.2) { self.containerView.alpha = 0.8 }
//    }
//
//    //MARK: Dismiss Loading View
//    func dismissLoadingView() {
//        DispatchQueue.main.async {
//            self.containerView.removeFromSuperview()
//            self.containerView = nil
//        }
//    }
//
//    //MARK: Show Empry State
//    func showEmptyState(message: String, in view: UIView) {
//        let emptyState = GFEmptyStateView(message: message, in: view)
//        view.addSubview(emptyState)
//    }
//}
