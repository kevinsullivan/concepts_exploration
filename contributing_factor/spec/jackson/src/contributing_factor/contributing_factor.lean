universe u

inductive contributing_factor : Type u
| patient_unnecessary_treatments : contributing_factor
| patient_aggressive_treatment : contributing_factor
| patient_unnecessary_suffering : contributing_factor
| patient_inadequate_consent : contributing_factor
| patient_false_hope : contributing_factor
| patient_not_discuss_prognosis : contributing_factor
| patient_other : contributing_factor
| team_unclear_treatment : contributing_factor
| team_lack_provider_continuity : contributing_factor
| team_fearing_retribution : contributing_factor
| team_not_competent : contributing_factor
| team_fearing_litigation : contributing_factor
| team_ignore_errors : contributing_factor
| team_report_violation : contributing_factor
| team_no_dignity_respect : contributing_factor
| team_unsafe_bullied : contributing_factor
| team_power_structures : contributing_factor
| team_poor_communication : contributing_factor
| team_inconsistent_messages : contributing_factor
| team_other : contributing_factor
| system_not_qualified : contributing_factor
| system_more_patients_than_safe : contributing_factor
| system_lack_admin_support : contributing_factor
| system_work_with_abusive : contributing_factor
| system_reduce_costs : contributing_factor
| system_lack_resources : contributing_factor
| system_excessive_documentation : contributing_factor
| system_emphasize_productivity_measures : contributing_factor
| system_other : contributing_factor

namespace contributing_factor

/-
Homework: is this another example/instance ot tags?
Or more precisely autotagging based on our "formula?"
-/

open contributing_factor

inductive category : Type
| patient
| team
| system

open category

def get_category : contributing_factor → category
| patient_unnecessary_treatments := patient
| patient_aggressive_treatment := patient
| patient_unnecessary_suffering := patient
| patient_inadequate_consent := patient
| patient_false_hope := patient
| patient_not_discuss_prognosis := patient
| patient_other := patient
| team_unclear_treatment := team
| team_lack_provider_continuity := team
| team_fearing_retribution := team
| team_not_competent := team
| team_fearing_litigation := team
| team_ignore_errors := team
| team_report_violation := team
| team_no_dignity_respect := team
| team_unsafe_bullied := team
| team_power_structures := team
| team_poor_communication := team
| team_inconsistent_messages := team
| team_other := team
| system_not_qualified := system
| system_more_patients_than_safe := system
| system_lack_admin_support := system
| system_work_with_abusive := system
| system_reduce_costs := system
| system_lack_resources := system
| system_excessive_documentation := system
| system_emphasize_productivity_measures := system
| system_other := system

def get_description : contributing_factor → string
| patient_unnecessary_treatments := "Feeling pressured to give unnecessary/inappropriate test and/or treatments"
| patient_aggressive_treatment := "Having to continue aggressive treatment not in the patient's best interest"
| patient_unnecessary_suffering := "Causing unnecessary suffering or do not relieve pain/symptoms"
| patient_inadequate_consent := "Ignoring situations of inadequate informed consent"
| patient_false_hope := "Witnessing providers giving \"false hope\" to patients/families"
| patient_not_discuss_prognosis := "Having to follow MD/family's request to not discuss prognosis"
| team_unclear_treatment := "Seeing unclear/inconsistent treatment plans or goals of care"
| team_lack_provider_continuity := "Witnessing lack of provider continuity"
| team_fearing_retribution := "Fearing retribution if I speak up"
| team_not_competent := "Witnessing other team members not competent in providing quality care"
| team_fearing_litigation := "Fearing litigation"
| team_ignore_errors := "Feeling pressured to ignore medical error(s)"
| team_report_violation := "Feeling not supported enough to report a violation of procedure/ethics"
| team_no_dignity_respect := "Working with teams who don't treat patients with dignity/respect"
| team_unsafe_bullied := "Feeling unsafe/bullied amongst own colleagues"
| team_power_structures := "Working within power structures that compromise patient care"
| team_poor_communication := "Witnessing poor team communication"
| team_inconsistent_messages := "Witnessing inconsistent messages to patient/family"
| system_not_qualified := "Caring for patients not qualified to care for"
| system_more_patients_than_safe := "Caring for more patients than is safe"
| system_lack_admin_support := "Experiencing lack of administrative/managerial support"
| system_work_with_abusive := "Feeling required to work with abusive patients/family members"
| system_reduce_costs := "Feeling pressured from admin/insurers to reduce costs over patient care"
| system_lack_resources := "Experiencing lack of resources/beds/equipment"
| system_excessive_documentation := "Experiencing excessive documentation requirements"
| system_emphasize_productivity_measures := "Feeling pressured to emphasize productivity/quality measures over patients"
| _ := "Other"

instance : has_repr contributing_factor := ⟨get_description⟩    -- nice: KS

end contributing_factor

instance : decidable_eq contributing_factor := by tactic.mk_dec_eq_instance