


test.pub_699_negative_indexes <- function() {

  prostatePath = locate("smalldata/prostate/prostate.csv")
  prostate.hex = h2o.importFile(path = prostatePath, destination_frame = "prostate.hex")
  
  prostate.local = as.data.frame(prostate.hex)
  
  # Are we in the right universe?
  expect_equal(380, dim(prostate.local)[1])
  expect_equal(9, dim(prostate.local)[2])
  
  print("Simple row exclusion")
  expect_equal(100, dim(prostate.local[-101:-380,])[1])
  expect_equal(100, dim(prostate.hex[-101:-380,])[1])
  
  print("Simple column exclusion")
  expect_equal(7, dim(prostate.local[,-8:-9,])[2])
  expect_equal(7, dim(prostate.hex[,-8:-9,])[2])
  
  print("List row exclusion")
  expect_equal(378, dim(prostate.local[c(-101, -110),])[1])
  expect_equal(378, dim(prostate.hex[c(-101, -110),])[1])
  
  print("List column exclusion")
  expect_equal(6, dim(prostate.local[,c(-1, -3, -5),])[2])
  expect_equal(6, dim(prostate.hex[,c(-1, -3, -5),])[2])
  
  Log.info("Check that OOB indexes are ignored...")
  expect_equal(380, dim(prostate.hex[1:9820,])[1])
  expect_equal(  0, dim(prostate.hex[-9820:-1,])[1])

  Log.info("Check that mixed positive and negative is an error")
  expect_error(dim(prostate.hex[-1000:9230,]))

  Log.info("Now trying with a multi-chunk data set")

  covtype <- h2o.importFile(normalizePath(locate("smalldata/covtype/covtype.altered.gz")), "cov")

  Log.info("Number of columns & rows in covtype")
  print(dim(covtype))

  print(covtype)

  slice_range_across_chunks <- c(-1:-50, -40000:-45000)

  Log.info("Number of rows to slice out")
  print(length(slice_range_across_chunks))

  sliced_cov <- covtype[slice_range_across_chunks,]

  Log.info("sliced covtype dimensions:")
  print(dim(sliced_cov))

  Log.info("Check that we have the difference in rows equal to the length of the slice_range_across_chunks variable")
  print(nrow(covtype) - nrow(sliced_cov))

  expect_equal(length(slice_range_across_chunks), nrow(covtype) - nrow(sliced_cov))



}

doTest("PUB-699 negative indexes should work for both rows and columns", test.pub_699_negative_indexes)

