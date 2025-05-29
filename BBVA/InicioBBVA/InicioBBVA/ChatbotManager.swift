import Foundation
import SwiftUI

struct EstadoTamanioEmpresa {
    var pasoActual: Int = 0
    var empleados: Int?
    var ingresos: Double?
}

class ChatbotManager: ObservableObject {
    var data: ChatbotData?
    @Published var estadoTamanioEmpresa: EstadoTamanioEmpresa?

    init() {
        loadData()
    }

    private func loadData() {
        if let url = Bundle.main.url(forResource: "datoschatbot", withExtension: "json"),
           let jsonData = try? Data(contentsOf: url) {
            do {
                data = try JSONDecoder().decode(ChatbotData.self, from: jsonData)
            } catch {
                print("❌ Error al decodificar JSON: \(error)")
            }
        }
    }

    func responder(a mensaje: String) -> String {
        guard let data = data else { return "Lo siento, no tengo datos cargados." }

        // Flujo activo de tamaño de empresa
        if var estado = estadoTamanioEmpresa {
            let preguntas = data.tamanio_empresa.preguntas

            switch estado.pasoActual {
            case 0:
                if let empleados = Int(mensaje.trimmingCharacters(in: .whitespaces)) {
                    estado.empleados = empleados
                    estado.pasoActual += 1
                    estadoTamanioEmpresa = estado
                    return preguntas[1].texto
                } else {
                    return "Por favor, indícame un número válido de empleados."
                }

            case 1:
                let limpio = mensaje.replacingOccurrences(of: ",", with: ".")
                if let ingresos = Double(limpio) {
                    estado.ingresos = ingresos
                    estadoTamanioEmpresa = nil

                    let clasificacion = data.tamanio_empresa.clasificaciones.first {
                        (estado.empleados ?? 0) <= $0.empleados_max && ingresos <= $0.ingresos_max
                    } ?? data.tamanio_empresa.clasificaciones.last!

                    let beneficios = data.tamanio_empresa.beneficios[clasificacion.tipo] ?? []

                    var respuesta = "Tu empresa es **\(clasificacion.tipo)**.\n\nPuedes acceder a beneficios como:\n"
                    for beneficio in beneficios {
                        respuesta += "- \(beneficio)\n"
                    }
                    respuesta += "\n" + data.tamanio_empresa.mensaje_final
                    return respuesta
                } else {
                    return "Ingresa un número válido para los ingresos (ej. 3.2)"
                }

            default:
                estadoTamanioEmpresa = nil
                return "¿Quieres volver a calcular el tamaño de tu empresa? Solo dime algo como 'calcular tamaño'."
            }
        }

        // Activación por palabras clave (flexible)
        let clavesTamanio = ["tamaño", "empresa", "categoría", "tipo", "clasificación", "empleados", "ingresos"]
        if clavesTamanio.contains(where: { mensaje.lowercased().contains($0) }) {
            estadoTamanioEmpresa = EstadoTamanioEmpresa()
            return data.tamanio_empresa.mensaje_inicial
        }

        // Intenciones normales
        for (_, intencion) in data.intenciones {
            if intencion.palabras_clave.contains(where: { mensaje.lowercased().contains($0) }) {
                if let subintenciones = intencion.opciones {
                    for (_, sub) in subintenciones {
                        if sub.palabras_clave.contains(where: { mensaje.lowercased().contains($0) }) {
                            return sub.respuesta
                        }
                    }
                }
                return intencion.respuesta
            }
        }

        // Sin coincidencias
        return data.respuestas_generales.no_entiendo
    }
}
