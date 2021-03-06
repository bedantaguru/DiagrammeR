#' Get community membership by edge betweenness
#' @description Using edge betweenness, obtain the
#' group membership values for each of the nodes in
#' the graph.
#' @param graph a graph object of class
#' \code{dgr_graph}.
#' @return a data frame with group membership
#' assignments for each of the nodes.
#' @examples
#' # Create a random graph using the
#' # `add_gnm_graph()` function
#' graph <-
#'   create_graph(
#'     directed = FALSE) %>%
#'   add_gnm_graph(
#'     n = 10,
#'     m = 15,
#'     set_seed = 23)
#'
#' # Get the group membership values for all nodes
#' # in the graph through calculation of the leading
#' # non-negative eigenvector of the modularity matrix
#' # of the graph
#' get_cmty_edge_btwns(graph)
#' #>    id edge_btwns_group
#' #> 1   1                1
#' #> 2   2                2
#' #> 3   3                2
#' #> 4   4                3
#' #> 5   5                2
#' #> 6   6                2
#' #> 7   7                1
#' #> 8   8                3
#' #> 9   9                3
#' #> 10 10                4
#'
#' # Add the group membership
#' # values to the graph
#' # as a node attribute
#' graph <-
#'   graph %>%
#'   join_node_attrs(
#'      df = get_cmty_edge_btwns(.))
#'
#' # Display the graph's node data frame
#' get_node_df(graph)
#' #>    id type label edge_btwns_group
#' #> 1   1 <NA>  <NA>                1
#' #> 2   2 <NA>  <NA>                2
#' #> 3   3 <NA>  <NA>                2
#' #> 4   4 <NA>  <NA>                3
#' #> 5   5 <NA>  <NA>                2
#' #> 6   6 <NA>  <NA>                2
#' #> 7   7 <NA>  <NA>                1
#' #> 8   8 <NA>  <NA>                3
#' #> 9   9 <NA>  <NA>                3
#' #> 10 10 <NA>  <NA>                4
#' @importFrom igraph cluster_edge_betweenness membership
#' @export get_cmty_edge_btwns

get_cmty_edge_btwns <- function(graph) {

  # Validation: Graph object is valid
  if (graph_object_valid(graph) == FALSE) {
    stop("The graph object is not valid.")
  }

  # Convert the graph to an igraph object
  ig_graph <- to_igraph(graph)

  # Get the community object using the
  # `cluster_edge_betweenness()` function
  cmty_edge_btwns_obj <-
    igraph::cluster_edge_betweenness(
      graph = ig_graph)

  # Create df with node memberships
  data.frame(
    id = igraph::membership(cmty_edge_btwns_obj) %>% names() %>% as.integer(),
    edge_btwns_group = as.vector(igraph::membership(cmty_edge_btwns_obj)),
    stringsAsFactors = FALSE)
}
