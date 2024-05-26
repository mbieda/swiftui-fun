import SwiftUI

struct MainView: View {
    
    @State private var openOnboarding = false
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 30) {
                Text("Hello, test app")
                
                Button(action: {
                    path.append("Onboarding")
                }, label: {
                    Text("Push Onboarding")
                })
                
                Button(action: {
                    openOnboarding = true
                }, label: {
                    Text("Present Onboarding")
                })
            }
            .navigationDestination(for: String.self) { _ in
                PlanetOnboardingBuilder.buildOnboarding(
                    configs: Constants.planetConfigs,
                    completeAction: {
                        path.removeLast()
                    }
                )
                .navigationBarBackButtonHidden()
            }
        }
        .fullScreenCover(isPresented: $openOnboarding, content: {
            PlanetOnboardingBuilder.buildOnboarding(
                configs: Constants.planetConfigs,
                completeAction: {
                    openOnboarding = false
                }
            )
        })
    }
}

#Preview {
    MainView()
}
