import SwiftUI

public struct PlanetOnboardingView: View {
    
    enum CompleteButtonPadding: CGFloat {
        case visible = 45
        case invisible = -80
    }
    
    @State private var viewModel: ViewModel
    private let completeAction: () -> Void
    
    @State private var swipeProgress: CGFloat = 0.0
    @State private var swipeSlowlyProgressingProgress: CGFloat = 0.0
    @State private var swipeComplete = false
    @State private var nextPageIndexToBe: Int = 0
    @State private var completeButtonBottomPadding: CGFloat = CompleteButtonPadding.invisible.rawValue
    @State private var planetViewScale = 1.0
    
    private let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    init(viewModel: ViewModel, completeAction: @escaping () -> Void) {
        self._viewModel = State(wrappedValue: viewModel)
        self.completeAction = completeAction
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundColor
                
                VStack {
                    Spacer()
                    Spacer()
                    
                    planetView
                    .scaleEffect(planetViewScale)
                    
                    Spacer()
                    
                    Text(viewModel.currentPage.title)
                        .font(.title)
                        .foregroundColor(.justWhite)
                    
                    Spacer()
                    
                    dotsView
                        .padding(.bottom, hasNotch ? bottomInset : 20)
                        .isHidden(swipeComplete)
                }
                .padding()
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        withAnimation(Animation.ripple()) {
                            completeButtonBottomPadding = CompleteButtonPadding.invisible.rawValue
                            planetViewScale = 0.1
                        } completion: {
                            completeAction()
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.justPrimary)
                                .shadow(color: .justWhite, radius: 10, y: 5)
                            Text("Complete")
                                .font(.title3)
                                .foregroundColor(.justWhite)
                        }
                        .frame(height: 50)
                    })
                    .padding(.horizontal, 24)
                    .padding(.bottom, completeButtonBottomPadding)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onChanged { value in
                    guard !swipeComplete else { return }
                    swipeProgress = value.translation.width / (geo.size.width / 2.0)
                    swipeSlowlyProgressingProgress = swipeProgress
                }
                .onEnded { value in
                    guard !swipeComplete else { return }
                    let horizontalAmount = value.translation.width
                    if horizontalAmount > 0.33 * geo.size.width {
                        if let previousPageIndex = viewModel.previousPageIndex {
                            nextPageIndexToBe = previousPageIndex
                            withAnimation {
                                viewModel.currentPageIndex = previousPageIndex
                            }
                        }
                    } else if horizontalAmount < -0.33 * geo.size.width {
                        if let nextPageIndex = viewModel.nextPageIndex {
                            nextPageIndexToBe = nextPageIndex
                            withAnimation {
                                viewModel.currentPageIndex = nextPageIndex
                            }
                        } else {
                            swipeComplete = true
                            timer.upstream.connect().cancel()
                            withAnimation(Animation.ripple()) {
                                completeButtonBottomPadding = CompleteButtonPadding.visible.rawValue
                            }
                        }
                    }
                    swipeProgress = 0
                })
            .onReceive(timer, perform: { _ in
                if swipeSlowlyProgressingProgress < swipeProgress - 0.05 {
                    swipeSlowlyProgressingProgress += 0.05
                } else if swipeSlowlyProgressingProgress < swipeProgress {
                    swipeSlowlyProgressingProgress = swipeProgress
                } else if swipeSlowlyProgressingProgress > swipeProgress + 0.05 {
                    swipeSlowlyProgressingProgress -= 0.05
                } else if swipeSlowlyProgressingProgress > swipeProgress {
                    swipeSlowlyProgressingProgress = swipeProgress
                }
            })
        }
    }
    
    private var backgroundColor: some View {
        ZStack {
            viewModel.backgroundColor(for: nextPageIndexToBe)
            if let previousBackgroundColor = viewModel.previousBackgroundColor, swipeProgress > 0 {
                previousBackgroundColor.opacity(swipeProgress)
                viewModel.currentBackgroundColor.opacity(1 - swipeProgress)
                
            } else if let nextBackgroundColor = viewModel.nextBackgroundColor, swipeProgress < 0 {
                nextBackgroundColor.opacity(fabs(swipeProgress))
                viewModel.currentBackgroundColor.opacity(1 - fabs(swipeProgress))
            }
        }
    }
    
    private var planetView: some View {
        ZStack {
            ForEach(viewModel.pages, id: \.self) { page in
                SatelliteTrajectoryView(config: .init(fromConfig: page.satelliteConfig))
            }
            
            ForEach(viewModel.pages, id: \.self) { page in
                SatelliteView(
                    config: page.satelliteConfig,
                    percent: viewModel.percent(
                        for: page,
                        nextPageIndex: nextPageIndexToBe,
                        duringSwipe: (swipeSlowlyProgressingProgress != swipeProgress),
                        swipeProgress: swipeSlowlyProgressingProgress,
                        swipeComplete: swipeComplete
                    )
                )
            }
                
            Circle()
                .fill(Color.justWhite)
                .frame(width: 60)
                .shadow(color: .justWhite, radius: 10, y: 5)
        }
    }
    
    private var dotsView: some View {
        HStack {
            ForEach(Array(viewModel.pages.enumerated()), id: \.element) { index, page in
                Circle()
                    .foregroundColor(index == viewModel.currentPageIndex ? .justWhite : .justBlack.opacity(0.5))
            }
            
            Group {
                ArrowView(color: .justBlack, height: 12)
                ArrowView(color: .justBlack, height: 12)
                ArrowView(color: .justBlack, height: 12)
            }
            .frame(width: 1)
            .opacity(swipeComplete ? 1.0 : 0.5)
        }
        .frame(height: 12)
    }
}

#Preview {
    PlanetOnboardingBuilder.buildOnboarding(
        configs: [
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
        ],
        completeAction: {}
    )
}
