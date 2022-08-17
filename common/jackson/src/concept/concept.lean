axiom operation : Type  -- this is wrong

universe u

section concept 

class has_name := (name : string)
class has_purpose := (purpose : string)
class has_state (α : Type u) := (type : Type u)

class concept (state_type : Type u) 
  extends has_name, has_purpose, has_state state_type

#check concept

end concept

