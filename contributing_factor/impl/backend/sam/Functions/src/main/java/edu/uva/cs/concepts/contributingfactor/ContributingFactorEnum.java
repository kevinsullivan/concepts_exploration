package edu.uva.cs.concepts.contributingfactor;

import com.fasterxml.jackson.annotation.JsonProperty;

public enum ContributingFactorEnum {
        @JsonProperty("patient_unnecessary_treatments")
        PatientUnnecessaryTreatments,

        @JsonProperty("patient_aggressive_treatment")
        PatientAggressiveTreatment,

        @JsonProperty("patient_unnecessary_suffering")
        PatientUnnecessarySuffering,

        @JsonProperty("patient_inadequate_consent")
        PatientInadequateConsent,

        @JsonProperty("patient_false_hope")
        PatientFalseHope,

        @JsonProperty("patient_not_discuss_prognosis")
        PatientNotDiscussPrognosis,

        @JsonProperty("patient_other")
        PatientOther,

        @JsonProperty("team_unclear_treatment")
        TeamUnclearTreatment,

        @JsonProperty("team_lack_provider_continuity")
        TeamLackProviderContinuity,

        @JsonProperty("team_fearing_retribution")
        TeamFearingRetribution,

        @JsonProperty("team_not_competent")
        TeamNotCompetent,

        @JsonProperty("team_fearing_litigation")
        TeamFearingLitigation,

        @JsonProperty("team_ignore_errors")
        TeamIgnoreErrors,

        @JsonProperty("team_report_violation")
        TeamReportViolation,

        @JsonProperty("team_no_dignity_respect")
        TeamNoDignityRespect,

        @JsonProperty("team_unsafe_bullied")
        TeamUnsafeBullied,

        @JsonProperty("team_power_structures")
        TeamPowerStructures,

        @JsonProperty("team_poor_communication")
        TeamPoorCommunication,

        @JsonProperty("team_inconsistent_messages")
        TeamInconsistentMessages,

        @JsonProperty("team_other")
        TeamOther,

        @JsonProperty("system_not_qualified")
        SystemNotQualified,

        @JsonProperty("system_more_patients_than_safe")
        SystemMorePatientsThanSafe,

        @JsonProperty("system_lack_admin_support")
        SystemLackAdminSupport,

        @JsonProperty("system_work_with_abusive")
        SystemWorkWithAbusive,

        @JsonProperty("system_reduce_costs")
        SystemReduceCosts,

        @JsonProperty("system_lack_resources")
        SystemLackResources,

        @JsonProperty("system_excessive_documentation")
        SystemExcessiveDocumentation,

        @JsonProperty("system_emphasize_productivity_measures")
        SystemEmphasizeProductivityMeasures,

        @JsonProperty("system_other")
        SystemOther;
}

