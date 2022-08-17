class has_gui_ux (T : Type)
class has_dart_impl (T : Type)
class has_open_rep (T : Type)
class has_store_rep (T : Type)

class Editor (T : Type) 

  -- vaguely a specification of user interactions including events on which can synch
  
  [has_gui_ux  T]     -- some description of intended user experience
  [has_gui_widget T]  -- a choice of a particular form of UI

  /-
  For each op, there's a corresponding Bloc event object.
  The object that posts these events to the bloc is the UI Dart object
    - has an external interface that mirrors the concept
    - the impls of the ops "delegate" to the back by by 
      invoking the bloc with the right operation event
  -/
  -- a schema definition for an api.yaml file for T
  -- [has_open_api_spec T]   -- api.yaml
  [has_REST_spec T]   -- scattered and tangled across api.yaml
  [has_cloud_spec T]      -- scattered and tangled across api.yaml
  [has_open_schema T]
  -- reason scattered and tangled is pieces are given for each operation (path)

/-
Having the open api schema enables autogeneration of a T_state Dart class. 
It also enables autogeneration of T_state JSON objects, needed for serialization.
But to produce the T Dart class that our framework requires, we need to (1) extend
the auto-generated T_state Dart class with specifications and implementations of the 
operations of T, and implement these operations by hand. 
-/

  -- a dart class fully implementing the underlying concept: state, ops, invariants
  [has_dart_impl T]      -- rep of the complete abstract concept including operations
  
  -- a REST-based back-end implementing state and of operations of the underlying concept
  [has_store_rep T]   -- REST interface and back-end implementation