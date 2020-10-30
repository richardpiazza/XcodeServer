import XcodeServer

public extension Trigger {
    init(_ trigger: XCSTrigger) {
        self.init()
        name = trigger.name ?? ""
        type = Trigger.Category(rawValue: trigger.type?.rawValue ?? 0) ?? .script
        phase = Trigger.Phase(rawValue: trigger.phase?.rawValue ?? 0) ?? .beforeIntegration
        scriptBody = trigger.scriptBody ?? ""
        if let config = trigger.emailConfiguration {
            email = Trigger.Email(config)
        }
        if let conditions = trigger.conditions {
            self.conditions = Trigger.Conditions(conditions)
        }
    }
}

public extension Trigger.Email {
    init(_ email: XCSEmailConfiguration) {
        self.init()
        type = Trigger.Email.Category(rawValue: email.type?.rawValue ?? 0) ?? .integrationReport
        fromAddress = email.fromAddress ?? ""
        replyToAddress = email.replyToAddress ?? ""
        allowedDomainNames = email.allowedDomainNames ?? []
        additionalRecipients = email.additionalRecipients ?? []
        ccAddresses = email.ccAddresses ?? []
        weeklyScheduleDay = email.weeklyScheduleDay ?? 0
        hour = email.hour ?? 0
        minutesAfterHour = email.minutesAfterHour ?? 0
        emailCommitters = email.emailCommitters ?? false
        includeBotConfiguration = email.includeBotConfiguration ?? false
        includeCommitMessages = email.includeCommitMessages ?? false
        includeIssueDetails = email.includeIssueDetails ?? false
        includeLogs = email.includeLogs ?? false
        includeResolvedIssues = email.includeResolvedIssues ?? false
        scmOptions = email.scmOptions ?? [:]
    }
}

public extension Trigger.Conditions {
    init(_ conditions: XCSConditions) {
        self.init()
        status = conditions.status ?? 0
        onAllIssuesResolved = conditions.onAllIssuesResolved ?? false
        onWarnings = conditions.onWarnings ?? false
        onBuildErrors = conditions.onBuildErrors ?? false
        onAnalyzerWarnings = conditions.onAnalyzerWarnings ?? false
        onFailingTests = conditions.onFailingTests ?? false
        onSuccess = conditions.onSuccess ?? false
    }
}
