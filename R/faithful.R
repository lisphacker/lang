plot.cluster.fits <- function(X, nc) {
    plot(1:nc, lapply(1:10, function (nc) { sum(kmeans(sf, centers = nc)$tot.withins) }))
}
