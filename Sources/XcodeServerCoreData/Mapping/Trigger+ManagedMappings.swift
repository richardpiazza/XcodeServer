import XcodeServer
#if canImport(CoreData)

public extension XcodeServer.Trigger {
    init(_ trigger: XcodeServerCoreData.Trigger) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.Trigger to XcodeServer.Trigger")
        self.init()
        name = trigger.name ?? ""
        type = trigger.type
        phase = trigger.phase
        scriptBody = trigger.scriptBody ?? ""
        if let config = trigger.emailConfiguration {
            email = XcodeServer.Trigger.Email(config)
        }
        if let conditions = trigger.conditions {
            self.conditions = XcodeServer.Trigger.Conditions(conditions)
        }
    }
}

public extension XcodeServer.Trigger.Email {
    init(_ email: EmailConfiguration) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.EmailConfiguration to XcodeServer.Trigger.Email")
        self.init()
        type = email.emailType
        fromAddress = email.fromAddress ?? ""
        replyToAddress = email.replyToAddress ?? ""
        allowedDomainNames = email.allowedDomainNames
        additionalRecipients = email.recipients
        ccAddresses = email.ccAddresses
        weeklyScheduleDay = Int(email.weeklyScheduleDay)
        hour = Int(email.hour)
        minutesAfterHour = Int(email.minutesAfterHour)
        emailCommitters = email.emailCommitters
        includeBotConfiguration = email.includeBotConfiguration
        includeCommitMessages = email.includeCommitMessages
        includeIssueDetails = email.includeIssueDetails
        includeLogs = email.includeLogs
        includeResolvedIssues = email.includeResolvedIssues
    }
}

public extension XcodeServer.Trigger.Conditions {
    init(_ conditions: Conditions) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.Conditions to XcodeServer.Trigger.Conditions")
        self.init()
        status = Int(conditions.statusRawValue)
        onAllIssuesResolved = conditions.onAllIssuesResolved
        onWarnings = conditions.onWarnings
        onBuildErrors = conditions.onBuildErrors
        onAnalyzerWarnings = conditions.onAnalyzerWarnings
        onFailingTests = conditions.onFailingTests
        onSuccess = conditions.onSuccess
    }
}

#endif
