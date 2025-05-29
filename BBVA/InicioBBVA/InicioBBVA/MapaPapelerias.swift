//
//  Análisis de Zonas para Papelerías BBVA
//
//  Created on 13/05/25.
//

import SwiftUI
import MapKit

// Estructura para los puntos de análisis
struct AnalysisPoint: Identifiable, Hashable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let opportunityLevel: OpportunityLevel
    let name: String
    let details: ZoneDetails
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AnalysisPoint, rhs: AnalysisPoint) -> Bool {
        lhs.id == rhs.id
    }
}

// Niveles de oportunidad
enum OpportunityLevel {
    case high    // Rojo - Alta oportunidad
    case medium  // Amarillo - Oportunidad media
    case low     // Verde - Baja oportunidad
    
    var color: Color {
        switch self {
        case .high: return Color.red
        case .medium: return Color.orange
        case .low: return Color.green
        }
    }
    
    var description: String {
        switch self {
        case .high: return "Alta oportunidad"
        case .medium: return "Oportunidad media"
        case .low: return "Baja oportunidad"
        }
    }
}

// Detalles de cada zona
struct ZoneDetails {
    let personDensity: String
    let nearbyCompetitors: Int
    let zoneType: String
    let demandLevel: String
}

struct MapaPapeleriasBBVA: View {
    // Colores BBVA
    let bbvaBlue = Color(red: 0.0, green: 0.35, blue: 0.63)
    
    // Estados principales
    @State private var cameraPosition: MapCameraPosition = .region(.cuceaRegion)
    @State private var selectedPoint: AnalysisPoint?
    @State private var showingDetails = false
    @State private var selectedFilter: BusinessFilter = .all
    
    // Puntos de análisis
    let analysisPoints: [AnalysisPoint] = [
        // Alta oportunidad - cerca de la universidad
        AnalysisPoint(
            coordinate: CLLocationCoordinate2D(latitude: 20.7406, longitude: -103.3815),
            opportunityLevel: .high,
            name: "Entrada Principal CUCEA",
            details: ZoneDetails(
                personDensity: "Muy alta (5000+ estudiantes/día)",
                nearbyCompetitors: 1,
                zoneType: "Zona universitaria - Entrada principal",
                demandLevel: "Muy alto"
            )
        ),
        
        AnalysisPoint(
            coordinate: CLLocationCoordinate2D(latitude: 20.7415, longitude: -103.3820),
            opportunityLevel: .high,
            name: "Zona de Bibliotecas",
            details: ZoneDetails(
                personDensity: "Alta (3000+ estudiantes/día)",
                nearbyCompetitors: 0,
                zoneType: "Área académica - Bibliotecas",
                demandLevel: "Alto"
            )
        ),
        
        // Oportunidad media
        AnalysisPoint(
            coordinate: CLLocationCoordinate2D(latitude: 20.7395, longitude: -103.3810),
            opportunityLevel: .medium,
            name: "Cafeterías CUCEA",
            details: ZoneDetails(
                personDensity: "Media (2000 estudiantes/día)",
                nearbyCompetitors: 2,
                zoneType: "Zona de comida",
                demandLevel: "Moderado"
            )
        ),
        
        AnalysisPoint(
            coordinate: CLLocationCoordinate2D(latitude: 20.7420, longitude: -103.3805),
            opportunityLevel: .medium,
            name: "Estacionamiento Norte",
            details: ZoneDetails(
                personDensity: "Media (1500 personas/día)",
                nearbyCompetitors: 1,
                zoneType: "Zona de tránsito",
                demandLevel: "Moderado"
            )
        ),
        
        // Baja oportunidad
        AnalysisPoint(
            coordinate: CLLocationCoordinate2D(latitude: 20.7385, longitude: -103.3825),
            opportunityLevel: .low,
            name: "Zona Administrativa",
            details: ZoneDetails(
                personDensity: "Baja (500 personas/día)",
                nearbyCompetitors: 3,
                zoneType: "Oficinas administrativas",
                demandLevel: "Bajo"
            )
        ),
        
        AnalysisPoint(
            coordinate: CLLocationCoordinate2D(latitude: 20.7430, longitude: -103.3795),
            opportunityLevel: .low,
            name: "Plaza Comercial Externa",
            details: ZoneDetails(
                personDensity: "Variable",
                nearbyCompetitors: 4,
                zoneType: "Zona comercial saturada",
                demandLevel: "Bajo para papelerías"
            )
        )
    ]
    
