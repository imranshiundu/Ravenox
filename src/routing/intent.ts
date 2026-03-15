import { isTruthyEnvValue } from "../infra/env.js";
import { logDebug } from "../logger.js";

export type Intent = "CHAT" | "COMMAND" | "TASK" | "AUTONOMOUS";

const LOCAL_COMMAND_KEYWORDS = [
    "open spotify", "play music", "open code", "vscode", "screenshot", 
    "system status", "volume", "brightness", "status", "files", "list"
];

export async function resolveIntent(message: string): Promise<Intent> {
    const trimmed = message.trim().toLowerCase();

    // Zero-token regex routing (Dormant State)
    if (trimmed.startsWith("/") || trimmed.startsWith("arthur ")) {
        return "COMMAND";
    }

    // Heuristic for local commands (Diet Optimization)
    if (LOCAL_COMMAND_KEYWORDS.some(kw => trimmed.includes(kw))) {
        return "COMMAND";
    }

    // Simple heuristic for complex tasks
    if (trimmed.includes("write code") || trimmed.includes("create a website") || trimmed.includes("fix the bug") || trimmed.includes("refactor")) {
        return "TASK";
    }

    if (trimmed.includes("search for") || trimmed.includes("research") || trimmed.includes("what is the latest")) {
        return "AUTONOMOUS"; // Trigger Titan Mode
    }

    // Default to chat
    return "CHAT";
}

/**
 * Routes the message to the appropriate model based on intent (The Diet: Flash First)
 */
export function selectModelForIntent(intent: Intent): string {
    const isLightMode = isTruthyEnvValue(process.env.ARTHUR_LIGHT_MODE);
    const defaultSmallModel = isLightMode ? "gemini-1.5-flash" : "gpt-4o-mini";

    switch (intent) {
        case "CHAT":
        case "COMMAND":
            return defaultSmallModel;
        case "TASK":
            return "claude-3-5-sonnet-20241022";
        case "AUTONOMOUS":
            return "gemini-1.5-pro";
        default:
            return defaultSmallModel;
    }
}
