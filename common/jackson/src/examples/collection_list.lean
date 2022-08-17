import ..concept.collection
import tactic.cache

/-
This file provides an implementation of our "collection"
concept where the implementation type is "list." First
we implement collection operations for lists. Then we
declare an instance for "has_collection list," thereby
"making list a member of the collection typeclass." This
concept is polymorphic in the list element type. 
-/


open collection

universe u

def do_init : 
    ∀ (item_type : Type u) 
      [decidable_eq item_type], 
    list item_type
| _ _ := []


def do_member :
    ∀ {item_type : Type u} 
      [decidable_eq item_type],
    list item_type → item_type → bool 
| item_type e list.nil _ := ff
| item_type e (h::t) i := 
    by exactI       -- see note just below
        if (h = i)  -- decidable equaity used here
        then tt 
        else (@do_member item_type e t i)
/-
Note: Typeclass inference populates the instance 
cache at the colon. Here we introduce [decidable_eq 
item_type] after the colon, so it would ordinarily
not be found, as required, to evaluate "if (h = i)". 
The exactI tactic forces update of the typeclass
instance cache, thus including the instance foundby
[decidable_eq item_type] in the instances available
for evaluating the conditional. Fore more info, see 
https://leanprover-community.github.io/mathlib_docs/tactics.html
-/

def do_insert 
    {item_type : Type u} 
    [d : decidable_eq item_type] : 
    list item_type → item_type → list item_type 
| l a := if (do_member l a) then l else a::l    

def do_remove 
    {item_type : Type u} 
    [decidable_eq item_type] : 
    list item_type → item_type → list item_type 
| list.nil _ := list.nil
| (h::t) i := 
    if (h = i) 
    then do_remove t i
    else h::(do_remove t i)

def do_empty 
    {item_type : Type u}
    [decidable_eq item_type] :
    list item_type → list item_type := 
λ _, []

/-
And finally our implementation of the collection
concept (abstract interface) when using lists as
the storage mechanism.
-/

instance : collection.has_collection list := 
⟨
  @do_init,
  @do_member,
  @do_insert,
  @do_remove,
  @do_empty,
⟩