import .contributing_factor
import .mod_report
import ..implementation.collection_list

-- Contributing Factor tests
def cf : contributing_factor := contributing_factor.patient_unnecessary_treatments

#reduce contributing_factor.get_category cf -- patient
#eval contributing_factor.get_description cf -- "Feeling pressured to give unnecessary/inappropriate test and/or treatments"

-- Mod Report tests

open mod_report

instance : has_repr (@mod_report list _) := get_repr_instance list

def mr₀ : @mod_report list _ := ⟨⟨44⟩, 3, nat.zero, [cf]⟩
def mr₁ := set_time mr₀ ⟨44050⟩
def mr₂ := set_score mr₁ 0


-- the commented out defs depend on set uuid, which we deny, to
-- enforce consistency with our intended concept: one where the
-- identity of a particular instance is unique and unvarying. So
-- you can't edit the uuid in this conception. 

/-
The commented lines could however be incorporated into an
implementation of an even more permission concept, to include
the ability to change any field freely.

It's the assurance that an instance can and will never have
a change of uuid that really elevates it to membership in the
concept of objects with unique perpetual identities. 
-/


-- def mr₃ := set_uuid mr₂ (nat.succ nat.zero)
-- def mr₄ := set_contributing_factors mr₃ []
#eval mr₀
#eval mr₁
#eval mr₂
-- #eval mr₃
-- #eval mr₄