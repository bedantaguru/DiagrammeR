#' Get community membership by modularity optimization
#' @description Through the use of greedy
#' optimization of a modularity score, obtain
#' the group membership values for each of the
#' nodes in the graph. Note that this method
#' only works on graphs without multiple edges.
#' @param graph a graph object of class
#' \code{dgr_graph}.
#' @return a data frame with group membership
#' assignments for each of the nodes.
#' @examples
#' # Create a graph with a
#' # balanced tree
#' graph <-
#'   create_graph() %>%
#'   add_balanced_tree(
#'     k = 2,
#'     h = 2)
#'
#' # Get the group membership values for all
#' # nodes in the graph through the greedy
#' # optimization of modularity algorithm
#' get_cmty_fast_greedy(graph)
#' #>   id f_g_group
#' #> 1  1         1
#' #> 2  2         2
#' #> 3  3         1
#' #> 4  4         2
#' #> 5  5         2
#' #> 6  6         1
#' #> 7  7         1
#'
#' # Add the group membership values to the
#' # graph as a node attribute
#' graph <-
#'   graph %>%
#'   join_node_attrs(
#'     df = get_cmty_fast_greedy(.))
#'
#' # Display the graph's node data frame
#' get_node_df(graph)
#' #>   id type label f_g_group
#' #> 1  1 <NA>     1         1
#' #> 2  2 <NA>     2         2
#' #> 3  3 <NA>     3         1
#' #> 4  4 <NA>     4         2
#' #> 5  5 <NA>     5         2
#' #> 6  6 <NA>     6         1
#' #> 7  7 <NA>     7         1
#' @importFrom igraph cluster_fast_greedy membership
#' @export get_cmty_fast_greedy

get_cmty_fast_greedy <- function(graph) {

  # Validation: Graph object is valid
  if (graph_object_valid(graph) == FALSE) {
    stop("The graph object is not valid.")
  }

  # If graph is directed, transform to undirected
  graph <- set_graph_undirected(graph)

  # Convert the graph to an igraph object
  ig_graph <- to_igraph(graph)

  # Get the community object using the
  # `cluster_fast_greedy()` function
  cmty_fast_greedy_obj <-
    igraph::cluster_fast_greedy(ig_graph)

  # Create df with node memberships
  data.frame(
    id = igraph::membership(cmty_fast_greedy_obj) %>% names() %>% as.integer(),
    f_g_group = as.vector(igraph::membership(cmty_fast_greedy_obj)),
    stringsAsFactors = FALSE)
}
