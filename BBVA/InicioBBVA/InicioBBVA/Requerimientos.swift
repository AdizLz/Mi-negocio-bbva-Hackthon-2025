//
//  Requerimientos.swift
//  InicioBBVA
//
//  Created by Asenet on 13/05/25.
//

import SwiftUI

struct Requerimientos: View {
    @Binding var navigationPath: NavigationPath
    @State private var navigateToComoOpera = false  // Ya no necesario si usas navigationPath

    var body: some View {
        ZStack {
            Color(hex: "072146")
                .ignoresSafeArea()

            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                        navigationPath.removeLast()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                .padding(.top, 0)

                HStack(spacing: -35) {
                    Image("Heart")
                    Image("messege")
                }

                Text("Requerimientos")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        requerimientoItem(titulo: "Identificación oficial", descripcion: "INE, Pasaporte o Cédula Profesional vigente", icono: "person.text.rectangle")
                        requerimientoItem(titulo: "Comprobante de domicilio", descripcion: "No mayor a 3 meses de antigüedad", icono: "house")
                        requerimientoItem(titulo: "Comprobante de ingresos", descripcion: "Estados de cuenta, recibos de nómina o declaración anual", icono: "creditcard")
                        requerimientoItem(titulo: "Historial crediticio", descripcion: "Buró de crédito sin adeudos importantes", icono: "chart.bar.doc.horizontal")
                    }
                    .padding(.horizontal, 20)
                }

                Spacer()

                Button(action: {
                    navigationPath.append(NavigationTag.ComoOpera)
                }) {
                    Text("Continuar")
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
        }
    }

    func requerimientoItem(titulo: String, descripcion: String, icono: String = "doc.text") -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icono)
                .foregroundColor(.white)
                .font(.title3)

            VStack(alignment: .leading, spacing: 5) {
                Text(titulo)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(descripcion)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}
