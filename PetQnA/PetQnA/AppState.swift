//
//  AppState.swift
//  PetQnA
//
//  Created by 김동섭 on 7/26/24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var selectedPet: LoginSelectPetView.PetType?
    @Published var petName: String = ""
}
