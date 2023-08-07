//
//  SecondViewController.swift
//  ProtocolExplaneUiCode
//
//  Created by cheshire on 2023/08/07.
//

import UIKit
import SwiftUI

class SecondViewController: UIViewController {
    
    var receivedText: String?
    let tableView = MyTableView() // tableView를 클래스의 속성으로 만듭니다.
    
    
    
    // 프리뷰를 보이게 하는 Struct
    struct SecondViewController_PreViews: PreviewProvider {
        static var previews: some View {
            SecondViewController().toPreview()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults로부터 값을 읽어옴
        if let savedText = UserDefaults.standard.string(forKey: "savedText") {
            receivedText = savedText
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // 셀을 등록합니다.
        tableView.dataSource = self // 데이터 소스 설정
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.reloadData() // 데이터 갱신
        
        
        
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

extension SecondViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedText != nil ? 1 : 0 // 텍스트가 있으면 1, 없으면 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = receivedText
        return cell
    }
}
