import SwiftUI

struct ChatbotView: View {
    @State private var entradaUsuario = ""
    @State private var historialChat: [String] = []
    @ObservedObject var chatbot = ChatbotManager()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(historialChat, id: \.self) { mensaje in
                            HStack {
                                if mensaje.starts(with: "👤") {
                                    Spacer()
                                    Text(mensaje)
                                        .padding()
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(12)
                                        .frame(maxWidth: 250, alignment: .trailing)
                                } else {
                                    Text(mensaje)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(12)
                                        .frame(maxWidth: 250, alignment: .leading)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding()

                HStack {
                    TextField("Escribe una pregunta...", text: $entradaUsuario)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        enviarMensaje()
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .navigationTitle("Asistente BBVA")
        }
    }

    func enviarMensaje() {
        let mensaje = entradaUsuario.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !mensaje.isEmpty else { return }

        historialChat.append("👤 \(mensaje)")
        let respuesta = chatbot.responder(a: mensaje)
        historialChat.append("🤖 \(respuesta)")
        entradaUsuario = ""
    }
}
