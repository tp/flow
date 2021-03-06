(**
 * Copyright (c) 2014, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "flow" directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 *)

open Utils

type env = Scope.t list

type t
type metadata = {
  checked: bool;
  weak: bool;
  munge_underscores: bool;
  verbose: int option;
  is_declaration_file: bool;
}
type module_exports_type =
  | CommonJSModule of Loc.t option
  | ESModule

val make: metadata -> Loc.filename -> string -> t

(* accessors *)
val annot_table: t -> (Loc.t, Type.t) Hashtbl.t
val envs: t -> env IMap.t
val errors: t -> Errors_js.ErrorSet.t
val error_suppressions: t -> Errors_js.ErrorSuppressions.t
val file: t -> Loc.filename
val find_props: t -> Constraint_js.ident -> Type.properties
val find_module: t -> string -> Type.t
val globals: t -> SSet.t
val graph: t -> Constraint_js.node IMap.t
val is_checked: t -> bool
val is_verbose: t -> bool
val is_weak: t -> bool
val is_declaration_file: t -> bool
val module_exports_type: t -> module_exports_type
val module_map: t -> Type.t SMap.t
val module_name: t -> string
val property_maps: t -> Type.properties IMap.t
val required: t -> SSet.t
val require_loc: t -> Loc.t SMap.t
val should_munge_underscores: t -> bool
val type_table: t -> (Loc.t, Type.t) Hashtbl.t
val verbose: t -> int option

val copy_of_context: t -> t

(* mutators *)
val add_env: t -> int -> env -> unit
val add_error: t -> Errors_js.error -> unit
val add_error_suppression: t -> Loc.t -> unit
val add_global: t -> string -> unit
val add_module: t -> string -> Type.t -> unit
val add_property_map: t -> Constraint_js.ident -> Type.properties -> unit
val add_require: t -> string -> Loc.t -> unit
val add_tvar: t -> Constraint_js.ident -> Constraint_js.node -> unit
val remove_all_errors: t -> unit
val remove_all_error_suppressions: t -> unit
val remove_tvar: t -> Constraint_js.ident -> unit
val set_envs: t -> env IMap.t -> unit
val set_globals: t -> SSet.t -> unit
val set_graph: t -> Constraint_js.node IMap.t -> unit
val set_module_exports_type: t -> module_exports_type -> unit
val set_property_maps: t -> Type.properties IMap.t -> unit
val set_tvar: t -> Constraint_js.ident -> Constraint_js.node -> unit
