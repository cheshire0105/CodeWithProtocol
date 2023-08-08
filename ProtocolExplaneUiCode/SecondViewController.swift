//
//  SecondViewController.swift
//  ProtocolExplaneUiCode
//
//  Created by cheshire on 2023/08/07.
//

import UIKit
import SwiftUI

// 전처리 함수 입니다. 앱이 실행 되기 전에 디버그 영역에서 실행 됩니다.
// 실제 앱을 실행 할때는 영향을 미치지 않습니다.
// 앞에서 데이터를 보내 줬지만 저장이 되어 있지 않기 때문에 이 클래스로만은 테이블 뷰를 그릴 수 없습니다. 데이터가 없기 때문입니다.
// 그렇기 때문에 디버그에 아무것도 떠있지 않습니다.
#if canImport(SwiftUI) && DEBUG

// 프리뷰를 보이게 하는 Struct
struct SecondViewController_PreViews: PreviewProvider {
    static var previews: some View {
        SecondViewController().toPreview()
    }
}

#endif


class SecondViewController: UIViewController {
    
    // 첫번째 뷰에서 전송한 텍스트를 두번째 뷰에서 받아서 저장할 저장 공간.
    var receivedText: String? = "임시 텍스트"
    
    // tableView를 클래스의 속성으로 만듭니다.
    let tableView = MyTableView()
    
    // 뷰가 로드 될 때 테이블 뷰를 생성 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 셀을 등록합니다.
        // 셀은 아래의 필수 메서드로 구현 됩니다.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 데이터 소스 설정
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // 뷰를 추가 하고 제약을 추가 해야 합니다. 그래서 addSubView를 우선 작성 합니다.
        view.addSubview(tableView)
        
        // 테이블 뷰의 제약 조건입니다.
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // 테이블 뷰가 로드 되면 새로 고침 해서 데이터를 새롭게 갱신 합니다.
        tableView.reloadData()
        
    }
    
    // 뷰가 보이기 전에 실행 되는 함수 입니다.
    // 네비게이션 컨트롤러가 뷰가 실행 되기 전에 먼저 보여져야 합니다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}



// 위의 뷰와 똑같지만 가독성을 위해서 extension으로 구현 했습니다.
// 첫번째 뷰에서 생성한 데이터 전송을 위한 프로토콜을 채택했습니다.
extension SecondViewController:  TabDelegate {
    func tabAction(value: String) {
        print("\(value) 데이터를 받았다.")
        
        // 받아온 데이터를 앞서 생성한 변수에 담아 둡니다.
        receivedText = value
    }
}

// 위의 뷰와 똑같지만 가독성을 위해서 테이블 뷰를 채택한 클래스를 따로 만들었습니다.
extension SecondViewController: UITableViewDataSource {
    
    // 각각의 셀을 구현하는 필수 메서드들 입니다.
    
    // 셀을 몇개를 보여줄 지 정하는 함수 입니다.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedText != nil ? 1 : 0 // 텍스트가 있으면 1, 없으면 0
    }
    
    // 각각의 테이블 뷰를 어떻게 구성 할 건지 정하는 함수 입니다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 테이블 뷰의 셀은 메모리 효율성 측면에서 재사용성을 염두 합니다.
        // 그렇기 때문에 화면에 보여지지 않는 나머지 셀들을 새로운 셀로 이용 하는 방식을 사용 합니다.
        // dequeueReusableCell 이 함수는 보여지지 않는 셀들을 새로운 셀로 데이터를 채워서 사용 할 수 있게 해주는 함수 입니다.
        // 쉽게 말해서 재 사용을 위한 메서드 라고 할 수 있습니다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // 셀의 레이블을 앞서 받아온 텍스트를 이용해서 보여줍니다.
        cell.textLabel?.text = receivedText
        return cell
    }
}
