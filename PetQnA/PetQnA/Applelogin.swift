//
//  Applelogin.swift
//  PetQnA
//
//  Created by 김가영 on 7/15/24.
//

@objc func clickAppleLogin(_ sender: UITapGestureRecognizer) {
   
    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.fullName, .email]

    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.delegate = self as? ASAuthorizationControllerDelegate
    controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
    controller.performRequests()

    extension LoginVC: ASAuthorizationControllerDelegate {
        // 성공
        func authorizationController(controller: ASAuthorizationController, didComplete authorization: ASAuthorization) {
            if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {

                let idToken = credential.identityToken!
                let tokeStr = String(data: idToken, encoding: .utf8)
                print(tokeStr)

                guard let code = credential.authorizationCode else { return }
                let codeStr = String(data: code, encoding: .utf8)
                print(codeStr)

                let user = credential.user
                print(user)

            }
        }

        // 실패
        func authorizationController(controller: ASAuthorizationController, didError error: Error) {
            print("error")
        }
    }
}
 

