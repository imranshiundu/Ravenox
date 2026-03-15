import Foundation

public enum RavenoxDeviceCommand: String, Codable, Sendable {
    case status = "device.status"
    case info = "device.info"
}

public enum RavenoxBatteryState: String, Codable, Sendable {
    case unknown
    case unplugged
    case charging
    case full
}

public enum RavenoxThermalState: String, Codable, Sendable {
    case nominal
    case fair
    case serious
    case critical
}

public enum RavenoxNetworkPathStatus: String, Codable, Sendable {
    case satisfied
    case unsatisfied
    case requiresConnection
}

public enum RavenoxNetworkInterfaceType: String, Codable, Sendable {
    case wifi
    case cellular
    case wired
    case other
}

public struct RavenoxBatteryStatusPayload: Codable, Sendable, Equatable {
    public var level: Double?
    public var state: RavenoxBatteryState
    public var lowPowerModeEnabled: Bool

    public init(level: Double?, state: RavenoxBatteryState, lowPowerModeEnabled: Bool) {
        self.level = level
        self.state = state
        self.lowPowerModeEnabled = lowPowerModeEnabled
    }
}

public struct RavenoxThermalStatusPayload: Codable, Sendable, Equatable {
    public var state: RavenoxThermalState

    public init(state: RavenoxThermalState) {
        self.state = state
    }
}

public struct RavenoxStorageStatusPayload: Codable, Sendable, Equatable {
    public var totalBytes: Int64
    public var freeBytes: Int64
    public var usedBytes: Int64

    public init(totalBytes: Int64, freeBytes: Int64, usedBytes: Int64) {
        self.totalBytes = totalBytes
        self.freeBytes = freeBytes
        self.usedBytes = usedBytes
    }
}

public struct RavenoxNetworkStatusPayload: Codable, Sendable, Equatable {
    public var status: RavenoxNetworkPathStatus
    public var isExpensive: Bool
    public var isConstrained: Bool
    public var interfaces: [RavenoxNetworkInterfaceType]

    public init(
        status: RavenoxNetworkPathStatus,
        isExpensive: Bool,
        isConstrained: Bool,
        interfaces: [RavenoxNetworkInterfaceType])
    {
        self.status = status
        self.isExpensive = isExpensive
        self.isConstrained = isConstrained
        self.interfaces = interfaces
    }
}

public struct RavenoxDeviceStatusPayload: Codable, Sendable, Equatable {
    public var battery: RavenoxBatteryStatusPayload
    public var thermal: RavenoxThermalStatusPayload
    public var storage: RavenoxStorageStatusPayload
    public var network: RavenoxNetworkStatusPayload
    public var uptimeSeconds: Double

    public init(
        battery: RavenoxBatteryStatusPayload,
        thermal: RavenoxThermalStatusPayload,
        storage: RavenoxStorageStatusPayload,
        network: RavenoxNetworkStatusPayload,
        uptimeSeconds: Double)
    {
        self.battery = battery
        self.thermal = thermal
        self.storage = storage
        self.network = network
        self.uptimeSeconds = uptimeSeconds
    }
}

public struct RavenoxDeviceInfoPayload: Codable, Sendable, Equatable {
    public var deviceName: String
    public var modelIdentifier: String
    public var systemName: String
    public var systemVersion: String
    public var appVersion: String
    public var appBuild: String
    public var locale: String

    public init(
        deviceName: String,
        modelIdentifier: String,
        systemName: String,
        systemVersion: String,
        appVersion: String,
        appBuild: String,
        locale: String)
    {
        self.deviceName = deviceName
        self.modelIdentifier = modelIdentifier
        self.systemName = systemName
        self.systemVersion = systemVersion
        self.appVersion = appVersion
        self.appBuild = appBuild
        self.locale = locale
    }
}
