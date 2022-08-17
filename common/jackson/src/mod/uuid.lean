universe u

-- TODO: come up with an actual definition for UUID type
def uuid : Type := ℕ

instance : has_repr uuid := ⟨begin
  intro u,
  simp only [uuid] at u,
  exact has_repr.repr u,
end⟩

