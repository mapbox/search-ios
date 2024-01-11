@testable import MapboxSearch

class ServiceProviderStub: ServiceProviderProtocol, EngineProviderProtocol {
    func getStoredAccessToken() -> String? {
        "mapbox-access-token"
    }

    lazy var dataLayerProviders: [IndexableDataProvider] = [localFavoritesProvider, localHistoryProvider]

    let localFavoritesProvider = LocalDataProvider<FavoriteRecord>()
    let localHistoryProvider = LocalDataProvider<HistoryRecord>()
    lazy var eventsManager = EventsManager()
    lazy var feedbackManager = FeedbackManager(eventsManager: eventsManager)

    var latestCoreEngine: CoreSearchEngineStub!

    func createEngine(apiType: CoreSearchEngine.ApiType, locationProvider: CoreLocationProvider?) -> CoreSearchEngineProtocol {
        let locationProvider: CoreLocationProvider? = WrapperLocationProvider(wrapping: DefaultLocationProvider())
        latestCoreEngine = CoreSearchEngineStub(location: locationProvider)
        return latestCoreEngine
    }
}
