//
//  Inicio.swift
//  InicioBBVA
//
//  Created by Damaris B on 13/05/25.
//

import SwiftUI
import UIKit


struct Inicio: View {
    @State private var selectedTab = 0
    @State private var selectedTransactionFilter = 0
    
    let transactionFilters = ["All", "Income", "Expense"]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Status Bar + Header
                headerView()
                
                // Main Content
                ScrollView {
                    VStack(spacing: 20) {
                        // Quick Actions
                        quickActionsView()
                        
                        // Transactions Section
                        transactionsView()
                    }
                    .padding(.bottom, 80)
                }
                
                Spacer()
            }
            
            // Tab Bar
            VStack {
                Spacer()
                tabBarView()
            }
        }
    }
    
    // Header with balance info
    func headerView() -> some View {
        VStack(spacing: 0) {
            // Status Bar
            
            
            // Balance Section
            ZStack {
                Color(hex: "072146")
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing:40) {
                        Text("$2,589.50")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        HStack(spacing: 20) {
                            Button(action: {}) {
                                Image(systemName: "bell")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                            
                            
                        }
                    }
                    
                    Text("Balance Disponible, revisalo ahora!")
                        .font(.system(size: 16))
                        .foregroundColor(Color.white.opacity(0.8))
                        
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                .offset(y: -30) //PONERIMAGENEDEGRAFICO
            }
            
            Image("grafica")
                .resizable()
                .padding(.bottom)
                .offset(y: -30)
                
        }
    }
    
    func quickActionsView() -> some View {
        HStack{
            NavigationLink(destination: BusinessQRView()){
                quickActionButton(icon: "arrow.up", label: "Enviar")
            }
            
            quickActionButton(icon: "arrow.down", label: "Recibir")
            
            NavigationLink(destination: BusinessQRView()){
                quickActionButton(icon: "percent", label: "Cargos")
            }
           
            
            // NavigationLink a MapaPapeleria
            NavigationLink(destination: MapaPapeleriasBBVA()) {
                quickActionButton(icon: "map", label: "Zonas")
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(Color(hex: "072146"))
    }
    
    // Individual Quick Action Button
    func quickActionButton(icon: String, label: String) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 56, height: 56)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
            }
            
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
    
    // Transactions Section
    func transactionsView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
                
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Text("Transacciones Recientes")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Ver todas...")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Filter Options
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<transactionFilters.count, id: \.self) { index in
                                filterButton(
                                    title: transactionFilters[index],
                                    icon: index == 1 ? "arrow.down" : (index == 2 ? "arrow.up" : nil),
                                    isSelected: selectedTransactionFilter == index,
                                    iconColor: index == 1 ? .green : (index == 2 ? .red : .blue),
                                    action: {
                                        selectedTransactionFilter = index
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Transactions List
                    VStack(alignment: .leading, spacing: 20) {
                        // Today Section
                        Text("HOY")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.gray)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            // Grocery Transaction
                            transactionRow(
                                icon: "person.and.background.dotted",
                                category: "Proveedores",
                                description: "Ubicación...",
                                amount: "-$500.5",
                                date: "Mayo 11",
                                isNegative: true
                            )
                            
                            Divider()
                                .padding(.horizontal, 20)
                            
                            // Transport Transaction
                            transactionRow(
                                icon: "car.fill",
                                category: "Transporte",
                                description: "UBER ...",
                                amount: "-$36.0",
                                date: "Mayo 10",
                                isNegative: true
                            )
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        
                        // Yesterday Section
                        Text("ANTERIOR")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.gray)
                            .padding(.horizontal, 20)
                        
                        // Payment Transaction
                        transactionRow(
                            icon: "creditcard.fill",
                            category: "Recibido",
                            description: "Pago por...",
                            amount: "+$650.00",
                            date: "Mayo 12",
                            isNegative: false
                        )
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    // Filter Button
    func filterButton(title: String, icon: String?, isSelected: Bool, iconColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 14))
                        .foregroundColor(isSelected ? .white : iconColor)
                }
                
                Text(title)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? .white : .gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color(red: 0.2, green: 0.4, blue: 0.8) : Color(UIColor.systemGray6))
            .cornerRadius(20)
        }
    }
    
    // Transaction Row
    func transactionRow(icon: String, category: String, description: String, amount: String, date: String, isNegative: Bool) -> some View {
        HStack(spacing: 15) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color(red: 0.9, green: 0.95, blue: 1.0))
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
            }
            
            // Details
            VStack(alignment: .leading, spacing: 4) {
                Text(category)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Amount & Date
            VStack(alignment: .trailing, spacing: 4) {
                Text(amount)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isNegative ? .red : .green)
                
                Text(date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
    }
    
    // Tab Bar View
    func tabBarView() -> some View {
        HStack(spacing: 0) {
            tabBarButton(image: "house.fill", title: "Home", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            
            tabBarButton(image: "dollarsign.square", title: "Historial", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            
            // Center Button
            NavigationLink(destination: ChatbotView()) {
                ZStack {
                    Circle()
                        .fill(Color(hex: "072146"))
                        .frame(width: 60, height: 60)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                    
                    Image(systemName: "ellipsis.message.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                
            }
            
            NavigationLink(destination: ContentView()){
                tabBarButton(image: "creditcard", title: "Tarjetas", isSelected: selectedTab == 3) {
                    selectedTab = 3
                }
            }

           
            
            tabBarButton(image: "person", title: "Perfil", isSelected: selectedTab == 4) {
                selectedTab = 4
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.white)
        .clipShape(RoundedCornerShape(radius: 25, corners: [.topLeft, .topRight]))
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
    }
    
    // Tab Bar Button
    func tabBarButton(image: String, title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? Color(red: 0.2, green: 0.4, blue: 0.8) : Color.gray)
                
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(isSelected ? Color(red: 0.2, green: 0.4, blue: 0.8) : Color.gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// Custom shape to round specific corners


struct Inicio_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Inicio()
        }
    }
}
