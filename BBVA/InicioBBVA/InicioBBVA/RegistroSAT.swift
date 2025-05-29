import SwiftUI

struct SatRegistroView: View {
    @State private var opcion1 = false
    @State private var opcion2 = false
    @State private var opcion3 = false
    @State private var opcion4 = false

    var body: some View {
        ZStack {
            // Fondo azul marino oscuro
            Color(red: 7/255, green: 33/255, blue: 70/255)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 20) {
                Text("¿Estás registrado ante el SAT?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                Group {
                    Toggle("No", isOn: $opcion1)
                    Toggle("Si", isOn: $opcion2)

                }
                .toggleStyle(CheckboxToggleStyle())
                .foregroundColor(.white)
                
                Text("Ver tutorial para registrarte paso a paso")
                
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                    
                Spacer()
                
                    

                HStack{
                    NavigationLink(destination: NegocioFormView()) {
                                Text("Continuar")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1.0))))
                
            }
            
            .navigationBarHidden(true)
        }
            }
            .padding()
        }
    }
}

// Estilo de checkbox personalizado
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .white)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SatRegistroView_PreViews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SatRegistroView()
        }
    }
}


