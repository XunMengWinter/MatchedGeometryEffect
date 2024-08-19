//
//  ModalViewModifier.swift
//  Hero
//
//  Created by Safwen DEBBICHI on 22/01/2024.
//  Edited by ice on 19/08/2024.
//

import SwiftUI

struct GameViewModifier<Destination: View, Bindable: Identifiable>: ViewModifier {
    @Binding var value: Bindable?
    let destination: (_ value: Bindable) -> Destination
    func body(content: Content) -> some View {
        ZStack{
            content
            if let value {
                destination(value)
                    .background(.regularMaterial)
                    .ignoresSafeArea()
                    .statusBarHidden()
            }
        }
    }
}

extension View {
    func game<Destination: View, Bindable: Identifiable>(bindable: Binding<Bindable?>, @ViewBuilder destination: @escaping (_ value: Bindable) -> Destination) -> some View {
        self.modifier(GameViewModifier(value: bindable, destination: destination))
    }
}

extension Binding where Value == Game? {
    var toBoolBinding: Binding<Bool> {
        Binding<Bool>.init {
            self.wrappedValue != nil
        } set: { value in
            if !value {
                self.wrappedValue = nil
            }
        }

    }
}
