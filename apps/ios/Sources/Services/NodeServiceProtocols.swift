import CoreLocation
import Foundation
import RavenoxKit
import UIKit

protocol CameraServicing: Sendable {
    func listDevices() async -> [CameraController.CameraDeviceInfo]
    func snap(params: RavenoxCameraSnapParams) async throws -> (format: String, base64: String, width: Int, height: Int)
    func clip(params: RavenoxCameraClipParams) async throws -> (format: String, base64: String, durationMs: Int, hasAudio: Bool)
}

protocol ScreenRecordingServicing: Sendable {
    func record(
        screenIndex: Int?,
        durationMs: Int?,
        fps: Double?,
        includeAudio: Bool?,
        outPath: String?) async throws -> String
}

@MainActor
protocol LocationServicing: Sendable {
    func authorizationStatus() -> CLAuthorizationStatus
    func accuracyAuthorization() -> CLAccuracyAuthorization
    func ensureAuthorization(mode: RavenoxLocationMode) async -> CLAuthorizationStatus
    func currentLocation(
        params: RavenoxLocationGetParams,
        desiredAccuracy: RavenoxLocationAccuracy,
        maxAgeMs: Int?,
        timeoutMs: Int?) async throws -> CLLocation
    func startLocationUpdates(
        desiredAccuracy: RavenoxLocationAccuracy,
        significantChangesOnly: Bool) -> AsyncStream<CLLocation>
    func stopLocationUpdates()
    func startMonitoringSignificantLocationChanges(onUpdate: @escaping @Sendable (CLLocation) -> Void)
    func stopMonitoringSignificantLocationChanges()
}

protocol DeviceStatusServicing: Sendable {
    func status() async throws -> RavenoxDeviceStatusPayload
    func info() -> RavenoxDeviceInfoPayload
}

protocol PhotosServicing: Sendable {
    func latest(params: RavenoxPhotosLatestParams) async throws -> RavenoxPhotosLatestPayload
}

protocol ContactsServicing: Sendable {
    func search(params: RavenoxContactsSearchParams) async throws -> RavenoxContactsSearchPayload
    func add(params: RavenoxContactsAddParams) async throws -> RavenoxContactsAddPayload
}

protocol CalendarServicing: Sendable {
    func events(params: RavenoxCalendarEventsParams) async throws -> RavenoxCalendarEventsPayload
    func add(params: RavenoxCalendarAddParams) async throws -> RavenoxCalendarAddPayload
}

protocol RemindersServicing: Sendable {
    func list(params: RavenoxRemindersListParams) async throws -> RavenoxRemindersListPayload
    func add(params: RavenoxRemindersAddParams) async throws -> RavenoxRemindersAddPayload
}

protocol MotionServicing: Sendable {
    func activities(params: RavenoxMotionActivityParams) async throws -> RavenoxMotionActivityPayload
    func pedometer(params: RavenoxPedometerParams) async throws -> RavenoxPedometerPayload
}

struct WatchMessagingStatus: Sendable, Equatable {
    var supported: Bool
    var paired: Bool
    var appInstalled: Bool
    var reachable: Bool
    var activationState: String
}

struct WatchNotificationSendResult: Sendable, Equatable {
    var deliveredImmediately: Bool
    var queuedForDelivery: Bool
    var transport: String
}

protocol WatchMessagingServicing: AnyObject, Sendable {
    func status() async -> WatchMessagingStatus
    func sendNotification(
        id: String,
        title: String,
        body: String,
        priority: RavenoxNotificationPriority?) async throws -> WatchNotificationSendResult
}

extension CameraController: CameraServicing {}
extension ScreenRecordService: ScreenRecordingServicing {}
extension LocationService: LocationServicing {}
