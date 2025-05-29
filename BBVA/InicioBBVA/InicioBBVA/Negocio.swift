//
//  Negocio.swift
//  InicioBBVA
//
//  Created by Asenet on 13/05/25.
//

import SwiftUI

struct NegocioFormView: View {
    @State private var nombre = ""
    @State private var giro = ""
    @State private var ubicacion = ""
    @State private var navegar = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 7/255, green: 33/255, blue: 70/255)
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Conozcamos\ntu negocio!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)

                        Group {
                            TextField("Nombre", text: $nombre)
                            TextField("Giro", text: $giro)
                            TextField("Ubicación", text: $ubicacion)
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .foregroundColor(.white)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )

                        Text("¿Cómo lo cobras actualmente?")
                            .foregroundColor(.white)
                            .padding(.top, 10)

                        HStack(spacing: 16) {
                            Button(action: {
                                // Acción botón 1
                            }) {
                                Text("Quiero\nFormalizarlo")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(12)
                            }

                            Button(action: {
                                // Acción botón 2
                            }) {
                                Text("Saber\nAdministrar")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(12)
                            }
                        }

                        Button(action: {
                            navegar = true
                        }) {
                            Text("Continuar")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.5))
                                .cornerRadius(10)
                        }
                        .padding(.top, 30)

                        // NavigationLink para la siguiente pantalla
                        NavigationLink(destination: Inicio(), isActive: $navegar) {
                            EmptyView()
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    NegocioFormView()
}


//ESTA ESTA PENDIENTE DE CONECTAR Y MODIFICAR
