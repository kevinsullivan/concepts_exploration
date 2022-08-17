import .contributing_factor
import .mod_report
import ..concept.collection
import ..examples.collection_list

open collection
open mod_report

def mr₁ := mod_report.mk ⟨3⟩ 3 (nat.succ nat.zero) [contributing_factor.patient_other]
def mr₂ := mod_report.mk ⟨0⟩ 10 nat.zero []

instance : decidable_eq (@mod_report list _) := mod_report.get_dec_eq_instance list

def r₀ : list (@mod_report list _) := has_collection.init mod_report
#eval has_collection.member r₀ mr₁
#eval has_collection.member r₀ mr₂
def r₁ := has_collection.insert r₀ mr₁
#eval has_collection.member r₁ mr₁
#eval has_collection.member r₁ mr₂
def r₂ := has_collection.insert r₁ mr₂
#eval has_collection.member r₂ mr₁
#eval has_collection.member r₂ mr₂
def r₃ := has_collection.remove r₂ mr₁
#eval has_collection.member r₃ mr₁
#eval has_collection.member r₃ mr₂
def r₄ := has_collection.empty r₃
#eval has_collection.member r₄ mr₁
#eval has_collection.member r₄ mr₂