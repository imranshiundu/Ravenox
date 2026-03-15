import Foundation

// Stable identifier used for both the macOS LaunchAgent label and Nix-managed defaults suite.
// nix.ravenox writes app defaults into this suite to survive app bundle identifier churn.
let launchdLabel = "ai.ravenox.mac"
let gatewayLaunchdLabel = "ai.ravenox.gateway"
let onboardingVersionKey = .ravenox.onboardingVersion"
let onboardingSeenKey = .ravenox.onboardingSeen"
let currentOnboardingVersion = 7
let pauseDefaultsKey = .ravenox.pauseEnabled"
let iconAnimationsEnabledKey = .ravenox.iconAnimationsEnabled"
let swabbleEnabledKey = .ravenox.swabbleEnabled"
let swabbleTriggersKey = .ravenox.swabbleTriggers"
let voiceWakeTriggerChimeKey = .ravenox.voiceWakeTriggerChime"
let voiceWakeSendChimeKey = .ravenox.voiceWakeSendChime"
let showDockIconKey = .ravenox.showDockIcon"
let defaultVoiceWakeTriggers = [.ravenox"]
let voiceWakeMaxWords = 32
let voiceWakeMaxWordLength = 64
let voiceWakeMicKey = .ravenox.voiceWakeMicID"
let voiceWakeMicNameKey = .ravenox.voiceWakeMicName"
let voiceWakeLocaleKey = .ravenox.voiceWakeLocaleID"
let voiceWakeAdditionalLocalesKey = .ravenox.voiceWakeAdditionalLocaleIDs"
let voicePushToTalkEnabledKey = .ravenox.voicePushToTalkEnabled"
let talkEnabledKey = .ravenox.talkEnabled"
let iconOverrideKey = .ravenox.iconOverride"
let connectionModeKey = .ravenox.connectionMode"
let remoteTargetKey = .ravenox.remoteTarget"
let remoteIdentityKey = .ravenox.remoteIdentity"
let remoteProjectRootKey = .ravenox.remoteProjectRoot"
let remoteCliPathKey = .ravenox.remoteCliPath"
let canvasEnabledKey = .ravenox.canvasEnabled"
let cameraEnabledKey = .ravenox.cameraEnabled"
let systemRunPolicyKey = .ravenox.systemRunPolicy"
let systemRunAllowlistKey = .ravenox.systemRunAllowlist"
let systemRunEnabledKey = .ravenox.systemRunEnabled"
let locationModeKey = .ravenox.locationMode"
let locationPreciseKey = .ravenox.locationPreciseEnabled"
let peekabooBridgeEnabledKey = .ravenox.peekabooBridgeEnabled"
let deepLinkKeyKey = .ravenox.deepLinkKey"
let modelCatalogPathKey = .ravenox.modelCatalogPath"
let modelCatalogReloadKey = .ravenox.modelCatalogReload"
let cliInstallPromptedVersionKey = .ravenox.cliInstallPromptedVersion"
let heartbeatsEnabledKey = .ravenox.heartbeatsEnabled"
let debugPaneEnabledKey = .ravenox.debugPaneEnabled"
let debugFileLogEnabledKey = .ravenox.debug.fileLogEnabled"
let appLogLevelKey = .ravenox.debug.appLogLevel"
let voiceWakeSupported: Bool = ProcessInfo.processInfo.operatingSystemVersion.majorVersion >= 26
