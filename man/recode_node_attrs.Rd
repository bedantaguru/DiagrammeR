% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recode_node_attrs.R
\name{recode_node_attrs}
\alias{recode_node_attrs}
\title{Recode a set of node attribute values}
\usage{
recode_node_attrs(graph, node_attr_from, ..., otherwise = NULL,
  node_attr_to = NULL)
}
\arguments{
\item{graph}{a graph object of class}

\item{node_attr_from}{the name of the node attribute
column from which values will be recoded.}

\item{...}{named vectors with values to be recoded.
The first component should have the value to replace
and the second should have the replacement value (in
the form \code{[to_replace] = [replacement], ...}).}

\item{otherwise}{an optional single value for
recoding any unmatched values.}

\item{node_attr_to}{an optional name of a new node
attribute to which the recoded values will be
applied. This will retain the original node
attribute and its values.}
}
\value{
a graph object of class
\code{dgr_graph}.
}
\description{
Within a graph's internal node data
frame (ndf), recode character or numeric node
attribute values. Optionally, one can specify a
replacement value for any unmatched mappings.
}
\examples{
library(magrittr)

# Create a random graph
graph <-
  create_random_graph(
    5, 10, set_seed = 3) \%>\%
  set_node_attrs(
    "shape",
    c("circle", "hexagon", "rectangle",
      "rectangle", "circle"))

# Get the graph's internal ndf to show which
# node attributes are available
get_node_df(graph)
#>   nodes type label value     shape
#> 1     1          1     2    circle
#> 2     2          2   8.5   hexagon
#> 3     3          3     4 rectangle
#> 4     4          4   3.5 rectangle
#> 5     5          5   6.5    circle

# Recode the `shape` node attribute, so that
# `circle` is recoded to `square` and that
# `rectangle` becomes `triangle`
graph <-
  graph \%>\%
  recode_node_attrs(
    "shape",
    "circle" = "square",
    "rectangle" = "triangle")

# Get the graph's internal ndf to show that the
# node attribute values had been recoded
get_node_df(graph)
#>   nodes type label value    shape
#> 1     1          1     2   square
#> 2     2          2   8.5  hexagon
#> 3     3          3     4 triangle
#> 4     4          4   3.5 triangle
#> 5     5          5   6.5   square

# Create a new node attribute, called `color`,
# that is based on a recoding of `shape`; here,
# map the square shape to a `red` color and map
# all other shapes to a `green` color
graph <-
  graph \%>\%
  recode_node_attrs(
    "shape",
    "square" = "red",
    otherwise = "green",
    node_attr_to = "color")

# Get the graph's internal ndf to see the change
get_node_df(graph)
#>   nodes type label value    shape color
#> 1     1          1     2   square   red
#> 2     2          2   8.5  hexagon green
#> 3     3          3     4 triangle green
#> 4     4          4   3.5 triangle green
#> 5     5          5   6.5   square   red
}
