//
//  ContentView.swift
//  InicioBBVA
//
//  Created by Damaris B on 13/05/25.
//

import SwiftUI

struct CardWalletApp: App {
    var body: some Scene {
        WindowGroup {
            Register()
        }
    }
}

struct ContentView: View {
    @State private var selectedCardIndex = 0
    @State private var selectedTab = 2
    @State private var contactlessPaymentEnabled = true
    @State private var onlinePaymentEnabled = false
    @State private var atmWithdrawsEnabled = true
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Status Bar
                StatusBarView()
                
                // Main Content
                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        HeaderView()
                        
                        // Card Type Selector
                        CardTypeSelectorView()
                        
                        // Cards Carousel
                        CardsCarouselView(selectedCardIndex: $selectedCardIndex)
                        
                        // Card Settings
                        CardSettingsView(
                            contactlessPaymentEnabled: $contactlessPaymentEnabled,
                            onlinePaymentEnabled: $onlinePaymentEnabled,
                            atmWithdrawsEnabled: $atmWithdrawsEnabled
                        )
                    }
                    .padding(.bottom, 80)
                }
                
                Spacer()
            }
            
            // Tab Bar
            VStack {
                Spacer()
                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

// Status Bar View
struct StatusBarView: View {
    var body: some View {
        
    }
}

// Header View
struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Tus Tarjetas")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(red: 0.13, green: 0.23, blue: 0.45))
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 24))
                        .foregroundColor(Color(red: 0.13, green: 0.23, blue: 0.45))
                }
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// Card Type Selector View
struct CardTypeSelectorView: View {
    var body: some View {
        HStack(spacing: 15) {
            Button(action: {}) {
                Text("Tarjeta Fisica")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.13, green: 0.23, blue: 0.45))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
            }
            
            Button(action: {}) {
                Text("Tarjeta Virtual")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.gray)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

// Card View
struct CardView: View {
    var isVisa: Bool = true
    var cardNumber: String = "**** **** **** 2864"
    var cardHolder: String = "Ahmad Fawaid"
    var expires: String = "08/22"
    var cvv: String = "826"
    var isSelected: Bool = true
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Card Background
            RoundedRectangle(cornerRadius: 16)
                .fill(isVisa ? Color(hex: "072146"): Color(red: 0.25, green: 0.49, blue: 0.65))
                .frame(width: 300, height: 180)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            
            // Card Content
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    // Selected indicator
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 26, height: 26)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    if isVisa {
                        Text("VISA")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    } else {
                        Text("MASTER")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                // Card Number
                Text(cardNumber)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                
                // Card Details
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CARD HOLDER")
                            .font(.system(size: 10))
                            .foregroundColor(Color.white.opacity(0.7))
                        
                        Text(cardHolder)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("EXPIRES")
                            .font(.system(size: 10))
                            .foregroundColor(Color.white.opacity(0.7))
                        
                        Text(expires)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CVV")
                            .font(.system(size: 10))
                            .foregroundColor(Color.white.opacity(0.7))
                        
                        Text(cvv)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(20)
            .frame(width: 300, height: 180)
        }
    }
}

// Cards Carousel View
struct CardsCarouselView: View {
    @Binding var selectedCardIndex: Int
    
    var body: some View {
        VStack(spacing: 15) {
            TabView(selection: $selectedCardIndex) {
                CardView(isVisa: true, cardNumber: "**** **** **** 2864", cardHolder: "Negocio...", expires: "08/35", cvv: "826")
                    .tag(0)
                
                CardView(isVisa: false, cardNumber: "**** **** **** 5321", cardHolder: "Ahmad Fawaid", expires: "10/25", cvv: "123")
                    .tag(1)
                
                CardView(isVisa: true, cardNumber: "**** **** **** 7890", cardHolder: "Ahmad Fawaid", expires: "03/24", cvv: "456")
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)
            
            // Page Indicator
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(selectedCardIndex == index ? Color(red: 0.13, green: 0.23, blue: 0.45) : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

// Card Settings View
struct CardSettingsView: View {
    @Binding var contactlessPaymentEnabled: Bool
    @Binding var onlinePaymentEnabled: Bool
    @Binding var atmWithdrawsEnabled: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Ajustes de Tarjeta")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.13, green: 0.23, blue: 0.45))
                .padding(.horizontal, 20)
            
            VStack(spacing: 15) {
                // Contactless Payment
                SettingToggleView(
                    icon: "wave.3.right.circle",
                    title: "Pago sin Contacto",
                    isEnabled: $contactlessPaymentEnabled
                )
                
                // Online Payment
                SettingToggleView(
                    icon: "iphone",
                    title: "Codigo de Pago",
                    isEnabled: $onlinePaymentEnabled
                )
                
                // ATM Withdraws
                SettingToggleView(
                    icon: "arrow.up.forward",
                    title: "Retiros",
                    isEnabled: $atmWithdrawsEnabled
                )
            }
        }
        .padding(.top, 20)
    }
}

// Setting Toggle View
struct SettingToggleView: View {
    var icon: String
    var title: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Color(red: 0.13, green: 0.23, blue: 0.45))
                .frame(width: 40)
            
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(red: 0.13, green: 0.23, blue: 0.45))
            
            Spacer()
            
            Toggle("", isOn: $isEnabled)
                .toggleStyle(SwitchToggleStyle(tint: Color.green))
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        .padding(.horizontal, 20)
    }
}

// Tab Bar View
struct TabBarView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(image: "house", title: "Home", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            
            TabBarButton(image: "clock.arrow.circlepath", title: "Historial", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            
            // Center Button
            ZStack {
                Circle()
                    .fill(Color(red: 0.22, green: 0.35, blue: 0.65))
                    .frame(width: 60, height: 60)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                
                Image(systemName: "ellipsis.message.fill")
                    .font(.system(size: 29, weight: .bold))
                    .foregroundColor(.white)
            }
            .offset(y: -10)
            
            TabBarButton(image: "creditcard", title: "Tarjetas", isSelected: selectedTab == 3) {
                selectedTab = 3
            }
            
            TabBarButton(image: "person", title: "Perfil", isSelected: selectedTab == 4) {
                selectedTab = 4
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(25, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
    }
}

// Tab Bar Button
struct TabBarButton: View {
    var image: String
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? Color(red: 0.22, green: 0.35, blue: 0.65) : Color.gray)
                
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(isSelected ? Color(red: 0.22, green: 0.35, blue: 0.65) : Color.gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// Extension to apply corner radius to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }
}

// Custom shape to round specific corners
struct RoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}
