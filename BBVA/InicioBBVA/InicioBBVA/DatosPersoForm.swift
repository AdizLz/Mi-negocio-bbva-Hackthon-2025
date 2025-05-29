//
//  DatosPersoForm.swift
//  InicioBBVA
//
//  Created by Asenet on 13/05/25.
//

import SwiftUI
import PhotosUI

struct SimpleFormView: View {
    @State private var nombre: String = ""
    @State private var email: String = ""
    @State private var telefono: String = ""
    @State private var curp: String = ""
    @State private var formEnviado = false
    @State private var navegar = false
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo color azul marino oscuro
                Color(red: 7/255, green: 33/255, blue: 70/255)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Campo de texto para el nombre
                        TextField("Nombre", text: $nombre)
                            .padding()
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            .foregroundColor(.black)
                        
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            .foregroundColor(.black)
                        
                        TextField("Teléfono", text: $telefono)
                            .padding()
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            .foregroundColor(.black)
                        
                        TextField("CURP", text: $curp)
                            .padding()
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            .foregroundColor(.black)
                        
                        
                        // Selector de imagen para INE
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            HStack {
                                Image(systemName: "photo.on.rectangle")
                                Text("Adjuntar foto de INE")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .onChange(of: selectedItem) {
                            guard let selectedItem else { return }
                            Task {
                                if let data = try? await selectedItem.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    selectedImage = Image(uiImage: uiImage)
                                }
                            }
                        }
                        
                        
                        // Vista previa de la imagen seleccionada
                        if let image = selectedImage {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        }
                        
                        // Aviso de privacidad
                        Text("⚠️ Al enviar tus datos, aceptas el aviso de privacidad. Tu información será protegida y utilizada solo para fines de verificación.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 10)
                        
                        // Botón de envío
                        
                        VStack {
                            Button(action: {
                                formEnviado = true
                            }) {
                                Text("Enviar")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                            
                            Spacer()
                            
                            // NavigationLink oculto que se activa al cerrar la alerta
                            NavigationLink(destination: SatRegistroView(), isActive: $navegar) {
                                EmptyView()
                            }
                        }
                        .padding()
                        .alert(isPresented: $formEnviado) {
                            Alert(
                                title: Text("Formulario Enviado"),
                                message: Text("Gracias por enviar el formulario"),
                                dismissButton: .default(Text("OK")) {
                                    // Cuando se cierra la alerta, activamos la navegación
                                    navegar = true
                                }
                            )
                        }
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
    
    struct SimpleFormView_Previews: PreviewProvider {
        static var previews: some View {
            SimpleFormView()
        }
    }
}
