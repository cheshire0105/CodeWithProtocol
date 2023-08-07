import UIKit
import SwiftUI

// MARK: - 메인 버튼
class MyYellowButton: UIButton {
    
    // 버튼의 프레임으로 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView() // 버튼 뷰 설정 메서드 호출
    }
    
    // Interface Builder 지원하지 않음
    required init?(coder: NSCoder) {
        fatalError("not support coder")
    }
    
    // 버튼의 기본 설정 메서드
    private func setupView() {
        backgroundColor = .yellow // 배경색을 노란색으로 설정
        setTitleColor(.black, for: .normal) // 텍스트 색상을 검은색으로 설정
    }
}

#if canImport(SwiftUI) && DEBUG

// MyYellowButton의 SwiftUI 미리보기
struct MyYellowButtonPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = MyYellowButton(frame: .zero) // MyYellowButton 인스턴스 생성
            button.setTitle("buttonTest", for: .normal) // 버튼 텍스트 설정
            return button
        }.previewLayout(.sizeThatFits) // 미리보기 레이아웃 설정. 프리뷰에서 Selectable을 선택 해야 볼 수 있음. 이걸 안하면 오브젝트만 나오지 않는다.
    }
}
#endif

// MARK: - 테이블 뷰
class MyTableView: UITableView, UITableViewDataSource {
    
    let dummyData: [String] = ["Item 1", "Item 2", "Item 3"] // 예시용 데이터
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.dataSource = self // 데이터 소스를 자신으로 설정
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // 기본 셀을 등록
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UITableViewDataSource 프로토콜의 메서드
    
    // 섹션당 행의 수를 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    // 각 행의 셀을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dummyData[indexPath.row]
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG

// MyTableView의 SwiftUI 미리보기
struct MyTableViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let tableView = MyTableView(frame: .zero) // MyTableView 인스턴스 생성
            tableView.backgroundColor = .lightGray // 배경색 설정, 예시용
            return tableView
        }
        .previewLayout(.sizeThatFits) // 미리보기 레이아웃 설정. 프리뷰에서 Selectable을 선택 해야 볼 수 있음. 이걸 안하면 오브젝트만 나오지 않는다.
    }
}

#endif


// MARK: - 텍스트 필드
class MyTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView() // 텍스트 필드 뷰 설정 메서드 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.borderStyle = .roundedRect // 텍스트 필드의 테두리 스타일 설정
        self.placeholder = "Enter text here..." // 텍스트 필드의 플레이스홀더 텍스트 설정
    }
}

#if canImport(SwiftUI) && DEBUG

// MyTextField의 SwiftUI 미리보기
struct MyTextFieldPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let textField = MyTextField(frame: .zero) // MyTextField 인스턴스 생성
            return textField
        }.previewLayout(.sizeThatFits) // 미리보기 레이아웃 설정
    }
}

#endif





#if canImport(SwiftUI) && DEBUG

// UIView를 SwiftUI로 미리보기 가능하게 하는 구조체
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    // 뷰를 생성하는 클로저를 사용하여 초기화
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // SwiftUI에서 사용할 UIView를 반환
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    // UIView 업데이트 (여기서는 Content Hugging Priority를 설정)
    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif





// MARK: - 미리 보기 원리 설명
/*
 
 1. UIViewPreview:
 - `UIViewPreview`는 `UIView` 객체를 SwiftUI에서 미리 볼 수 있도록 하는 구조체입니다. 즉, UIKit의 `UIView`를 SwiftUI 프리뷰에 표시할 수 있게 해주는 역할을 합니다.
 - 이 구조체는 일반적으로 여러 UIKit 컴포넌트에 대한 미리보기를 만들 때 재사용될 수 있습니다.
 
 2. MyYellowButtonPreview:
 - `MyYellowButtonPreview`는 `MyYellowButton` 클래스에 대한 실제 미리보기를 제공하는 구조체입니다.
 - 이 구조체에서 `UIViewPreview`를 사용하여 `MyYellowButton`을 SwiftUI에서 미리 볼 수 있도록 설정합니다.
 
 따라서, `MyYellowButton`을 SwiftUI에서 미리 보려면, `UIViewPreview`를 정의하여 `UIView`를 SwiftUI에서 미리 볼 수 있게 해주고, `MyYellowButtonPreview`를 사용하여 해당 버튼의 실제 미리보기를 생성해야 합니다.
 
 */

// MARK: 두 미리보기 객체의 쉬운 비유
/*
 
 물론입니다! 두 구조체의 역할을 간단하고 명확하게 다시 설명해 보겠습니다.
 
 1. `UIViewPreview`:
 - 역할: UIKit의 `UIView` 객체를 SwiftUI 환경에서 볼 수 있게 해주는 "다리" 역할을 합니다.
 - 이것 없이는 SwiftUI 프리뷰에서 UIKit 뷰를 직접 보는 것은 불가능합니다.
 
 2. `MyYellowButtonPreview`:
 - 역할: 특정 `UIView` (여기서는 `MyYellowButton`)에 대한 미리보기를 실제로 생성하고 설정하는 역할을 합니다.
 - 이것 없이는 `MyYellowButton`에 대한 미리보기를 볼 수 없습니다.
 
 만약...
 
 - `UIViewPreview`가 없다면**: UIKit 객체를 SwiftUI에서 미리 볼 수 있는 "다리"가 사라집니다. 따라서 어떠한 UIKit 뷰도 SwiftUI에서 미리 볼 수 없게 됩니다.
 
 - `MyYellowButtonPreview`가 없다면**: "다리"는 있지만, `MyYellowButton`에 대한 미리보기를 설정하고 생성하는 부분이 없습니다. 따라서 `MyYellowButton`을 SwiftUI에서 미리 보는 것은 불가능합니다.
 
 간단히 말하면, `UIViewPreview`는 SwiftUI 프리뷰에서 UIKit 뷰를 볼 수 있게 해주는 도구이며, `MyYellowButtonPreview`는 그 도구를 사용하여 `MyYellowButton`에 대한 실제 미리보기를 생성하는 역할을 합니다. 둘 중 하나라도 없으면 원하는 미리보기 기능을 제대로 사용할 수 없습니다.
 
 */
