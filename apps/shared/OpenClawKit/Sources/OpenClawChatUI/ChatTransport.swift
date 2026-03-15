import Foundation

public enum RavenoxChatTransportEvent: Sendable {
    case health(ok: Bool)
    case tick
    case chat(RavenoxChatEventPayload)
    case agent(RavenoxAgentEventPayload)
    case seqGap
}

public protocol RavenoxChatTransport: Sendable {
    func requestHistory(sessionKey: String) async throws -> RavenoxChatHistoryPayload
    func sendMessage(
        sessionKey: String,
        message: String,
        thinking: String,
        idempotencyKey: String,
        attachments: [RavenoxChatAttachmentPayload]) async throws -> RavenoxChatSendResponse

    func abortRun(sessionKey: String, runId: String) async throws
    func listSessions(limit: Int?) async throws -> RavenoxChatSessionsListResponse

    func requestHealth(timeoutMs: Int) async throws -> Bool
    func events() -> AsyncStream<RavenoxChatTransportEvent>

    func setActiveSessionKey(_ sessionKey: String) async throws
}

extension RavenoxChatTransport {
    public func setActiveSessionKey(_: String) async throws {}

    public func abortRun(sessionKey _: String, runId _: String) async throws {
        throw NSError(
            domain: "RavenoxChatTransport",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "chat.abort not supported by this transport"])
    }

    public func listSessions(limit _: Int?) async throws -> RavenoxChatSessionsListResponse {
        throw NSError(
            domain: "RavenoxChatTransport",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "sessions.list not supported by this transport"])
    }
}
