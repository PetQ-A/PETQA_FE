////
////  Applelogin.swift
////  PetQnA
////
////  Created by 김가영 on 7/15/24.
////
//

    @objc private func didTapAppleLoginButton() {
        let request: ASAuthorizationAppleIDReqeust = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
        
        let email:ASAuthorization.Scope
        let fullName:ASAuthorization.Scope
}
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization)
    func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithError error: Error)

    extension LoginViewController: ASAuthorizationControllerDelegate {

    // 성공 후 동작
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization)
    {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = credential.authorizationCode else {
            return
        }
        
        didSuccessdAppleLogin(code, credential.user) // 아래에 코드 있음
    }
    
    // 실패 후 동작
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error)
    {
        print("애플 로그인 실패")
    }
}
    private func didSuccessdAppleLogin(_ code: Data, _ user: String) {
    let autorizationCodeStr = String(data: code, encoding: .utf8)
    let parameter = ["accessToken": autorizationCodeStr!]
    
    API.appleOAuthLogin(parameter) { [weak self] info in
        DispatchQueue.main.async {
            print("appleOAutoLogin 응답: \(info)")
            LoginManager.shared.saveAppleLoginInfo(info)
            keyChain.create(userID: user)
            
            self?.goToInitialViewController()
        }
    }
}
class keyChain {
    
    class func create(userID: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userID",
            kSecValueData: userID.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        
        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "아이디 저장 실패")
    }
    
    class func read() -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userID",
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)

        if status == errSecSuccess {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            return ""
        }
    }
    
    class func delete() {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userID"
        ]
        
        let status = SecItemDelete(query)
        assert(status == noErr, "아이디 삭제 실패")
    }
}
func appleLogin() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    appleIDProvider.getCredentialState(forUserID: keyChain.read()!) { credentialState, error in
        switch credentialState {
        case .authorized:
            // 인증 성공 상태
            UserDefaults.standard.removeObject(forKey: "GoogleLoginInfo")
            print("애플 로그인 인증 성공")
            break
        case .revoked:
            // 인증 만료 상태 (사용자가 백그라운드에서 ID중지했을 경우)
            print("애플 로그인 인증 만료")
            // 만약 애플 로그인이 로그인 상태였으면 로그아웃 상태로 해야 함
            
            if keyChain.read() != "" {
                LoginManager.shared.logout { }
            }
    
            break
        case .notFound:
            // Credential을 찾을 수 없는 상태 (로그아웃 상태)
            print("애플 Credential을 찾을 수 없음")
            break
        default:
            break
        }
    }
}
    func sceneDidBecomeActive(_ scene: UIScene) {
     let appleIDProvider = ASAuthorizationAppleIDProvider()
     appleIDProvider.getCredentialState(forUserID: keyChain.read()!) { credentialState, error in
         switch credentialState {
         case .authorized:
             // 인증 성공 상태
             print("sceneDidBecomeActive - 애플 로그인 인증 성공")
             break
         case .revoked:
             // 인증 만료 상태 (사용자가 백그라운드에서 ID중지했을 경우)
             print("sceneDidBecomeActive - 애플 로그인 인증 만료")
             // 만약 애플 로그인이 로그인 상태였으면 로그아웃 상태로 해야 함
             
             if keyChain.read() != "" {
                 LoginManager.shared.logout {
                     DispatchQueue.main.async {
                         let homeViewController = UINavigationController(rootViewController: HomeViewController())
                         
                         self.window?.rootViewController = homeViewController
                         self.window?.rootViewController?.dismiss(animated: false)
                     }
                 }
             }
             
             break
         case .notFound:
             // Credential을 찾을 수 없는 상태 (로그아웃 상태)
             print("sceneDidBecomeActive - 애플 Credential을 찾을 수 없음")
             break
         default:
             break
         }
     }
 }
// LoginManager
func checkLogin(completion: @escaping() -> Void) {

        loadLoginInfo()
        
        // 애플 로그인 한 경우
        if appleLogin == true {
            
            let parameter: [String: Any] = [
                "id": appleLoginInfo!.userID,
                "token": appleLoginInfo!.rememberMeToken
            ]
            
            API.rememberedLogin(parameter) { info in
                guard let info = info else {
                    self.isLoggedIn = false
                    completion()
                    return
                }
                
                self.saveAppleLoginInfo(info)
                self.isLoggedIn = true
                self.firstLogin = true
                completion()
            }
        } else {
            self.isLoggedIn = false
            completion()
        }
    }
// LoginManager

func loadLoginInfo() {
    if keyChain.read() != "" {
            if let data = UserDefaults.standard.data(forKey: "AppleLoginInfo") {
                
                appleLoginInfo = try? PropertyListDecoder().decode(
                    LoginInfo.self,
                    from: data)
                
                appleLogin = true
                print("자동 로그인 정보 있음 - 애플")
            }
        } else {
            print("자동 로그인 정보 없음")
        }
    }
func logout(completion: @escaping () -> Void) {

    guard let cookies = HTTPCookieStorage.shared.cookies else { return }
            
    for cookie in cookies {
    HTTPCookieStorage.shared.deleteCookie(cookie)
    }
    
    keyChain.delete()
    self.appleLoginInfo = nil
    UserDefaults.standard.removeObject(forKey: "AppleLoginInfo")
    self.appleLogin = false
       completion()
    }


