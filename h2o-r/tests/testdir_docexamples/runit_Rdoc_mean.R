


test.rdocmean.golden <- function() {

prosPath <- locate("smalldata/extdata/prostate.csv")
prostate.hex <- h2o.uploadFile(path = prosPath, destination_frame = "prostate.hex")
mean(prostate.hex$AGE)


}

doTest("R Doc Mean", test.rdocmean.golden)
