% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_authority_centrality.R
\name{get_authority_centrality}
\alias{get_authority_centrality}
\title{Get the authority scores for nodes in the graph}
\usage{
get_authority_centrality(graph, weights_attr = NULL)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph}.}

\item{weights_attr}{an optional name of the edge
attribute to use in the adjacency matrix. If
\code{NULL} then, if it exists, the \code{weight}
edge attribute of the graph will be used.}
}
\value{
a data frame with authority scores for
each of the nodes.
}
\description{
Get the Kleinberg authority centrality
scores for all nodes in the graph.
}
\examples{
# Create a random graph using the
# `add_gnm_graph()` function
graph <-
  create_graph() \%>\%
  add_gnm_graph(
    n = 10,
    m = 15,
    set_seed = 23)

# Get the authority centrality scores
# for all nodes in the graph
get_authority_centrality(graph)
#>    id authority_centrality
#> 1   1            0.6950912
#> 2   2            0.6176471
#> 3   3            0.0000000
#> 4   4            0.0000000
#> 5   5            0.3674279
#> 6   6            0.3157923
#> 7   7            0.4982552
#> 8   8            1.0000000
#> 9   9            0.1824629
#> 10 10            0.6176471

# Add the authority centrality
# scores to the graph as a node
# attribute
graph <-
  graph \%>\%
  join_node_attrs(
    df = get_authority_centrality(.))

# Display the graph's node data frame
get_node_df(graph)
#>    id type label authority_centrality
#> 1   1 <NA>  <NA>            0.6950912
#> 2   2 <NA>  <NA>            0.6176471
#> 3   3 <NA>  <NA>            0.0000000
#> 4   4 <NA>  <NA>            0.0000000
#> 5   5 <NA>  <NA>            0.3674279
#> 6   6 <NA>  <NA>            0.3157923
#> 7   7 <NA>  <NA>            0.4982552
#> 8   8 <NA>  <NA>            1.0000000
#> 9   9 <NA>  <NA>            0.1824629
#> 10 10 <NA>  <NA>            0.6176471
}
