import { describe, expect, it } from "vitest";
import { resolveIrcInboundTarget } from "./monitor.js";

describe("irc monitor inbound target", () => {
  it("keeps channel target for group messages", () => {
    expect(
      resolveIrcInboundTarget({
        target: ".ravenox",
        senderNick: "alice",
      }),
    ).toEqual({
      isGroup: true,
      target: ".ravenox",
      rawTarget: ".ravenox",
    });
  });

  it("maps DM target to sender nick and preserves raw target", () => {
    expect(
      resolveIrcInboundTarget({
        target: .ravenox-bot",
        senderNick: "alice",
      }),
    ).toEqual({
      isGroup: false,
      target: "alice",
      rawTarget: .ravenox-bot",
    });
  });

  it("falls back to raw target when sender nick is empty", () => {
    expect(
      resolveIrcInboundTarget({
        target: .ravenox-bot",
        senderNick: " ",
      }),
    ).toEqual({
      isGroup: false,
      target: .ravenox-bot",
      rawTarget: .ravenox-bot",
    });
  });
});
