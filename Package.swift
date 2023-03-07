// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

// News, Playlist (+JS), Onboarding, Browser (Favicons, Bookmarks, History, Passwords, Reader Mode, Settings, Sync),
// VPN, Rewards, Shields (Privacy, De-Amp, Downloaders, Content Blockers, ...), NTP, Networking,

var package = Package(
  name: "Brave",
  defaultLocalization: "en",
  platforms: [.iOS(.v15), .macOS(.v12)],
  products: [
    .library(name: "Brave", targets: ["Brave"]),
    .library(name: "Shared", targets: ["Shared"]),
    .library(name: "BraveCore", targets: ["BraveCore", "MaterialComponents"]),
    .library(name: "BraveShared", targets: ["BraveShared"]),
    .library(name: "BraveUI", targets: ["BraveUI"]),
    .library(name: "DesignSystem", targets: ["DesignSystem"]),
    .library(name: "BraveWallet", targets: ["BraveWallet"]),
    .library(name: "Data", targets: ["Data"]),
    .library(name: "Storage", targets: ["Storage", "sqlcipher"]),
    .library(name: "BrowserIntentsModels", targets: ["BrowserIntentsModels"]),
    .library(name: "BraveWidgetsModels", targets: ["BraveWidgetsModels"]),
    .library(name: "Strings", targets: ["Strings"]),
    .library(name: "BraveVPN", targets: ["BraveVPN"]),
    .library(name: "BraveNews", targets: ["BraveNews"]),
    .library(name: "Favicon", targets: ["Favicon"]),
    .library(name: "Onboarding", targets: ["Onboarding"]),
    .library(name: "Growth", targets: ["Growth"]),
    .library(name: "RuntimeWarnings", targets: ["RuntimeWarnings"]),
    .plugin(name: "IntentBuilderPlugin", targets: ["IntentBuilderPlugin"]),
    .plugin(name: "LoggerPlugin", targets: ["LoggerPlugin"])
  ],
  dependencies: [
    .package(url: "https://github.com/weichsel/ZIPFoundation", from: "0.9.15"),
    .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.1"),
    .package(url: "https://github.com/cezheng/Fuzi", from: "3.1.3"),
    .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", from: "5.0.0"),
    .package(url: "https://github.com/airbnb/lottie-ios", from: "3.1.9"),
    .package(url: "https://github.com/jrendel/SwiftKeychainWrapper", from: "4.0.1"),
    .package(url: "https://github.com/SDWebImage/SDWebImage", exact: "5.10.3"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSVGNativeCoder", from: "0.1.1"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", from: "2.2.0"),
    .package(url: "https://github.com/nmdias/FeedKit", from: "9.1.2"),
    .package(url: "https://github.com/brave/PanModal", revision: "e4c07f8e6c5df937051fabc47e1e92901e1d068b"),
    .package(url: "https://github.com/apple/swift-collections", from: "0.0.2"),
    .package(url: "https://github.com/siteline/SwiftUI-Introspect", from: "0.1.3"),
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    .package(url: "https://github.com/devxoul/Then", from: "2.7.0"),
    .package(url: "https://github.com/mkrd/Swift-BigInt", from: "2.0.0"),
    .package(url: "https://github.com/GuardianFirewall/GuardianConnect", exact: "1.7.2"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "0.6.0"),
    .package(name: "Static", path: "ThirdParty/Static"),
  ],
  targets: [
    .target(
      name: "Shared",
      dependencies: [
        "BraveCore",
        "MaterialComponents",
        "Strings",
        "SDWebImage",
        "SwiftKeychainWrapper",
        "SwiftyJSON",
      ],
      plugins: ["LoggerPlugin"]
    ),
    .target(
      name: "BraveShared",
      dependencies: ["SDWebImage", "Shared", "Strings", "SnapKit"],
      resources: [
        .copy("Certificates/AmazonRootCA1.cer"),
        .copy("Certificates/AmazonRootCA2.cer"),
        .copy("Certificates/AmazonRootCA3.cer"),
        .copy("Certificates/AmazonRootCA4.cer"),
        .copy("Certificates/GlobalSignRootCA_E46.cer"),
        .copy("Certificates/GlobalSignRootCA_R1.cer"),
        .copy("Certificates/GlobalSignRootCA_R3.cer"),
        .copy("Certificates/GlobalSignRootCA_R46.cer"),
        .copy("Certificates/GlobalSignRootCA_R5.cer"),
        .copy("Certificates/GlobalSignRootCA_R6.cer"),
        .copy("Certificates/ISRGRootCA_X1.cer"),
        .copy("Certificates/ISRGRootCA_X2.cer"),
        .copy("Certificates/SFSRootCAG2.cer"),
      ],
      plugins: ["LoggerPlugin"]
    ),
    .target(
      name: "Growth",
      dependencies: ["BraveVPN", "Shared", "BraveShared", "Strings", "SnapKit"],
      plugins: ["LoggerPlugin"]
    ),
    .target(
      name: "BraveUI",
      dependencies: [
        "BraveShared",
        "Strings",
        "DesignSystem",
        "PanModal",
        "SDWebImage",
        "SDWebImageSVGNativeCoder",
        "SnapKit",
        .product(name: "Introspect", package: "SwiftUI-Introspect"),
        "Then",
        "Static",
        .product(name: "Lottie", package: "lottie-ios")
      ],
      plugins: ["LoggerPlugin"]
    ),
    .target(name: "DesignSystem"),
    .binaryTarget(name: "BraveCore", path: "node_modules/brave-core-ios/BraveCore.xcframework"),
    .binaryTarget(name: "MaterialComponents", path: "node_modules/brave-core-ios/MaterialComponents.xcframework"),
    .binaryTarget(name: "sqlcipher", path: "ThirdParty/sqlcipher/sqlcipher.xcframework"),
    .binaryTarget(name: "GCDWebServers", path: "ThirdParty/GCDWebServers/GCDWebServers.xcframework"),
    .target(
      name: "Storage",
      dependencies: ["Shared", "sqlcipher", "SDWebImage"],
      cSettings: [.define("SQLITE_HAS_CODEC")],
      plugins: ["LoggerPlugin"]
    ),
    .target(
      name: "Data",
      dependencies: ["BraveShared", "Storage", "Strings"],
      plugins: ["LoggerPlugin"]
    ),
    .target(
      name: "BraveWallet",
      dependencies: [
        "Data",
        "BraveCore",
        "MaterialComponents",
        "BraveShared",
        "BraveUI",
        "DesignSystem",
        "Strings",
        "PanModal",
        "SDWebImage",
        "SDWebImageSwiftUI",
        "SnapKit",
        "Then",
        .product(name: "BigNumber", package: "Swift-BigInt"),
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "Collections", package: "swift-collections"),
      ],
      plugins: ["LoggerPlugin"]
    ),
    .target(
      name: "BrowserIntentsModels",
      sources: ["BrowserIntents.intentdefinition", "CustomIntentHandler.swift"],
      plugins: ["IntentBuilderPlugin"]
    ),
    .target(
      name: "BraveWidgetsModels",
      dependencies: ["Favicon"],
      sources: ["BraveWidgets.intentdefinition", "LockScreenFavoriteIntentHandler.swift", "FavoritesWidgetData.swift"],
      plugins: ["IntentBuilderPlugin", "LoggerPlugin"]
    ),
    .target(name: "BraveSharedTestUtils"),
    .target(name: "DataTestsUtils", dependencies: ["Data", "BraveShared"]),
    .target(
      name: "BraveVPN",
      dependencies: [
        "BraveShared",
        "Strings",
        "SnapKit",
        "Then",
        "Data",
        "GuardianConnect",
        "BraveUI",
        .product(name: "Lottie", package: "lottie-ios")
      ],
      resources: [.copy("vpncheckmark.json")],
      plugins: ["LoggerPlugin"]
    ),
    .target(
      name: "BraveNews",
      dependencies: [
        "BraveShared",
        "Strings",
        "SnapKit",
        "Then",
        "Data",
        "BraveUI",
        "DesignSystem",
        "CodableHelpers",
        "BraveCore",
        "MaterialComponents",
        "Static",
        "FeedKit",
        "Fuzi",
        "Growth",
        .product(name: "Lottie", package: "lottie-ios"),
        .product(name: "Collections", package: "swift-collections"),
      ],
      resources: [
        .copy("Lottie Assets/brave-today-welcome-graphic.json"),
      ],
      plugins: ["LoggerPlugin"]
    ),
    .target(
      name: "Onboarding",
      dependencies: [
        "BraveShared",
        "Strings",
        "SnapKit",
        "Then",
        "Data",
        "BraveUI",
        "DesignSystem",
        "BraveCore",
        "Fuzi",
        "Storage",
        "Growth",
        .product(name: "Lottie", package: "lottie-ios")
      ],
      resources: [
        .copy("LottieAssets/onboarding-ads.json"),
        .copy("LottieAssets/onboarding-rewards.json"),
        .copy("LottieAssets/onboarding-shields.json"),
        .copy("Welcome/Resources/disconnect-entitylist.json"),
        .copy("ProductNotifications/Resources/blocking-summary.json")
      ],
      plugins: ["LoggerPlugin"]
    ),
    .testTarget(name: "BraveNewsTests", dependencies: ["BraveNews"], resources: [
      .copy("opml-test-files/subscriptionList.opml"),
      .copy("opml-test-files/states.opml"),
    ]),
    .target(name: "CodableHelpers"),
    .target(
      name: "Favicon",
      dependencies: [
        "BraveCore",
        "BraveShared",
        "Shared",
        "SDWebImage",
      ],
      resources: [
        .copy("Assets/top_sites.json"),
        .copy("Assets/TopSites")
      ],
      plugins: ["LoggerPlugin"]
    ),
    .testTarget(name: "SharedTests", dependencies: ["Shared"]),
    .testTarget(
      name: "BraveSharedTests",
      dependencies: ["BraveShared", "BraveSharedTestUtils"],
      exclude: [ "Certificates/self-signed.conf" ],
      resources: [
        .copy("Certificates/root.cer"),
        .copy("Certificates/leaf.cer"),
        .copy("Certificates/intermediate.cer"),
        .copy("Certificates/self-signed.cer"),
        .copy("Certificates/expired.badssl.com/expired.badssl.com-intermediate-ca-1.cer"),
        .copy("Certificates/expired.badssl.com/expired.badssl.com-intermediate-ca-2.cer"),
        .copy("Certificates/expired.badssl.com/expired.badssl.com-leaf.cer"),
        .copy("Certificates/expired.badssl.com/expired.badssl.com-root-ca.cer"),
        .copy("Certificates/expired.badssl.com/self-signed.badssl.com.cer"),
        .copy("Certificates/expired.badssl.com/untrusted.badssl.com-leaf.cer"),
        .copy("Certificates/expired.badssl.com/untrusted.badssl.com-root.cer"),
        .copy("Certificates/certviewer/brave.com.cer"),
        .copy("Certificates/certviewer/github.com.cer"),
      ]
    ),
    .testTarget(
      name: "BraveWalletTests",
      dependencies: [
        "BraveWallet",
        "DataTestsUtils",
        "Favicon",
        .product(name: "CustomDump", package: "swift-custom-dump")
      ]
    ),
    .testTarget(name: "StorageTests", dependencies: ["Storage", "BraveSharedTestUtils"], resources: [.copy("fixtures/v33.db"), .copy("testcert1.pem"), .copy("testcert2.pem")]),
    .testTarget(name: "DataTests", dependencies: ["Data", "DataTestsUtils"]),
    .testTarget(name: "SPMLibrariesTests", dependencies: ["GCDWebServers"]),
    .testTarget(
      name: "ClientTests",
      dependencies: ["Brave", "BraveSharedTestUtils"],
      resources: [
        .copy("Resources/debouncing.json"),
        .copy("Resources/content-blocking.json"),
        .copy("Resources/filter-lists.json"),
        .copy("Resources/google-search-plugin.xml"),
        .copy("Resources/duckduckgo-search-plugin.xml"),
        .copy("Resources/ad-block-resources/resources.json"),
        .copy("Resources/ad-block-resources/67E792D4-AE03-4D1A-9EDE-80E01C81F9B8-resources.json"),
        .copy("Resources/ad-block-resources/AC023D22-AE88-4060-A978-4FEEEC4221693-resources.json"),
        .copy("Resources/filter-rules/latest.txt"),
        .copy("Resources/filter-rules/67E792D4-AE03-4D1A-9EDE-80E01C81F9B8-latest.txt"),
        .copy("Resources/filter-rules/AC023D22-AE88-4060-A978-4FEEEC4221693-latest.txt"),
        .copy("Resources/filter-rules/rs-ABPFilterParserData.dat"),
        .copy("Resources/filter-rules/rs-67E792D4-AE03-4D1A-9EDE-80E01C81F9B8.dat"),
        .copy("Resources/filter-rules/rs-AC023D22-AE88-4060-A978-4FEEEC4221693.dat"),
        .copy("blocking-summary-test.json"),
      ]
    ),
    .target(name: "Strings"),
    .target(name: "RuntimeWarnings"),
    .testTarget(name: "GrowthTests", dependencies: ["Growth", "Shared", "BraveShared", "BraveVPN"]),
    .plugin(name: "IntentBuilderPlugin", capability: .buildTool()),
    .plugin(name: "LoggerPlugin", capability: .buildTool()),
  ],
  cxxLanguageStandard: .cxx17
)

