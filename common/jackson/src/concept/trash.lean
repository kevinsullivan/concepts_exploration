import .concept
import .collection
import tactic.cache

namespace trash

universe u

open collection

/-
The type of the state of a system instance
is a pair of collections: available and trashed.
-/
def trash_state 
  (available_collection_type : Type u → Type u) 
  [collection.has_collection available_collection_type]
  (trash_collection_type : Type u → Type u) 
  [collection.has_collection trash_collection_type]
  (item_type : Type u) [decidable_eq item_type] :=
(available_collection_type item_type) × (trash_collection_type item_type)


def do_init 
  (available_collection_type : Type u → Type u)  
  [c₁ : collection.has_collection available_collection_type] 
  (trash_collection_type : Type u → Type u) 
  [c₂ : collection.has_collection trash_collection_type]
  (item_type : Type u) 
  [e : decidable_eq item_type] :=
(
  (@collection.has_collection.init available_collection_type c₁ item_type e), 
  (@collection.has_collection.init trash_collection_type c₂ item_type e)
)


def do_create 
  {available_collection_type : Type u → Type u} 
  [has_collection available_collection_type ] 
  (trash_collection_type : Type u → Type u) 
  [has_collection trash_collection_type]
  {item_type : Type u}
  [decidable_eq item_type] 
  (item : item_type)
  (pre_state : trash_state available_collection_type trash_collection_type item_type) :
  (trash_state available_collection_type trash_collection_type item_type) :=
  match pre_state with (available, trashed) := 
    if (has_collection.member available item)
      then pre_state
      else (has_collection.insert available item, trashed)
  end


def do_remove 
  {available_collection_type : Type u → Type u}
  [has_collection available_collection_type] 
  (trash_collection_type : Type u → Type u) 
  [has_collection trash_collection_type]
  {item_type : Type u}
  [decidable_eq item_type] 
  (item : item_type)
  (pre_state : trash_state available_collection_type trash_collection_type item_type) :
  trash_state available_collection_type trash_collection_type item_type :=
match pre_state with (available, trashed) := 
  if (has_collection.member available item)
    then 
      (has_collection.remove available item, 
      has_collection.insert trashed item)
    else
      pre_state
end


/-
Insight: We could have a trash state use two different collection implementations, 
one for available and one for trash
-/

def do_restore 
  {available_collection_type : Type u → Type u}
  [has_collection available_collection_type] 
  (trash_collection_type : Type u → Type u) 
  [has_collection trash_collection_type]
  {item_type : Type u}
  [decidable_eq item_type] 
  (item : item_type)
  (pre_state : trash_state available_collection_type trash_collection_type item_type) :
  trash_state available_collection_type trash_collection_type item_type :=
  match pre_state with (available, trashed) := 
  if (has_collection.member trashed item = tt)
    then (has_collection.insert available item, 
          has_collection.remove trashed item)
    -- note: delete x then create x followed by restore x might not work?
    else pre_state
  end


def do_empty 
  {available_collection_type : Type u → Type u}
  [has_collection available_collection_type] 
  (trash_collection_type : Type u → Type u) 
  [has_collection trash_collection_type]
  {item_type : Type u}
  [decidable_eq item_type] 
  (pre_state : trash_state available_collection_type trash_collection_type item_type) :
  trash_state available_collection_type trash_collection_type item_type :=
  match pre_state with (available, trashed) := ⟨ available, has_collection.init item_type⟩ 
  end



/-
This file presents the specification of the has_trash abstraction
as a typeclass.
-/  

/-
trash
- polymorphic in collection data structures and element type 
- requires a collection API for the given collection types
- trash state type is pair of collections of element type objects
- concept name is "trash"
- concept purpose is "to allow undoing of deletions"
- initial state is the trash_state with both collections empty
- we provide an implementation of this abstraction polymorphic in 
"available" and "trash" data structure types and an element type
- The data structure types need implementations of has_collection
- The element types must have decidable equality
-/

class has_trash  
(available_collection_type : Type u → Type u) 
[collection.has_collection available_collection_type] 
(trash_collection_type : Type u → Type u) 
[collection.has_collection trash_collection_type]
(item_type : Type u)
[decidable_eq item_type]   :=
--extends concept (trash_state available_collection_type trash_collection_type item_type)   --item_type
(name : string)

(purpose : string)

(init : -- Note: init essential but elided from examples in Jackson book
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type)

(create : 
  item_type → 
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type → 
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type)

(remove : 
  item_type → 
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type → 
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type)

(restore : 
  item_type → 
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type → 
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type)

(empty : 
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type → 
  trash_state 
    available_collection_type 
    trash_collection_type 
    item_type)

-- behavioral specifications / proof obligations here

end trash