    var filteredPoints: [AnalysisPoint] {
        switch selectedFilter {
        case .all:
            return analysisPoints
        case .papelerias:
            return analysisPoints.filter { $0.opportunityLevel == .high || $0.opportunityLevel == .medium }
        case .competencia:
            return analysisPoints.filter { $0.details.nearbyCompetitors > 0 }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header BBVA más pequeño
               
                
                // Leyenda del mapa
               


                // Mapa con controles de zoom
                ZStack(alignment: .bottomTrailing) {
                    Map(position: $cameraPosition, selection: $selectedPoint) {
                        // Marcador de CUCEA
                        Annotation("CUCEA", coordinate: .cuceaLocation) {
                            Image(systemName: "building.columns.fill")
                                .font(.title)
                                .foregroundStyle(bbvaBlue)
                                .background(Circle().fill(.white).shadow(radius: 2))
                        }
                        
                        // Puntos de análisis
                        ForEach(filteredPoints) { point in
                            Annotation(point.name, coordinate: point.coordinate) {
                                VStack(spacing: 0) {
                                    Circle()
                                        .fill(point.opportunityLevel.color)
                                        .frame(width: 24, height: 24)
                                        .shadow(radius: 2)
                                    
                                    Image(systemName: "triangle.fill")
                                        .font(.caption)
                                        .foregroundStyle(point.opportunityLevel.color)
                                        .rotationEffect(.degrees(180))
                                        .offset(y: -5)
                                }
                            }
                            .tag(point)
                        }
                        
                        // Círculo de influencia
                        MapCircle(center: .cuceaLocation, radius: 1000)
                            .foregroundStyle(bbvaBlue.opacity(0.1))
                            .stroke(bbvaBlue.opacity(0.3), lineWidth: 2)
                    }
                    .mapStyle(.standard)
                    
                    // Botones de zoom
                    VStack(spacing: 12) {
                        Button(action: {
                            withAnimation {
                                zoomIn()
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: 44, height: 44)
                        .background(bbvaBlue)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        
                        Button(action: {
                            withAnimation {
                                zoomOut()
                            }
                        }) {
                            Image(systemName: "minus")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: 44, height: 44)
                        .background(bbvaBlue)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 100)
                }
                
                // Controles
                VStack(spacing: 16) {
                    // Leyenda
                    HStack(spacing: 16) {
                        ForEach([OpportunityLevel.high, .medium, .low], id: \.self) { level in
                            LegendItem(level: level)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    // Filtros
                    Picker("Filtro", selection: $selectedFilter) {
                        Text("Todas").tag(BusinessFilter.all)
                        Text("Mejores ubicaciones").tag(BusinessFilter.papelerias)
                        Text("Con competencia").tag(BusinessFilter.competencia)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .background(Color(UIColor.systemBackground))
            }
            .sheet(isPresented: $showingDetails) {
                InfoView(bbvaBlue: bbvaBlue)
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Acción para el botón de atrás
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.title3)
                            Text("Atrás")
                                .font(.body)
                        }
                        .foregroundStyle(bbvaBlue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingDetails = true }) {
                        Image(systemName: "info.circle")
                            .foregroundStyle(bbvaBlue)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if let selectedPoint {
                    ZoneDetailView(point: selectedPoint, bbvaBlue: bbvaBlue) {
                        withAnimation {
                            self.selectedPoint = nil
                        }
                    }
                }
            }
        }
    }
    
    // Función para hacer zoom in
    private func zoomIn() {
        withAnimation {
            let currentRegion = MKCoordinateRegion(
                center: .cuceaLocation,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.008 * 0.7,
                    longitudeDelta: 0.008 * 0.7
                )
            )
            cameraPosition = .region(currentRegion)
        }
    }
    
    // Función para hacer zoom out
    private func zoomOut() {
        withAnimation {
            let currentRegion = MKCoordinateRegion(
                center: .cuceaLocation,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.008 * 1.4,
                    longitudeDelta: 0.008 * 1.4
                )
            )
            cameraPosition = .region(currentRegion)
        }
    }
}

// Vista de cabecera BBVA más pequeña


// Elemento de leyenda
struct LegendItem: View {
    let level: OpportunityLevel
    
    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(level.color)
                .frame(width: 10, height: 10)
            Text(level.description)
                .font(.caption)
        }
    }
}

