//
//  SecondViewController.swift
//  ProtocolExplaneUiCode
//
//  Created by cheshire on 2023/08/07.
//

import UIKit
import SwiftUI

class SecondViewController: UIViewController {
    
    // 프리뷰를 보이게 하는 Struct
    struct SecondViewController_PreViews: PreviewProvider {
        static var previews: some View {
            SecondViewController().toPreview()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = MyTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    
    
    
    
}



// 프로토콜로 데이터를 받게 하는 뷰의 익스텐션 클래스 
extension SecondViewController: TabDelegate {
    func tabAction(value: String) {
        print("\(value) 데이터를 받았다.")
    }
    
    
}
