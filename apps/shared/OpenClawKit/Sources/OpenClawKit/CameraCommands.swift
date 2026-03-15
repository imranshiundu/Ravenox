import Foundation

public enum RavenoxCameraCommand: String, Codable, Sendable {
    case list = "camera.list"
    case snap = "camera.snap"
    case clip = "camera.clip"
}

public enum RavenoxCameraFacing: String, Codable, Sendable {
    case back
    case front
}

public enum RavenoxCameraImageFormat: String, Codable, Sendable {
    case jpg
    case jpeg
}

public enum RavenoxCameraVideoFormat: String, Codable, Sendable {
    case mp4
}

public struct RavenoxCameraSnapParams: Codable, Sendable, Equatable {
    public var facing: RavenoxCameraFacing?
    public var maxWidth: Int?
    public var quality: Double?
    public var format: RavenoxCameraImageFormat?
    public var deviceId: String?
    public var delayMs: Int?

    public init(
        facing: RavenoxCameraFacing? = nil,
        maxWidth: Int? = nil,
        quality: Double? = nil,
        format: RavenoxCameraImageFormat? = nil,
        deviceId: String? = nil,
        delayMs: Int? = nil)
    {
        self.facing = facing
        self.maxWidth = maxWidth
        self.quality = quality
        self.format = format
        self.deviceId = deviceId
        self.delayMs = delayMs
    }
}

public struct RavenoxCameraClipParams: Codable, Sendable, Equatable {
    public var facing: RavenoxCameraFacing?
    public var durationMs: Int?
    public var includeAudio: Bool?
    public var format: RavenoxCameraVideoFormat?
    public var deviceId: String?

    public init(
        facing: RavenoxCameraFacing? = nil,
        durationMs: Int? = nil,
        includeAudio: Bool? = nil,
        format: RavenoxCameraVideoFormat? = nil,
        deviceId: String? = nil)
    {
        self.facing = facing
        self.durationMs = durationMs
        self.includeAudio = includeAudio
        self.format = format
        self.deviceId = deviceId
    }
}