// Vista de detalles de la zona
struct ZoneDetailView: View {
    let point: AnalysisPoint
    let bbvaBlue: Color
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(point.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(bbvaBlue)
                    
                    HStack {
                        Circle()
                            .fill(point.opportunityLevel.color)
                            .frame(width: 10, height: 10)
                        Text(point.opportunityLevel.description)
                            .font(.subheadline)
                    }
                }
                
                Spacer()
                
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                DetailRow(title: "Densidad de personas", value: point.details.personDensity, icon: "person.3.fill")
                DetailRow(title: "Competidores cercanos", value: "\(point.details.nearbyCompetitors) papelerías", icon: "building.2.crop.circle")
                DetailRow(title: "Tipo de zona", value: point.details.zoneType, icon: "map.fill")
                DetailRow(title: "Nivel de demanda", value: point.details.demandLevel, icon: "chart.line.uptrend.xyaxis")
            }
            
            Button("Solicitar financiamiento BBVA") {
                // Acción para financiamiento
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(bbvaBlue)
            .cornerRadius(8)
            .padding(.top, 8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

// Fila de detalle
struct DetailRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.blue)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

// Vista de información
struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    let bbvaBlue: Color
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Análisis de Zonas para Papelerías")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(bbvaBlue)
                
                Text("Esta herramienta de BBVA te ayuda a identificar las mejores ubicaciones para abrir una papelería cerca del CUCEA.")
                    .foregroundStyle(.secondary)
                
                VStack(alignment: .leading, spacing: 16) {
                    InfoSection(color: .red, title: "Alta Oportunidad", description: "Zonas con alta demanda y poca competencia. Ideal para nuevos negocios.")
                    InfoSection(color: .orange, title: "Oportunidad Media", description: "Zonas con demanda moderada. Requiere diferenciación.")
                    InfoSection(color: .green, title: "Baja Oportunidad", description: "Zonas saturadas o con baja demanda. No recomendado.")
                }
                
                Spacer()
                
                Button("Contactar a un asesor BBVA") {
                    // Acción de contacto
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(bbvaBlue)
                .cornerRadius(8)
            }
            .padding()
            .navigationTitle("Información")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Sección de información
struct InfoSection: View {
    let color: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(color)
                .frame(width: 16, height: 16)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
    }
}

// Filtros de negocio
enum BusinessFilter {
    case all
    case papelerias
    case competencia
}

// Extensiones
extension CLLocationCoordinate2D {
    static var cuceaLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 20.7407, longitude: -103.3813)
    }
}

extension MKCoordinateRegion {
    static var cuceaRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: .cuceaLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        )
    }
}



struct MapaPapelerias_Views: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MapaPapeleriasBBVA()
        }
    }
}

//  MapaPapelerias.swift
//  InicioBBVA
//
//  Created by Asenet on 13/05/25.
//

