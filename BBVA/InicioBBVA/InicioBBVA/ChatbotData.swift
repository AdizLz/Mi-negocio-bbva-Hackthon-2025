//
//  ChatbotData.swift
//  Asistente Virtual
//
//  Created by Asenet on 13/05/25.
//

import Foundation

struct ChatbotData: Codable {
    let bienvenida: Bienvenida
    let intenciones: [String: Intencion]
    let respuestas_generales: RespuestasGenerales
    let calculos_rapidos: [String: CalculoRapido]
    let tamanio_empresa: TamanioEmpresa
}

// MARK: - Bienvenida
struct Bienvenida: Codable {
    let mensaje: String
    let opciones: [String]
}

// MARK: - Intenciones
struct Intencion: Codable {
    let palabras_clave: [String]
    let respuesta: String
    let opciones: [String: Subintencion]?
}

struct Subintencion: Codable {
    let palabras_clave: [String]
    let respuesta: String
}

// MARK: - Respuestas Generales
struct RespuestasGenerales: Codable {
    let no_entiendo: String
    let presupuesto_bajo: String
    let consejos_generales: [String]
}

// MARK: - Cálculos Rápidos
struct CalculoRapido: Codable {
    let formula: String
    let ejemplo: String
}

// MARK: - Tamaño Empresa (Simulación de IA)
struct TamanioEmpresa: Codable {
    let mensaje_inicial: String
    let preguntas: [Pregunta]
    let clasificaciones: [ClasificacionEmpresa]
    let beneficios: [String: [String]]
    let mensaje_final: String
}

struct Pregunta: Codable {
    let texto: String
    let tipo: String  // Ej: "numero", "texto"
}

struct ClasificacionEmpresa: Codable {
    let tipo: String               // Ej: "Microempresa"
    let empleados_max: Int        // Ej: 10
    let ingresos_max: Double      // Ej: 5.0 (millones)
}
