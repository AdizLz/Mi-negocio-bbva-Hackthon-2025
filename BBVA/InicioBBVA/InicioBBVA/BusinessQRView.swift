//
//  BusinessQRView.swift
//  InicioBBVA
//
//  Created by Damaris B on 13/05/25.
//
import SwiftUI

struct BusinessQRView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                

                
                Spacer()
                
                // Nombre del negocio
                Text("Papeleria ABBA")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Imagen QR
                Image(systemName: "qrcode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                
                // Info del negocio
                VStack(alignment: .leading, spacing: 6) {
                    Text("📍 Av. Jarachina Reynosa, Tam.")
                    Text("📞 +52 55 1234 5678")
                    Text("🕐 Lun - Vie: 8:00 AM - 6:00 PM")
                }
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Botón de compartir
                Button(action: {
                    // Acción de compartir
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Compartir")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .navigationBarHidden(true) // Oculta la barra superior si no la quieres
        }
    }
}


struct BusinessQRView_Views: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            BusinessQRView()
        }
    }
}
