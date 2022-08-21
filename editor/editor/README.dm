# RemoteEditor {T : Type} (r : Remote T) [has_edit T]]

Contribution:

An instance of this concept gives the user a way to interact with a 
remote instance of a given concept, T.  For each operation, o, on T
there is a new operation, o_req transmitting an asych request to call
the back-end implementation of o, along with return handling.

Examples:

(RemoteEditor (Remote int)) enables editing of a remote int.
(RemoteEditor (Collection (Remote int))) to edit a collection of int.
(RemoteEditor MoD_Cause) to edit a single value of the enumerated type, MoD_cause
RemoteEditor (Collection MoD_Cause)) -- a subset of the whole set of MoD contributors 
(RemoteEditor (temp : int)) -- editor for moral distress temperature concept instance on back end
(RemoteEditor MoD_report) -- construct/change whole MoD report, including a (Collection MoD_Cause) 
(RemoteEditor (Collection MoD_report) -- basically just as in MoD app
(ModApp)

How do the pieces compose into whole apps?