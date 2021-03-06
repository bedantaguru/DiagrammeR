% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rescale_edge_attrs.R
\name{rescale_edge_attrs}
\alias{rescale_edge_attrs}
\title{Rescale numeric edge attribute values}
\usage{
rescale_edge_attrs(graph, edge_attr_from, to_lower_bound = 0,
  to_upper_bound = 1, edge_attr_to = NULL, from_lower_bound = NULL,
  from_upper_bound = NULL)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph}.}

\item{edge_attr_from}{the edge attribute containing
numeric data that is to be rescaled to new numeric
or color values.}

\item{to_lower_bound}{the lower bound value for the
set of rescaled values. This can be a numeric value
or an X11 color name.}

\item{to_upper_bound}{the upper bound value for the
set of rescaled values. This can be a numeric value
or an X11 color name.}

\item{edge_attr_to}{an optional name of a new edge
attribute to which the recoded values will be
applied. This will retain the original edge
attribute and its values.}

\item{from_lower_bound}{an optional, manually set
lower bound value for the rescaled values. If not
set, the minimum value from the set will be used.}

\item{from_upper_bound}{an optional, manually set
upper bound value for the rescaled values. If not
set, the minimum value from the set will be used.}
}
\value{
a graph object of class \code{dgr_graph}.
}
\description{
From a graph object of class
\code{dgr_graph}, take a set of numeric values for
an edge attribute, rescale to a new numeric or color
range, then write to the same edge attribute or to
a new edge attribute column.
}
\examples{
# Create a random graph using the
# `add_gnm_graph()` function
graph <-
  create_graph() \%>\%
  add_gnm_graph(
    n = 10,
    m = 7,
    set_seed = 23) \%>\%
  set_edge_attrs(
    edge_attr = weight,
    values = rnorm(
      n = count_edges(.),
      mean = 5,
      sd = 1))

# Get the graph's internal edf
# to show which edge attributes
# are available
get_edge_df(graph)
#>   id from to  rel   weight
#> 1  1    2  8 <NA> 5.045437
#> 2  2    4  2 <NA> 6.575780
#> 3  3    4  6 <NA> 5.218288
#> 4  4    4  9 <NA> 3.953465
#> 5  5    6  5 <NA> 4.711311
#> 6  6    6 10 <NA> 5.481550
#> 7  7   10  9 <NA> 3.783624

# Rescale the `weight` edge
# attribute, so that its values
# are rescaled between 0 and 1
graph <-
  graph \%>\%
  rescale_edge_attrs(
    edge_attr_from = weight,
    to_lower_bound = 0,
    to_upper_bound = 1)

# Get the graph's internal edf
# to show that the edge attribute
# values had been rescaled
get_edge_df(graph)
#>   id from to  rel weight
#> 1  1    2  8 <NA>  0.452
#> 2  2    4  2 <NA>  1.000
#> 3  3    4  6 <NA>  0.514
#> 4  4    4  9 <NA>  0.061
#> 5  5    6  5 <NA>  0.332
#> 6  6    6 10 <NA>  0.608
#> 7  7   10  9 <NA>  0.000

# Scale the values in the `weight`
# edge attribute to different
# shades of gray for the `color`
# edge attribute and different
# numerical values for the
# `penwidth` attribute
graph <-
  graph \%>\%
  rescale_edge_attrs(
    edge_attr_from = weight,
    to_lower_bound = "gray80",
    to_upper_bound = "gray20",
    edge_attr_to = color) \%>\%
  rescale_edge_attrs(
    edge_attr_from = weight,
    to_lower_bound = 0.5,
    to_upper_bound = 3,
    edge_attr_to = penwidth)

# Get the graph's internal edf
# once more to show that scaled
# grayscale colors are now available
# in `color` and scaled numerical
# values are in the `penwidth`
# edge attribute
get_edge_df(graph)
#>   id from to  rel weight   color penwidth
#> 1  1    2  8 <NA>  0.452 #838383    1.630
#> 2  2    4  2 <NA>  1.000 #333333    3.000
#> 3  3    4  6 <NA>  0.514 #797979    1.785
#> 4  4    4  9 <NA>  0.061 #C2C2C2    0.652
#> 5  5    6  5 <NA>  0.332 #959595    1.330
#> 6  6    6 10 <NA>  0.608 #6B6B6B    2.020
#> 7  7   10  9 <NA>  0.000 #CCCCCC    0.500
}
