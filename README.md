# SwiftUI Fun

## Planet Onboarding

Simple full-screen onboarding view requiring no assets at all.

![planetOnboardingDemo](https://github.com/mbieda/swiftui-fun/assets/1736293/2a582c12-7d5c-4056-a195-88e40e62b08e)

### Installation

Add `SwiftUIFun` as an SPM dependency to your project.

### Integration

1. Define list of onboarding pages building a list of `PlanetConfig`, eg.

```
let configs: [PlanetConfig] = [
  .init(
    backgroundColor: .onPink,
    title: "Find your obsession",
    satelliteColor: .onDarkBlue
  ),
  .init(
    backgroundColor: .onLightBlue,
    title: "Design daily schedule",
    satelliteColor: .onDarkBlue
  ),
  .init(
    backgroundColor: .onBlue,
    title: "Execute despite pain",
     satelliteColor: .onDarkBlue
  )
]
```

2. Build `PlanetOnboardingView` using the builder:

```
PlanetOnboardingBuilder.buildOnboarding(
  configs: configs,
  completeAction: {
    // handle completing the onboarding
  }
)
```

You can also have a look at the Examples section in the repo for a real-life example.
