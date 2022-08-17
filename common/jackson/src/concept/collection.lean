namespace collection

universe u

class has_collection (collection_type : Type u → Type u) :=
-- ACTIONS ("CONSTANTS AND OPERATIONS")
-- empty/starting state for a collection

(init : 
  ∀ (item_type: Type u) 
    [decidable_eq item_type], 
  collection_type item_type) 

-- Boolean-returning membership predicate function
(member : 
  ∀ {item_type: Type u} 
    [decidable_eq item_type], 
  collection_type item_type → 
  item_type → 
  bool)
  
-- add given element to collection, no-op if it's already a member
(insert : 
  ∀ {item_type: Type u} 
    [decidable_eq item_type], 
  collection_type item_type → 
  item_type → 
  collection_type item_type)

-- remove given element from collection, no-op if it's already missing
(remove : 
  ∀ {item_type: Type u} 
    [decidable_eq item_type], 
  collection_type item_type → 
  item_type → 
  collection_type item_type)

-- given any collection return an empty collection of the same kind
(empty : 
  ∀ {item_type: Type u} 
    [decidable_eq item_type], 
  collection_type item_type → 
  collection_type item_type)  -- delegate

-- LAWS ("operational principle")
-- TBD
end collection