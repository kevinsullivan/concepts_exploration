import .contributing_factor
import ..concept.collection
import .time
import .uuid

universe u

-- NAMESPACE

namespace mod_report

-- STATE: polymorphic, parameterized by storage data type, e.g., (list T)

-- def mod_scale := fin 11

/-
KS: Boom. This is where we "compose" collection with mod_report, by applying
"collection S I" to "list T" and mod_report, yielding the new concept of "a 
collection of I's stored as an S." 
OK, but this is totally wrong. Hang up for later.
-/

structure mod_report 
  {coll_impl : Type u → Type u} 
  [collection.has_collection coll_impl] : 
  Type u :=
(time : time_utc)
(score : fin 11)   -- Read "fin 11" as 0..10 inclusive (TODO)
(id : uuid)
(contributing_factors : coll_impl contributing_factor)


-- ACTIONS

def set_time 
  {c : Type u → Type u} 
  [hc : collection.has_collection c] : 
  @mod_report c hc → time_utc → @mod_report c hc
| ⟨t₀, s, u, cf⟩ t := ⟨t, s, u, cf⟩


def set_score 
  {c : Type u → Type u} 
  [hc : collection.has_collection c] : 
  @mod_report c hc → fin 11 → @mod_report c hc
| ⟨t, s₀, u, cf⟩ s := ⟨t, s, u, cf⟩

/-
I propose that this, we disallow, as it violates
the concept, that we are working on a specific
singluar mod_report object. Being explicit, we
do assume that the mapping from uuid to objects
is injective "even over time." You can change the 
state of an object but not its identity. 

Surely though there's also a meaningful concept
for the case of completely unrestricted editing
of these objects. As that case may be, we now
comment out the correspond set_uuid mutator.

def set_uuid 
  {c : Type u → Type u} 
  [hc : collection.has_collection c] : 
  @mod_report c hc → uuid → @mod_report c hc
| ⟨t, s, u₀, cf⟩ u := ⟨t, s, u, cf⟩
-/

def set_contributing_factors 
  {c : Type u → Type u} 
  [hc : collection.has_collection c] : 
  @mod_report c hc → c contributing_factor → @mod_report c hc
| ⟨t, s, u, cf₀⟩ cf := ⟨t, s, u, cf⟩

-- KS: Does adding/removing factors model the tags concept?
-- We wouldn't have considered this without Daniel's enumeration 
-- of some fundamental concepts (e.g., tags) 

def get_dec_eq_instance
  (c : Type u → Type u)
  [collection.has_collection c]
  [decidable_eq (c contributing_factor)] :
  decidable_eq (@mod_report c _) :=
begin
tactic.mk_dec_eq_instance,
end

-- "DISPLAY"

def get_repr_instance 
  (c : Type u → Type u) 
  [collection.has_collection c] 
  [has_repr (c contributing_factor)] : 
  has_repr (@mod_report c _) := ⟨
λ (mr : mod_report),
  "{time: " ++ has_repr.repr mr.time ++
  ", score: " ++ has_repr.repr mr.score ++
  ", uuid: " ++ has_repr.repr mr.id ++
  ", contributing_factors: " ++ has_repr.repr mr.contributing_factors ++ "}"
⟩

/-
Maybe get_repr_instance is better understood 
as a kind of relational bridge function that
takes a mod_report and turns it into an input
*for* a particular type of consumer. I.e., it
is get_repr_instance_for, taking an instance
as well as an audience type as its arguments.
-/

end mod_report


/-
A simple but big move here was to pull time and uuid
out into separate concept implementation files and 
namespaces (TODO: add namespaces in those files).
-/