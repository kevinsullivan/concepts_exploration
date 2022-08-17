# Insights emerging from construction attempt

## This content was moved to Overleaf; edit it if at all over there

- We show a path to produce certified implementaitons of Jacksonian conepts
- Concepts are clearly related to types. We show they implementable as typeclasses
- There is a strong analogy here with the carrier set / algebraic structure dichotomy
- This demonstration opens up a constructive way to view "concepts" (the type and instances)
  - Our analysis reveals more complete parameterization of trash concept
  - In Jackson trash example is "when" a precondition or just a conditional
  - It also reveals subtleties: e.g., create x ; delete x; create x; restore x
    - certainly not a theorem that x \in available \iff x \notin trashed
    - possible loss of data situation: if "equality" is just by file name
  - Our analysis reveals underlying type theory implicit in Jackson's notion of the "concept"
    - Needs to be a compelling argument here backed up by strong reasoning
  - Our solution provides a path to libraries of composable concept implementations
    - We evaluate this claim by exhibiting a small but sufficient demonstration prototype
- We've found, if not discovered, an edge case: ((create, remove create, restore) x)
- Note for a different project: Governance rooted in *trusted* data science pipeline infrastructures (information flow, Aidong?)
- we signiicantly generalize the algebra of these one_user_error_tolerant containers
- this library as a case study in Jacksonian conceptual design
  - crucial separation of conceptual concerns: "collection [impl] [item]" from "trash [impl][item]," which  comprises a *pair of collections* with operations for moving elements into and out of these collections following the laws that govern these trashable collections (but they're really not yet "collections," per se, in that they don't implement the "collection" interface exactly)
- doing all of this reveals possibilities for further generalizations; rather than a pair of collections using the same implementation, as an example, have a trashable collection use two different implementations of collection. Perhaps the objects in the trash are kept on cheaper but slower storage?
- decidable equality for types that can be in collections, so that's a (parametric) concept
- Our already working system is a terrific testbed for now specifying and verifying the behaviors of our collections, polymorphic in both implementation data type and element type. What remains is to work out the details. One can already simulate the edge case
- exercises:
  - provide a different collection data structure
  - specify/verify the laws of collection behavior
  - specify/verify the laws of trash behaviors
- conceptual confusion? empty trash vs empty collection
- does trash, a collection with undelete, specialize collection? (at present, no; might it?)
- TODO: clear up the notion of operational principles
  - Are they the algebraic laws of the concept
  - Or as suggested (p.49) are they just illustrative scenarios (a few theorems. not complete)
- Support for heterogeneous collection types for available and trashed items
  - items in trash auto-deleted after period of time
  - items in trash moved to slower, cheaper store
  - Apple's original "failure": available=folder but trashed=list (no single delete, add dates)
- A cost of what we're doing is the necessity of completeness of some form, whereas the sketchy approach in the book, well, who knows?
- In the lessons at the end of chapter 4, Jackson notes that concepts are generic and can often be applied to many kinds of data. We see here just how that works. It really is genericism in that you generally have to provide a new implementation for each type; e.g., an implementation of collection for lists will differ from one for trees.
- Proof assistants are useful for formalizing concepts because they allow precise expression of behaviors, especially of the *laws* governing them (of which operational principles are a subset?)

