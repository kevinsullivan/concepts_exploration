universe u

structure time_utc : Type :=
(seconds_since_start_of_epoch : ℕ)

instance : decidable_eq time_utc := by tactic.mk_dec_eq_instance

instance : has_repr time_utc := ⟨
  λ (t : time_utc), 
    has_to_string.to_string t.seconds_since_start_of_epoch
⟩

