import UIKit
import SwiftUI

// MARK: - 프리뷰 기능 UIKit에서 사용 할 수 있게 하는 익스텐션
// 해당 익스텐션은 UIKit의 UIViewController에 SwiftUI의 Preview 기능을 추가하기 위함입니다.

// 다음은 단계별 요약입니다.
/*
 1. SwiftUI Import 하기
 2. 밑의 익스텐션으로 기능 활성화 하기
 3. 확장할 뷰를 Struct로 구현해서 브리뷰를 사용 할 수 있게 하기
 4. UIViewController를 확장 해서 구현 하는 듯.
 */

#if DEBUG // DEBUG 모드에서만 실행되도록 조건문 설정
extension UIViewController {
    // UIViewController를 SwiftUI로 표현하기 위한 구조체입니다.
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        // SwiftUI로 표현될 때 사용되는 UIViewController를 생성합니다.
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        // UIViewController를 업데이트하는 메서드 (이 경우 아무것도 하지 않음)
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    // 현재 UIViewController를 Preview로 변환하여 SwiftUI에서 표시될 수 있도록 합니다.
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif

#if DEBUG
extension UIViewController {
    // ...
    // 현재 UIViewController를 UINavigationController 안에 Preview로 변환하여 SwiftUI에서 표시될 수 있도록 합니다.
    func toNavigationPreview() -> some View {
        let navigationController = UINavigationController(rootViewController: self)
        return Preview(viewController: navigationController)
    }
}
#endif

#if DEBUG
// UIViewController의 SwiftUI Preview를 제공하는 구조체입니다.
struct ViewController_PreViews: PreviewProvider {
    static var previews: some View {
        ViewController().toNavigationPreview()
        
    }
    
}
#endif





// MARK: - 프로토콜로 데이터를 주고 받을 수 있게 하나 생성
// TabDelegate 프로토콜은 데이터를 전달하는 데 사용됩니다.
// 데이터를 줘야 하는 곳에서 생성 합니다.
protocol TabDelegate : AnyObject {
    func tabAction(value: String)
}


class ViewController: UIViewController {
    
    // 프로퍼티로 textField를 선언합니다.
    var textField: MyTextField!
    
    // 줘야 하는 곳에서 프로토콜 프로퍼티를 생성 합니다.
    // "편지를 전달해줄 대리인(델리게이트)를 찾아!"
    weak var detaDelegate : TabDelegate?
    
    
    // 스토리보드를 사용하여 UIViewController의 SwiftUI Preview를 제공하는 구조체입니다.
    /*
     struct VCPreView:PreviewProvider {
     static var previews: some View {
     UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController").toPreview()
     }
     }
     */
    
    // 뷰가 생성 되기 전에 텍스트 필드를 공백으로 만들어서 새로운 값을 받아올 준비를 합니다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.text = ""
    }
    
    
    
    // 뷰가 로드되었을 때의 동작을 정의합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        textField = MyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "여기에 텍스트를 입력해주세요."
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200),
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // 사용자 정의 버튼 (MyYellowButton)을 생성하고 설정합니다.
        let mainButton = MyYellowButton()
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButton.setTitle("이 버튼 누르면 다음 페이지의 셀에 내용이 입력 됩니다.", for: .normal)
        // 버튼 글씨 길어도 안 잘리게 하는 메서드 입니다. 자동으로 텍스트 레이블을 줄여줍니다.
        mainButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        // 버튼을 뷰에 추가합니다.
        view.addSubview(mainButton)
        
        // 버튼의 위치와 크기를 정의하는 제약 조건을 설정합니다.
        NSLayoutConstraint.activate([
            mainButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 300),
            mainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        mainButton.addTarget(self, action: #selector(movePage), for: .touchUpInside)
    }
    
    // 버튼이 눌렸을 때 실행 되는 함수 입니다.
    @objc func movePage() {
        // 추가로 알게 된 것 : present(secondVC, animated: true, completion: nil) 이건 네비게이션 바가 없을 때 밑에서 위로 올라오는 화면. 전체 화면으로 화면이 넘어가게 하려면 네비게이션 컨트롤러를 추가 해야 합니다.
        
        // 버튼이 눌리면 SecondView 객체를 생성합니다. 지금 firstClass에서 secondClass를 제어 하기 위함 입니다.
        let secondVC = SecondViewController()
        
        // 위에서 생성한 프로퍼티를 세컨드 뷰에 위임 합니다.
        // 데이터를 처리 할 수 있는 역할을 두번째 뷰에게 위임 하는 것이다.
        // "SecondViewController 너가 그 대리인이 될래? 내가 전달해야 할 편지가 있거든."
        // SecondViewController를 대리인으로 지정합니다.
        self.detaDelegate = secondVC
        
        // 이제 두번째 뷰로 정보를 전달 할 수 있습니다. 함수를 통해서 말이죠.
        // 여기서 작성된 텍스트 필드의 값을 위의 프로토콜 메서드의 파라미터로 보냅니다.
        // 이러면 tabAction의 함수의 파라미터 string이 텍스트필드에서 적은 텍스트가 됩니다.
        // "대리인(델리게이트)아, 이 편지(text)를 가져가서 원하는 대로 처리해줘!"
        if let text = textField.text {
            detaDelegate?.tabAction(value: text)
            
            // UserDefault에 저장 하는 방법 입니다.
            // 새로운 저장공간을 만들어주고 그 저장 공간에 텍스트를 추가 해줍니다.
            var storedText = UserDefaults.standard.array(forKey: "texts") as? [String] ?? []
            storedText.append(text)
            UserDefaults.standard.setValue(storedText, forKey: "texts")
            print("storedText\(storedText)")
            
            
            
        }
        
        // 네비게이션 컨트롤러를 사용해서 세컨드 뷰를 띄웁니다.
        // 코드로 구현 했기 때문에 네비게이션 컨트롤러는 앱 델리게이트에 있습니다.
        // 앱이 실행 되면 네비게이션 컨트롤러 부터 띄우면서 작업이 시작 되는 것입니다.
        navigationController?.show(secondVC, sender: self)
        
    }
}
