import Foundation

public struct PlanetOnboardingBuilder {
    
    public static func buildOnboarding(
        configs: [PlanetConfig],
        completeAction: @escaping () -> Void
    ) -> PlanetOnboardingView {
        let viewModel = PlanetOnboardingView.ViewModel(pages: producePlanetPages(fromConfigs: configs))
        return PlanetOnboardingView(viewModel: viewModel, completeAction: completeAction)
    }
    
    static func producePlanetPages(fromConfigs configs: [PlanetConfig]) -> [PlanetOnboardingView.PlanetPage] {
        configs.enumerated()
            .map { index, config in
                .init(
                    backgroundColor: config.backgroundColor,
                    title: config.title,
                    satelliteConfig: SatelliteConfigProducer().produce(
                        for: config,
                        index: index,
                        totalCount: configs.count
                    )
                )
            }
    }
}
