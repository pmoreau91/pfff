
(* dependency structure matrix *)
type dm = {
  matrix: int array array;
  name_to_i: (Graph_code.node, int) Hashtbl.t;
  i_to_name: (int, Graph_code.node) Hashtbl.t;
  config: config;
}
  and config = tree
  and tree =
    | Node of Graph_code.node * tree list

val verbose: bool ref

(* just the expanded root *)
val basic_config: Graph_code.graph -> config

val build:
  config -> dm option (* full matrix *) -> Graph_code.graph -> dm

val build_full_matrix:
  Graph_code.graph -> dm

val explain_cell_list_use_edges: 
  (int * int) -> dm -> Graph_code.graph ->
  (Graph_code.node * Graph_code.node) list

(* todo: * transitive *)
type deps_style = 
  | DepsIn
  | DepsOut
  | DepsInOut

(* tree config manipulation *)
val expand_node: 
  Graph_code.node -> tree -> Graph_code.graph -> tree
val focus_on_node:
  Graph_code.node -> deps_style -> tree -> dm -> tree

(* APIs useful for other to use *)
val final_nodes_of_tree: tree -> Graph_code.node list

(* poor's man DSM visualizer (use codegraph for real visualization) *)
val display:
  dm -> unit
