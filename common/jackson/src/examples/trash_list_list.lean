import ..concept.trash
import ..implementation.collection_list

/-
This file provides a builder of typeclass
instances for implementations of collection
with trash using lists as a storage mechanism
and parametrically polymorphic in collection
element type.  
-/

open trash

universe u

instance trash_list_list_α 
  (item_type : Type u)
  [decidable_eq item_type] : 
  has_trash list list item_type :=
⟨
  "List-based collection of α-type elements", 
  "Enable undo of deletions",
  @trash.do_init list _ list _ item_type _,
  @trash.do_create list _ list _ item_type _,
  @trash.do_remove list _ list _ item_type _,
  @trash.do_restore list _ list _ item_type _,
  @trash.do_empty list _ list _ item_type _,
⟩ 

/-
TODO: Do we now also let element types differ 
across the two collections? Precise and general
parameterization have opened up a combinatorial
space of possibilities.
TODO: We're not inheriting from our concept API.
-/