//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contributing_factor.g.dart';

class ContributingFactor extends EnumClass {

  @BuiltValueEnumConst(wireName: r'patient_unnecessary_treatments')
  static const ContributingFactor patientUnnecessaryTreatments = _$patientUnnecessaryTreatments;
  @BuiltValueEnumConst(wireName: r'patient_aggressive_treatment')
  static const ContributingFactor patientAggressiveTreatment = _$patientAggressiveTreatment;
  @BuiltValueEnumConst(wireName: r'patient_unnecessary_suffering')
  static const ContributingFactor patientUnnecessarySuffering = _$patientUnnecessarySuffering;
  @BuiltValueEnumConst(wireName: r'patient_inadequate_consent')
  static const ContributingFactor patientInadequateConsent = _$patientInadequateConsent;
  @BuiltValueEnumConst(wireName: r'patient_false_hope')
  static const ContributingFactor patientFalseHope = _$patientFalseHope;
  @BuiltValueEnumConst(wireName: r'patient_not_discuss_prognosis')
  static const ContributingFactor patientNotDiscussPrognosis = _$patientNotDiscussPrognosis;
  @BuiltValueEnumConst(wireName: r'patient_other')
  static const ContributingFactor patientOther = _$patientOther;
  @BuiltValueEnumConst(wireName: r'team_unclear_treatment')
  static const ContributingFactor teamUnclearTreatment = _$teamUnclearTreatment;
  @BuiltValueEnumConst(wireName: r'team_lack_provider_continuity')
  static const ContributingFactor teamLackProviderContinuity = _$teamLackProviderContinuity;
  @BuiltValueEnumConst(wireName: r'team_fearing_retribution')
  static const ContributingFactor teamFearingRetribution = _$teamFearingRetribution;
  @BuiltValueEnumConst(wireName: r'team_not_competent')
  static const ContributingFactor teamNotCompetent = _$teamNotCompetent;
  @BuiltValueEnumConst(wireName: r'team_fearing_litigation')
  static const ContributingFactor teamFearingLitigation = _$teamFearingLitigation;
  @BuiltValueEnumConst(wireName: r'team_ignore_errors')
  static const ContributingFactor teamIgnoreErrors = _$teamIgnoreErrors;
  @BuiltValueEnumConst(wireName: r'team_report_violation')
  static const ContributingFactor teamReportViolation = _$teamReportViolation;
  @BuiltValueEnumConst(wireName: r'team_no_dignity_respect')
  static const ContributingFactor teamNoDignityRespect = _$teamNoDignityRespect;
  @BuiltValueEnumConst(wireName: r'team_unsafe_bullied')
  static const ContributingFactor teamUnsafeBullied = _$teamUnsafeBullied;
  @BuiltValueEnumConst(wireName: r'team_power_structures')
  static const ContributingFactor teamPowerStructures = _$teamPowerStructures;
  @BuiltValueEnumConst(wireName: r'team_poor_communication')
  static const ContributingFactor teamPoorCommunication = _$teamPoorCommunication;
  @BuiltValueEnumConst(wireName: r'team_inconsistent_messages')
  static const ContributingFactor teamInconsistentMessages = _$teamInconsistentMessages;
  @BuiltValueEnumConst(wireName: r'team_other')
  static const ContributingFactor teamOther = _$teamOther;
  @BuiltValueEnumConst(wireName: r'system_not_qualified')
  static const ContributingFactor systemNotQualified = _$systemNotQualified;
  @BuiltValueEnumConst(wireName: r'system_more_patients_than_safe')
  static const ContributingFactor systemMorePatientsThanSafe = _$systemMorePatientsThanSafe;
  @BuiltValueEnumConst(wireName: r'system_lack_admin_support')
  static const ContributingFactor systemLackAdminSupport = _$systemLackAdminSupport;
  @BuiltValueEnumConst(wireName: r'system_work_with_abusive')
  static const ContributingFactor systemWorkWithAbusive = _$systemWorkWithAbusive;
  @BuiltValueEnumConst(wireName: r'system_reduce_costs')
  static const ContributingFactor systemReduceCosts = _$systemReduceCosts;
  @BuiltValueEnumConst(wireName: r'system_lack_resources')
  static const ContributingFactor systemLackResources = _$systemLackResources;
  @BuiltValueEnumConst(wireName: r'system_excessive_documentation')
  static const ContributingFactor systemExcessiveDocumentation = _$systemExcessiveDocumentation;
  @BuiltValueEnumConst(wireName: r'system_emphasize_productivity_measures')
  static const ContributingFactor systemEmphasizeProductivityMeasures = _$systemEmphasizeProductivityMeasures;
  @BuiltValueEnumConst(wireName: r'system_other')
  static const ContributingFactor systemOther = _$systemOther;

  static Serializer<ContributingFactor> get serializer => _$contributingFactorSerializer;

  const ContributingFactor._(String name): super(name);

  static BuiltSet<ContributingFactor> get values => _$values;
  static ContributingFactor valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ContributingFactorMixin = Object with _$ContributingFactorMixin;

