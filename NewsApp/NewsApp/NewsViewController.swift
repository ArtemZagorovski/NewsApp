//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    
}

//MARK: - Setup layout and views
extension NewsViewController{
    
    private func setupView() {
        
    }
    
    private func setupLayout() {
        
    }
    
}


// MARK: - SwiftUI
import SwiftUI

struct ViewsVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let signUpVC = NewsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ViewsVCProvider.ContainerView>) -> NewsViewController {
            return signUpVC
        }
        
        func updateUIViewController(_ uiViewController: ViewsVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ViewsVCProvider.ContainerView>) {
            
        }
    }
}
