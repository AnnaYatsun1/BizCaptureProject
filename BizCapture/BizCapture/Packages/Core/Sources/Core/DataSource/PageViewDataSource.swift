//
//  PageViewDataSource.swift
//  Core
//
//  Created by Анна Яцун on 23.10.2024.
//

import UIKit

public protocol Tes {

}


//
//public protocol PageViewDataSourceDelegate: AnyObject {
//    func viewController(for model: PageModelType) -> UIViewController
//    func index(of model: PageModelType, in models: [PageModelType]) -> Int?
//}
//
//public class PageViewDataSource<Model: PageModelType>: NSObject, UIPageViewControllerDataSource {
//    private let models: [Model]
//    public weak var delegate: PageViewDataSourceDelegate?
//    
//    public init(models: [Model], delegate: PageViewDataSourceDelegate) {
//        self.models = models
//        self.delegate = delegate
//    }
//    
//    // MARK: - UIPageViewControllerDataSource Methods
//    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let currentModel = extractModel(from: viewController),
//              let index = delegate?.index(of: currentModel, in: models),
//              index > 0 else {
//            return nil
//        }
//        
//        let previousModel = models[index - 1]
//        return delegate?.viewController(for: previousModel)
//    }
//    
//    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let currentModel = extractModel(from: viewController),
//              let index = delegate?.index(of: currentModel, in: models),
//              index < models.count - 1 else {
//            return nil
//        }
//        
//        let nextModel = models[index + 1]
//        return delegate?.viewController(for: nextModel)
//    }
//    
////    private func extractModel(from viewController: UIViewController) -> Model? {
////        if let modelHolder = viewController as? ModelHolder {
////            return modelHolder.model as? Model
////        }
////        return nil
////    }
//}
