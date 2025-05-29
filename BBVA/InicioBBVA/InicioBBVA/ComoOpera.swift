//
//  ComoOpera.swift
//  InicioBBVA
//
//  Created by Asenet on 13/05/25.
//

import SwiftUI

struct ComoOpera: View {
    @State private var selectedOption: BusinessType? = nil
    
    enum BusinessType {
        case ownBusiness
        case companyWithPartners
    }
    
    var body: some View {
        ZStack {
            // Fondo azul oscuro
            Color(UIColor(red: 0.05, green: 0.1, blue: 0.3, alpha: 1.0))
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Icono de ubicación
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                    .background(Color.white.opacity(0.2))
                    .clipShape(Circle())
                
                // Título
                Text("¿Cómo operas actualmente?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                // Opciones
                VStack(spacing: 15) {
                    BusinessTypeOption(
                        isSelected: selectedOption == .ownBusiness,
                        title: "Soy una persona con un negocio propio",
                        action: { selectedOption = .ownBusiness }
                    )
                    
                    BusinessTypeOption(
                        isSelected: selectedOption == .companyWithPartners,
                        title: "Tengo una empresa con socios",
                        action: { selectedOption = .companyWithPartners }
                    )
                }
                .padding(.bottom, 30)
                
                // Descripción
                VStack(spacing: 30) {
                    Text("Al tener un negocio propio te conviertes en una persona física con actividad empresarial")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Si tienes una empresa con socios eres una persona moral")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                HStack{
                            NavigationLink(destination: SimpleFormView()) {
                                Text("Continuar")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1.0))))
                
            }
            
            .navigationBarHidden(true)
        }
        
        
            }
        }
    }
}


struct BusinessTypeOption: View {
    let isSelected: Bool
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: 24, height: 24)
                        .background(isSelected ? Color.white : Color.clear)
                    
                    if isSelected {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white)
                            .frame(width: 16, height: 16)
                    }
                }
                
                Text(title)
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct ComoOpera_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ComoOpera()
        }
    }
}
