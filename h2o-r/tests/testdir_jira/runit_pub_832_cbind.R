


test.pub_832_cbind <- function() {

prostatePath <- locate("smalldata/prostate/prostate.csv")
prostate.hex <- h2o.importFile(path = prostatePath, destination_frame = "prostate.hex")

new_col <- h2o.runif(prostate.hex, 10)
bound.hex <- h2o.cbind(prostate.hex, new_col)

expect_that(dim(bound.hex)[1], equals(dim(prostate.hex)[1]))
expect_that(dim(bound.hex)[2], equals(1 + dim(prostate.hex)[2]))


}

doTest("PUB-832 cbind vector group error", test.pub_832_cbind)

