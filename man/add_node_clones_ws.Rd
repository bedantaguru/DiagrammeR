% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_node_clones_ws.R
\name{add_node_clones_ws}
\alias{add_node_clones_ws}
\title{Add clones of a selection of nodes}
\usage{
add_node_clones_ws(graph, add_edges = FALSE, direction = NULL,
  label = NULL)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph}.}

\item{add_edges}{an option for whether to
add edges from the selected nodes to each
of their clones, or, in the opposite
direction.}

\item{direction}{using \code{from} will
create new edges from existing nodes to
the new, cloned nodes. The \code{to} option
will create new edges directed toward the
existing nodes.}

\item{label}{an optional vector of node
label values. The vector length should
correspond to the number of nodes in the
active selection of nodes.}
}
\value{
a graph object of class
\code{dgr_graph}.
}
\description{
Add new nodes to a
graph object of class \code{dgr_graph}
which are clones of nodes in an active
selection of nodes. All node attributes
are preserved except for the node
\code{label} attribute (to maintain the
uniqueness of non-\code{NA} node label
values). A vector of node \code{label}
can be provided to bind new labels
to the cloned nodes.
}
\examples{
\dontrun{
# Create a graph with a path of
# nodes; supply `label`, `type`,
# and `value` node attributes,
# and select the created nodes
graph <-
  create_graph() \%>\%
  add_path(
    n = 3,
    label = c("d", "g", "r"),
    type = c("a", "b", "c")) \%>\%
  select_last_nodes_created()

# Display the graph's internal
# node data frame
graph \%>\%
  get_node_df()
#>   id type label
#> 1  1    a     d
#> 2  2    b     g
#> 3  3    c     r

# Create clones of all nodes
# in the selection but assign
# new node label values
# (leaving `label` as NULL
# yields NA values)
graph <-
  graph \%>\%
  add_node_clones_ws(
    label = c("a", "b", "v"))

# Display the graph's internal
# node data frame: nodes `4`,
# `5`, and `6` are clones of
# `1`, `2`, and `3`
graph \%>\%
  get_node_df()
#>   id type label
#> 1  1    a     d
#> 2  2    b     g
#> 3  3    c     r
#> 4  4    a     a
#> 5  5    b     b
#> 6  6    c     v

# Select the last nodes
# created (`4`, `5`, and `6`)
# and clone those nodes and
# their attributes while
# creating new edges between
# the new and existing nodes
graph <-
  graph \%>\%
  select_last_nodes_created() \%>\%
  add_node_clones_ws(
    add_edges = TRUE,
    direction = "to",
    label = c("t", "z", "s"))

# Display the graph's internal
# edge data frame; there are
# edges between the selected
# nodes and their clones
graph \%>\%
  get_edge_df()
#>   id from to  rel
#> 1  1    1  2 <NA>
#> 2  2    2  3 <NA>
#> 3  3    4  7 <NA>
#> 4  4    5  8 <NA>
#> 5  5    6  9 <NA>
}
}