var braveTarget: PackageDescription.Target = .target(
  name: "Brave",
  dependencies: [
    "BraveShared",
    "Shared",
    "BraveWallet",
    "BraveCore",
    "MaterialComponents",
    "BraveUI",
    "DesignSystem",
    "Data",
    "Storage",
    "GCDWebServers",
    "Fuzi",
    "SnapKit",
    "Static",
    "ZIPFoundation",
    "SDWebImage",
    "Then",
    "SwiftKeychainWrapper",
    "SwiftyJSON",
    "BrowserIntentsModels",
    "BraveWidgetsModels",
    "BraveVPN",
    "BraveNews",
    "Onboarding",
    "Growth",
    "CodableHelpers",
    .product(name: "Lottie", package: "lottie-ios"),
    .product(name: "Collections", package: "swift-collections"),
  ],
  exclude: [
    "Frontend/UserContent/UserScripts/AllFrames",
    "Frontend/UserContent/UserScripts/MainFrame",
    "Frontend/UserContent/UserScripts/Sandboxed",
  ],
  resources: [
    .copy("Assets/About/Licenses.html"),
    .copy("Assets/__firefox__.js"),
    .copy("Assets/AllFramesAtDocumentEnd.js"),
    .copy("Assets/AllFramesAtDocumentEndSandboxed.js"),
    .copy("Assets/AllFramesAtDocumentStart.js"),
    .copy("Assets/AllFramesAtDocumentStartSandboxed.js"),
    .copy("Assets/MainFrameAtDocumentEnd.js"),
    .copy("Assets/MainFrameAtDocumentEndSandboxed.js"),
    .copy("Assets/MainFrameAtDocumentStart.js"),
    .copy("Assets/MainFrameAtDocumentStartSandboxed.js"),
    .copy("Assets/SessionRestore.html"),
    .copy("Assets/Fonts/FiraSans-Bold.ttf"),
    .copy("Assets/Fonts/FiraSans-BoldItalic.ttf"),
    .copy("Assets/Fonts/FiraSans-Book.ttf"),
    .copy("Assets/Fonts/FiraSans-Italic.ttf"),
    .copy("Assets/Fonts/FiraSans-Light.ttf"),
    .copy("Assets/Fonts/FiraSans-Medium.ttf"),
    .copy("Assets/Fonts/FiraSans-Regular.ttf"),
    .copy("Assets/Fonts/FiraSans-SemiBold.ttf"),
    .copy("Assets/Fonts/FiraSans-UltraLight.ttf"),
    .copy("Assets/Fonts/NewYorkMedium-Bold.otf"),
    .copy("Assets/Fonts/NewYorkMedium-BoldItalic.otf"),
    .copy("Assets/Fonts/NewYorkMedium-Regular.otf"),
    .copy("Assets/Fonts/NewYorkMedium-RegularItalic.otf"),
    .copy("Assets/Interstitial Pages/Pages/CertificateError.html"),
    .copy("Assets/Interstitial Pages/Pages/GenericError.html"),
    .copy("Assets/Interstitial Pages/Pages/NetworkError.html"),
    .copy("Assets/Interstitial Pages/Pages/SNSDomain.html"),
    .copy("Assets/Interstitial Pages/Images/Carret.png"),
    .copy("Assets/Interstitial Pages/Images/Clock.svg"),
    .copy("Assets/Interstitial Pages/Images/Cloud.svg"),
    .copy("Assets/Interstitial Pages/Images/DarkWarning.svg"),
    .copy("Assets/Interstitial Pages/Images/Generic.svg"),
    .copy("Assets/Interstitial Pages/Images/Globe.svg"),
    .copy("Assets/Interstitial Pages/Images/Info.svg"),
    .copy("Assets/Interstitial Pages/Images/Warning.svg"),
    .copy("Assets/Interstitial Pages/Styles/CertificateError.css"),
    .copy("Assets/Interstitial Pages/Styles/InterstitialStyles.css"),
    .copy("Assets/Interstitial Pages/Styles/NetworkError.css"),
    .copy("Assets/Interstitial Pages/Styles/SNSDomain.css"),
    .copy("Assets/SearchPlugins"),
    .copy("Frontend/Reader/Reader.css"),
    .copy("Frontend/Reader/Reader.html"),
    .copy("Frontend/Reader/ReaderViewLoading.html"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/ntp-data.json"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/alain_franchette_ocean.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/boris_baldinger.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/caline_beulin.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/corwin-prescott_beach.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/corwin-prescott_canyon.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/corwin-prescott_crestone.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/curt_stump_nature.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/david_malenfant_mountains.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/dylan-malval_sea.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/geran_de_klerk_forest.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/joshn_larson_desert.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/priyanuch_konkaew.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/spencer-moore_desert.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/spencer-moore_fern.jpg"),
    .copy("Frontend/Browser/New Tab Page/Backgrounds/Assets/NTP_Images/spencer-moore_ocean.jpg"),
    .copy("Frontend/Sync/WebFilter/Bookmarks/Bookmarks.html"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/DomainSpecific/Paged/BraveSearchScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/DomainSpecific/Paged/BraveSkusScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/DomainSpecific/Paged/nacl.min.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/DomainSpecific/Paged/PlaylistFolderSharingScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/DomainSpecific/Paged/FrameCheckWrapper.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/DomainSpecific/Paged/YoutubeAdblock.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/CookieControlScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/FarblingProtectionScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/MediaBackgroundingScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/PlaylistSwizzlerScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/ReadyStateScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/RequestBlockingScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/TrackingProtectionStats.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/RewardsReportingScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/WalletEthereumProviderScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Paged/WalletSolanaProviderScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Sandboxed/DeAmpScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Sandboxed/FaviconScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Sandboxed/PlaylistScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Sandboxed/ResourceDownloaderScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Sandboxed/SelectorsPollerScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Sandboxed/SiteStateListenerScript.js"),
    .copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/Sandboxed/WindowRenderScript.js"),
    .copy("WebFilters/ContentBlocker/build-disconnect.py"),
    .copy("WebFilters/ContentBlocker/Lists/block-ads.json"),
    .copy("WebFilters/ContentBlocker/Lists/block-cookies.json"),
    .copy("WebFilters/ContentBlocker/Lists/block-trackers.json"),
    .copy("WebFilters/ContentBlocker/Lists/upgrade-http.json"),
    .copy("WebFilters/ShieldStats/Adblock/Resources/ABPFilterParserData.dat"),
  ],
  plugins: ["LoggerPlugin"]
)

if ProcessInfo.processInfo.environment["BRAVE_APPSTORE_BUILD"] == nil {
  // Not a release build, add BraveTalk integrations
  braveTarget.dependencies.append("BraveTalk")
  braveTarget.resources?.append(
    PackageDescription.Resource.copy("Frontend/UserContent/UserScripts/Scripts_Dynamic/Scripts/DomainSpecific/Paged/BraveTalkScript.js")
  )
  package.dependencies.append(.package(name: "JitsiMeet", path: "ThirdParty/JitsiMeet"))
  package.products.append(.library(name: "BraveTalk", targets: ["BraveTalk"]))
  package.targets.append(contentsOf: [
    .target(name: "BraveTalk", dependencies: ["Shared", "JitsiMeet"]),
    .testTarget(name: "BraveTalkTests", dependencies: ["BraveTalk", "Shared"]),
  ])
}

package.targets.append(braveTarget)

#if swift(>=5.8)
// Xcode 14.3b1 uses `-strict-concurrency=targeted` as the default. This can be removed when a Xcode build
// moves this back to `minimal`. See https://github.com/apple/swift/pull/63786
for i in package.targets.indices {
  let type = package.targets[i].type
  if type == .binary || type == .plugin { continue }
  package.targets[i].swiftSettings = [
    .unsafeFlags(["-Xfrontend", "-strict-concurrency=minimal"])
  ]
}
#endif
