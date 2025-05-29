//
//  Register.swift
//  InicioBBVA
//
//  Created by Asenet on 13/05/25.
//

import SwiftUI


enum NavigationTag: Hashable, Equatable {
    case requerimientos
    case ComoOpera
}

struct Register: View {
    @State private var navigationPath = NavigationPath()


    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                // Fondo color #072146
                Color(hex: "072146")
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Imagen superior de dimensiones 393 x 285
                    Image("headerImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.700)
                        .padding(.top, 0)
                        .edgesIgnoringSafeArea(.top)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("Da el paso adelante y formaliza tus sueños")
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 200)
                    
                    // Botón de registrar color #1873B9
                    Button(action: {
                        navigationPath.append(NavigationTag.requerimientos)
                        print("registro pressed")
                    }) {
                        Text("Registrar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "1873B9"))
                            .cornerRadius(10)
                    }

                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                }
                .padding(.top, 0)
            }
            .navigationBarHidden(true)
            .navigationDestination(for: NavigationTag.self) { tag in
                switch tag {
                case .requerimientos:
                    Requerimientos(navigationPath: $navigationPath)
                case .ComoOpera:
                    ComoOpera()
                }
            }
        }
    }
}


// Extensión para manejar colores hexadecimales
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
