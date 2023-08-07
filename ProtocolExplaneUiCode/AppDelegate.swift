//
//  AppDelegate.swift
//  ProtocolExplaneUiCode
//
//  Created by cheshire on 2023/08/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /*
     스토리보드를 사용하지 않고 코드로 네비게이션 컨트롤러를 설정하고 사용하는 방법을 아래에 설명하겠습니다
     1. UIWindow 생성 및 설정: 앱이 시작될 때 UIWindow 인스턴스를 생성하고, 이를 화면에 표시합니다.
     2. 초기 뷰 컨트롤러 설정: 앱의 시작점이 될 뷰 컨트롤러를 생성합니다. 예를 들면, ViewController를 생성할 수 있습니다.
     3. 네비게이션 컨트롤러 생성: 초기 뷰 컨트롤러를 사용하여 UINavigationController 인스턴스를 생성합니다.
     4. UIWindow의 루트 뷰 컨트롤러 설정: UIWindow의 rootViewController 속성에 네비게이션 컨트롤러를 설정합니다.
     5. 창 표시: UIWindow의 makeKeyAndVisible 메서드를 호출하여 창을 화면에 표시합니다.
     */
    
    // 윈도우 객체 생성, 네비게이션 컨트롤러를 추가 하기 위해서
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 앱이 시작 될 때 네비게이션 코드를 추가
        
        // UIWindow 인스턴스 생성
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 초기 뷰 컨트롤러 생성
        let viewController = ViewController()
        
        // 뷰 컨트롤러를 UINavigationController에 임베드
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // UIWindow의 rootViewController로 네비게이션 컨트롤러 설정
        window?.rootViewController = navigationController
        
        // UIWindow 표시
        window?.makeKeyAndVisible()
        
        return true
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

