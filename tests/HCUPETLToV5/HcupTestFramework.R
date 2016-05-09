initFramework <- function() {
  insertSql <- c()
  insertSql <- c(insertSql, "TRUNCATE TABLE core;")
  insertSql <- c(insertSql, "TRUNCATE TABLE dx_pr_grps;")
  insertSql <- c(insertSql, "TRUNCATE TABLE hospital;")
  insertSql <- c(insertSql, "TRUNCATE TABLE severity;")
  assign("insertSql", insertSql, envir = globalenv())
  testSql <- c()
  testSql <- c(testSql, "IF OBJECT_ID('test_results', 'U') IS NOT NULL")
  testSql <- c(testSql, "  DROP TABLE test_results;")
  testSql <- c(testSql, "")
  testSql <- c(testSql, "CREATE TABLE test_results (id INT, description VARCHAR(512), test VARCHAR(256), status VARCHAR(5));")
  testSql <- c(testSql, "")
  assign("testSql", testSql, envir = globalenv()) 
  assign("testId", 1, envir = globalenv()) 
  assign("testDescription", "", envir = globalenv()) 
}

initFramework()

declareTest <- function(id, description) {
  assign("testId", id, envir = globalenv()) 
  assign("testDescription", description, envir = globalenv()) 
  sql <- c("", paste0("-- ", id, ": ", description))
  assign("insertSql", c(get("insertSql", envir = globalenv()), sql), envir = globalenv())
  assign("testSql", c(get("testSql", envir = globalenv()), sql), envir = globalenv())
}

add_core <- function(key = "List truncated...", female = "1", age = "0", ageday = "-99", race = "1", year = "2006", amonth = "-9", asource = "5", asource_x = "   ", atype = "1", aweekend = "0", los = "2", died = "0", discwt = "4.6286", dispub92 = NULL, dispuniform = "1", dqtr = "1", drg = "391", drg18 = NULL, drgver = "22", dshospid = "             ", dx1 = "V3000", dx2 = "     ", dx3 = "     ", dx4 = "     ", dx5 = "     ", dx6 = "     ", dx7 = "     ", dx8 = "     ", dx9 = "     ", dx10 = "4019", dx11 = "4019", dx12 = "     ", dx13 = "     ", dx14 = "     ", dx15 = "     ", dxccs1 = "218", dxccs2 = "-999", dxccs3 = "-999", dxccs4 = "-999", dxccs5 = "-999", dxccs6 = "-999", dxccs7 = "-999", dxccs8 = "-999", dxccs9 = "-999", dxccs10 = "-999", dxccs11 = "-999", dxccs12 = "-999", dxccs13 = "-999", dxccs14 = "-999", dxccs15 = "-999", hospid = "51043", hospst = "CA", hospstco = NULL, los_x = "2", mdc = "5", mdc18 = NULL, mdnum1_s = NULL, mdnum2_s = NULL, ndx = "9", neomat = "0", nis_stratum = "3033", npr = "0", pay1 = "1", pay1_x = "C         ", pay2 = "-9", pay2_x = "          ", pr1 = "    ", pr2 = "    ", pr3 = "    ", pr4 = "    ", pr5 = "    ", pr6 = "8853", pr7 = "    ", pr8 = "    ", pr9 = "    ", pr10 = "    ", pr11 = "    ", pr12 = "    ", pr13 = "    ", pr14 = "    ", pr15 = "    ", prccs1 = "-99", prccs2 = "-99", prccs3 = "-99", prccs4 = "-99", prccs5 = "-99", prccs6 = "-99", prccs7 = "-99", prccs8 = "-99", prccs9 = "-99", prccs10 = "-99", prccs11 = "-99", prccs12 = "-99", prccs13 = "-99", prccs14 = "-99", prccs15 = "-99", prday1 = "-99", prday2 = "-99", prday3 = "-99", prday4 = "-99", prday5 = "-99", prday6 = "-99", prday7 = "-99", prday8 = "-99", prday9 = "-99", prday10 = "-99", prday11 = "-99", prday12 = "-99", prday13 = "-99", prday14 = "-99", prday15 = "-99", totchg = "-999999999", totchg_x = "-99999999999.99", zipinc = NULL, discwtcharge = NULL, mdid_s = NULL, surgid_s = NULL, asourceub92 = " ", dispub04 = NULL, dqtr_x = NULL, drg24 = NULL, drg_nopoa = NULL, dx16 = NULL, dx17 = NULL, dx18 = NULL, dx19 = NULL, dx20 = NULL, dx21 = NULL, dx22 = NULL, dx23 = NULL, dx24 = NULL, dx25 = NULL, dxccs16 = NULL, dxccs17 = NULL, dxccs18 = NULL, dxccs19 = NULL, dxccs20 = NULL, dxccs21 = NULL, dxccs22 = NULL, dxccs23 = NULL, dxccs24 = NULL, dxccs25 = NULL, ecode1 = "     ", ecode2 = "     ", ecode3 = "     ", ecode4 = "     ", elective = "0", e_ccs1 = "-999", e_ccs2 = "-999", e_ccs3 = "-999", e_ccs4 = "-999", hcup_ed = NULL, hospbrth = NULL, mdc24 = NULL, mdc_nopoa = NULL, nchronic = NULL, necode = "0", orproc = NULL, pl_nchs2006 = NULL, pointoforiginub04 = NULL, pointoforigin_x = NULL, tran_in = NULL, tran_out = NULL, zipinc_qrtl = NULL, mdnum1_r = NULL, mdnum2_r = NULL, pl_ur_cat4 = NULL) {
  insertFields <- c()
  insertValues <- c()
  if (!is.null(key)) {
    insertFields <- c(insertFields, "[key]")
    insertValues <- c(insertValues, key)
  }
  
  if (!is.null(female)) {
    insertFields <- c(insertFields, "female")
    insertValues <- c(insertValues, female)
  }
  
  if (!is.null(age)) {
    insertFields <- c(insertFields, "age")
    insertValues <- c(insertValues, age)
  }
  
  if (!is.null(ageday)) {
    insertFields <- c(insertFields, "ageday")
    insertValues <- c(insertValues, ageday)
  }
  
  if (!is.null(race)) {
    insertFields <- c(insertFields, "race")
    insertValues <- c(insertValues, race)
  }
  
  if (!is.null(year)) {
    insertFields <- c(insertFields, "year")
    insertValues <- c(insertValues, year)
  }
  
  if (!is.null(amonth)) {
    insertFields <- c(insertFields, "amonth")
    insertValues <- c(insertValues, amonth)
  }
  
  if (!is.null(asource)) {
    insertFields <- c(insertFields, "asource")
    insertValues <- c(insertValues, asource)
  }
  
  if (!is.null(asource_x)) {
    insertFields <- c(insertFields, "asource_x")
    insertValues <- c(insertValues, asource_x)
  }
  
  if (!is.null(atype)) {
    insertFields <- c(insertFields, "atype")
    insertValues <- c(insertValues, atype)
  }
  
  if (!is.null(aweekend)) {
    insertFields <- c(insertFields, "aweekend")
    insertValues <- c(insertValues, aweekend)
  }
  
  if (!is.null(los)) {
    insertFields <- c(insertFields, "los")
    insertValues <- c(insertValues, los)
  }
  
  if (!is.null(died)) {
    insertFields <- c(insertFields, "died")
    insertValues <- c(insertValues, died)
  }
  
  if (!is.null(discwt)) {
    insertFields <- c(insertFields, "discwt")
    insertValues <- c(insertValues, discwt)
  }
  
  if (!is.null(dispub92)) {
    insertFields <- c(insertFields, "dispub92")
    insertValues <- c(insertValues, dispub92)
  }
  
  if (!is.null(dispuniform)) {
    insertFields <- c(insertFields, "dispuniform")
    insertValues <- c(insertValues, dispuniform)
  }
  
  if (!is.null(dqtr)) {
    insertFields <- c(insertFields, "dqtr")
    insertValues <- c(insertValues, dqtr)
  }
  
  if (!is.null(drg)) {
    insertFields <- c(insertFields, "drg")
    insertValues <- c(insertValues, drg)
  }
  
  if (!is.null(drg18)) {
    insertFields <- c(insertFields, "drg18")
    insertValues <- c(insertValues, drg18)
  }
  
  if (!is.null(drgver)) {
    insertFields <- c(insertFields, "drgver")
    insertValues <- c(insertValues, drgver)
  }
  
  if (!is.null(dshospid)) {
    insertFields <- c(insertFields, "dshospid")
    insertValues <- c(insertValues, dshospid)
  }
  
  if (!is.null(dx1)) {
    insertFields <- c(insertFields, "dx1")
    insertValues <- c(insertValues, dx1)
  }
  
  if (!is.null(dx2)) {
    insertFields <- c(insertFields, "dx2")
    insertValues <- c(insertValues, dx2)
  }
  
  if (!is.null(dx3)) {
    insertFields <- c(insertFields, "dx3")
    insertValues <- c(insertValues, dx3)
  }
  
  if (!is.null(dx4)) {
    insertFields <- c(insertFields, "dx4")
    insertValues <- c(insertValues, dx4)
  }
  
  if (!is.null(dx5)) {
    insertFields <- c(insertFields, "dx5")
    insertValues <- c(insertValues, dx5)
  }
  
  if (!is.null(dx6)) {
    insertFields <- c(insertFields, "dx6")
    insertValues <- c(insertValues, dx6)
  }
  
  if (!is.null(dx7)) {
    insertFields <- c(insertFields, "dx7")
    insertValues <- c(insertValues, dx7)
  }
  
  if (!is.null(dx8)) {
    insertFields <- c(insertFields, "dx8")
    insertValues <- c(insertValues, dx8)
  }
  
  if (!is.null(dx9)) {
    insertFields <- c(insertFields, "dx9")
    insertValues <- c(insertValues, dx9)
  }
  
  if (!is.null(dx10)) {
    insertFields <- c(insertFields, "dx10")
    insertValues <- c(insertValues, dx10)
  }
  
  if (!is.null(dx11)) {
    insertFields <- c(insertFields, "dx11")
    insertValues <- c(insertValues, dx11)
  }
  
  if (!is.null(dx12)) {
    insertFields <- c(insertFields, "dx12")
    insertValues <- c(insertValues, dx12)
  }
  
  if (!is.null(dx13)) {
    insertFields <- c(insertFields, "dx13")
    insertValues <- c(insertValues, dx13)
  }
  
  if (!is.null(dx14)) {
    insertFields <- c(insertFields, "dx14")
    insertValues <- c(insertValues, dx14)
  }
  
  if (!is.null(dx15)) {
    insertFields <- c(insertFields, "dx15")
    insertValues <- c(insertValues, dx15)
  }
  
  if (!is.null(dxccs1)) {
    insertFields <- c(insertFields, "dxccs1")
    insertValues <- c(insertValues, dxccs1)
  }
  
  if (!is.null(dxccs2)) {
    insertFields <- c(insertFields, "dxccs2")
    insertValues <- c(insertValues, dxccs2)
  }
  
  if (!is.null(dxccs3)) {
    insertFields <- c(insertFields, "dxccs3")
    insertValues <- c(insertValues, dxccs3)
  }
  
  if (!is.null(dxccs4)) {
    insertFields <- c(insertFields, "dxccs4")
    insertValues <- c(insertValues, dxccs4)
  }
  
  if (!is.null(dxccs5)) {
    insertFields <- c(insertFields, "dxccs5")
    insertValues <- c(insertValues, dxccs5)
  }
  
  if (!is.null(dxccs6)) {
    insertFields <- c(insertFields, "dxccs6")
    insertValues <- c(insertValues, dxccs6)
  }
  
  if (!is.null(dxccs7)) {
    insertFields <- c(insertFields, "dxccs7")
    insertValues <- c(insertValues, dxccs7)
  }
  
  if (!is.null(dxccs8)) {
    insertFields <- c(insertFields, "dxccs8")
    insertValues <- c(insertValues, dxccs8)
  }
  
  if (!is.null(dxccs9)) {
    insertFields <- c(insertFields, "dxccs9")
    insertValues <- c(insertValues, dxccs9)
  }
  
  if (!is.null(dxccs10)) {
    insertFields <- c(insertFields, "dxccs10")
    insertValues <- c(insertValues, dxccs10)
  }
  
  if (!is.null(dxccs11)) {
    insertFields <- c(insertFields, "dxccs11")
    insertValues <- c(insertValues, dxccs11)
  }
  
  if (!is.null(dxccs12)) {
    insertFields <- c(insertFields, "dxccs12")
    insertValues <- c(insertValues, dxccs12)
  }
  
  if (!is.null(dxccs13)) {
    insertFields <- c(insertFields, "dxccs13")
    insertValues <- c(insertValues, dxccs13)
  }
  
  if (!is.null(dxccs14)) {
    insertFields <- c(insertFields, "dxccs14")
    insertValues <- c(insertValues, dxccs14)
  }
  
  if (!is.null(dxccs15)) {
    insertFields <- c(insertFields, "dxccs15")
    insertValues <- c(insertValues, dxccs15)
  }
  
  if (!is.null(hospid)) {
    insertFields <- c(insertFields, "hospid")
    insertValues <- c(insertValues, hospid)
  }
  
  if (!is.null(hospst)) {
    insertFields <- c(insertFields, "hospst")
    insertValues <- c(insertValues, hospst)
  }
  
  if (!is.null(hospstco)) {
    insertFields <- c(insertFields, "hospstco")
    insertValues <- c(insertValues, hospstco)
  }
  
  if (!is.null(los_x)) {
    insertFields <- c(insertFields, "los_x")
    insertValues <- c(insertValues, los_x)
  }
  
  if (!is.null(mdc)) {
    insertFields <- c(insertFields, "mdc")
    insertValues <- c(insertValues, mdc)
  }
  
  if (!is.null(mdc18)) {
    insertFields <- c(insertFields, "mdc18")
    insertValues <- c(insertValues, mdc18)
  }
  
  if (!is.null(mdnum1_s)) {
    insertFields <- c(insertFields, "mdnum1_s")
    insertValues <- c(insertValues, mdnum1_s)
  }
  
  if (!is.null(mdnum2_s)) {
    insertFields <- c(insertFields, "mdnum2_s")
    insertValues <- c(insertValues, mdnum2_s)
  }
  
  if (!is.null(ndx)) {
    insertFields <- c(insertFields, "ndx")
    insertValues <- c(insertValues, ndx)
  }
  
  if (!is.null(neomat)) {
    insertFields <- c(insertFields, "neomat")
    insertValues <- c(insertValues, neomat)
  }
  
  if (!is.null(nis_stratum)) {
    insertFields <- c(insertFields, "nis_stratum")
    insertValues <- c(insertValues, nis_stratum)
  }
  
  if (!is.null(npr)) {
    insertFields <- c(insertFields, "npr")
    insertValues <- c(insertValues, npr)
  }
  
  if (!is.null(pay1)) {
    insertFields <- c(insertFields, "pay1")
    insertValues <- c(insertValues, pay1)
  }
  
  if (!is.null(pay1_x)) {
    insertFields <- c(insertFields, "pay1_x")
    insertValues <- c(insertValues, pay1_x)
  }
  
  if (!is.null(pay2)) {
    insertFields <- c(insertFields, "pay2")
    insertValues <- c(insertValues, pay2)
  }
  
  if (!is.null(pay2_x)) {
    insertFields <- c(insertFields, "pay2_x")
    insertValues <- c(insertValues, pay2_x)
  }
  
  if (!is.null(pr1)) {
    insertFields <- c(insertFields, "pr1")
    insertValues <- c(insertValues, pr1)
  }
  
  if (!is.null(pr2)) {
    insertFields <- c(insertFields, "pr2")
    insertValues <- c(insertValues, pr2)
  }
  
  if (!is.null(pr3)) {
    insertFields <- c(insertFields, "pr3")
    insertValues <- c(insertValues, pr3)
  }
  
  if (!is.null(pr4)) {
    insertFields <- c(insertFields, "pr4")
    insertValues <- c(insertValues, pr4)
  }
  
  if (!is.null(pr5)) {
    insertFields <- c(insertFields, "pr5")
    insertValues <- c(insertValues, pr5)
  }
  
  if (!is.null(pr6)) {
    insertFields <- c(insertFields, "pr6")
    insertValues <- c(insertValues, pr6)
  }
  
  if (!is.null(pr7)) {
    insertFields <- c(insertFields, "pr7")
    insertValues <- c(insertValues, pr7)
  }
  
  if (!is.null(pr8)) {
    insertFields <- c(insertFields, "pr8")
    insertValues <- c(insertValues, pr8)
  }
  
  if (!is.null(pr9)) {
    insertFields <- c(insertFields, "pr9")
    insertValues <- c(insertValues, pr9)
  }
  
  if (!is.null(pr10)) {
    insertFields <- c(insertFields, "pr10")
    insertValues <- c(insertValues, pr10)
  }
  
  if (!is.null(pr11)) {
    insertFields <- c(insertFields, "pr11")
    insertValues <- c(insertValues, pr11)
  }
  
  if (!is.null(pr12)) {
    insertFields <- c(insertFields, "pr12")
    insertValues <- c(insertValues, pr12)
  }
  
  if (!is.null(pr13)) {
    insertFields <- c(insertFields, "pr13")
    insertValues <- c(insertValues, pr13)
  }
  
  if (!is.null(pr14)) {
    insertFields <- c(insertFields, "pr14")
    insertValues <- c(insertValues, pr14)
  }
  
  if (!is.null(pr15)) {
    insertFields <- c(insertFields, "pr15")
    insertValues <- c(insertValues, pr15)
  }
  
  if (!is.null(prccs1)) {
    insertFields <- c(insertFields, "prccs1")
    insertValues <- c(insertValues, prccs1)
  }
  
  if (!is.null(prccs2)) {
    insertFields <- c(insertFields, "prccs2")
    insertValues <- c(insertValues, prccs2)
  }
  
  if (!is.null(prccs3)) {
    insertFields <- c(insertFields, "prccs3")
    insertValues <- c(insertValues, prccs3)
  }
  
  if (!is.null(prccs4)) {
    insertFields <- c(insertFields, "prccs4")
    insertValues <- c(insertValues, prccs4)
  }
  
  if (!is.null(prccs5)) {
    insertFields <- c(insertFields, "prccs5")
    insertValues <- c(insertValues, prccs5)
  }
  
  if (!is.null(prccs6)) {
    insertFields <- c(insertFields, "prccs6")
    insertValues <- c(insertValues, prccs6)
  }
  
  if (!is.null(prccs7)) {
    insertFields <- c(insertFields, "prccs7")
    insertValues <- c(insertValues, prccs7)
  }
  
  if (!is.null(prccs8)) {
    insertFields <- c(insertFields, "prccs8")
    insertValues <- c(insertValues, prccs8)
  }
  
  if (!is.null(prccs9)) {
    insertFields <- c(insertFields, "prccs9")
    insertValues <- c(insertValues, prccs9)
  }
  
  if (!is.null(prccs10)) {
    insertFields <- c(insertFields, "prccs10")
    insertValues <- c(insertValues, prccs10)
  }
  
  if (!is.null(prccs11)) {
    insertFields <- c(insertFields, "prccs11")
    insertValues <- c(insertValues, prccs11)
  }
  
  if (!is.null(prccs12)) {
    insertFields <- c(insertFields, "prccs12")
    insertValues <- c(insertValues, prccs12)
  }
  
  if (!is.null(prccs13)) {
    insertFields <- c(insertFields, "prccs13")
    insertValues <- c(insertValues, prccs13)
  }
  
  if (!is.null(prccs14)) {
    insertFields <- c(insertFields, "prccs14")
    insertValues <- c(insertValues, prccs14)
  }
  
  if (!is.null(prccs15)) {
    insertFields <- c(insertFields, "prccs15")
    insertValues <- c(insertValues, prccs15)
  }
  
  if (!is.null(prday1)) {
    insertFields <- c(insertFields, "prday1")
    insertValues <- c(insertValues, prday1)
  }
  
  if (!is.null(prday2)) {
    insertFields <- c(insertFields, "prday2")
    insertValues <- c(insertValues, prday2)
  }
  
  if (!is.null(prday3)) {
    insertFields <- c(insertFields, "prday3")
    insertValues <- c(insertValues, prday3)
  }
  
  if (!is.null(prday4)) {
    insertFields <- c(insertFields, "prday4")
    insertValues <- c(insertValues, prday4)
  }
  
  if (!is.null(prday5)) {
    insertFields <- c(insertFields, "prday5")
    insertValues <- c(insertValues, prday5)
  }
  
  if (!is.null(prday6)) {
    insertFields <- c(insertFields, "prday6")
    insertValues <- c(insertValues, prday6)
  }
  
  if (!is.null(prday7)) {
    insertFields <- c(insertFields, "prday7")
    insertValues <- c(insertValues, prday7)
  }
  
  if (!is.null(prday8)) {
    insertFields <- c(insertFields, "prday8")
    insertValues <- c(insertValues, prday8)
  }
  
  if (!is.null(prday9)) {
    insertFields <- c(insertFields, "prday9")
    insertValues <- c(insertValues, prday9)
  }
  
  if (!is.null(prday10)) {
    insertFields <- c(insertFields, "prday10")
    insertValues <- c(insertValues, prday10)
  }
  
  if (!is.null(prday11)) {
    insertFields <- c(insertFields, "prday11")
    insertValues <- c(insertValues, prday11)
  }
  
  if (!is.null(prday12)) {
    insertFields <- c(insertFields, "prday12")
    insertValues <- c(insertValues, prday12)
  }
  
  if (!is.null(prday13)) {
    insertFields <- c(insertFields, "prday13")
    insertValues <- c(insertValues, prday13)
  }
  
  if (!is.null(prday14)) {
    insertFields <- c(insertFields, "prday14")
    insertValues <- c(insertValues, prday14)
  }
  
  if (!is.null(prday15)) {
    insertFields <- c(insertFields, "prday15")
    insertValues <- c(insertValues, prday15)
  }
  
  if (!is.null(totchg)) {
    insertFields <- c(insertFields, "totchg")
    insertValues <- c(insertValues, totchg)
  }
  
  if (!is.null(totchg_x)) {
    insertFields <- c(insertFields, "totchg_x")
    insertValues <- c(insertValues, totchg_x)
  }
  
  if (!is.null(zipinc)) {
    insertFields <- c(insertFields, "zipinc")
    insertValues <- c(insertValues, zipinc)
  }
  
  if (!is.null(discwtcharge)) {
    insertFields <- c(insertFields, "discwtcharge")
    insertValues <- c(insertValues, discwtcharge)
  }
  
  if (!is.null(mdid_s)) {
    insertFields <- c(insertFields, "mdid_s")
    insertValues <- c(insertValues, mdid_s)
  }
  
  if (!is.null(surgid_s)) {
    insertFields <- c(insertFields, "surgid_s")
    insertValues <- c(insertValues, surgid_s)
  }
  
  if (!is.null(asourceub92)) {
    insertFields <- c(insertFields, "asourceub92")
    insertValues <- c(insertValues, asourceub92)
  }
  
  if (!is.null(dispub04)) {
    insertFields <- c(insertFields, "dispub04")
    insertValues <- c(insertValues, dispub04)
  }
  
  if (!is.null(dqtr_x)) {
    insertFields <- c(insertFields, "dqtr_x")
    insertValues <- c(insertValues, dqtr_x)
  }
  
  if (!is.null(drg24)) {
    insertFields <- c(insertFields, "drg24")
    insertValues <- c(insertValues, drg24)
  }
  
  if (!is.null(drg_nopoa)) {
    insertFields <- c(insertFields, "drg_nopoa")
    insertValues <- c(insertValues, drg_nopoa)
  }
  
  if (!is.null(dx16)) {
    insertFields <- c(insertFields, "dx16")
    insertValues <- c(insertValues, dx16)
  }
  
  if (!is.null(dx17)) {
    insertFields <- c(insertFields, "dx17")
    insertValues <- c(insertValues, dx17)
  }
  
  if (!is.null(dx18)) {
    insertFields <- c(insertFields, "dx18")
    insertValues <- c(insertValues, dx18)
  }
  
  if (!is.null(dx19)) {
    insertFields <- c(insertFields, "dx19")
    insertValues <- c(insertValues, dx19)
  }
  
  if (!is.null(dx20)) {
    insertFields <- c(insertFields, "dx20")
    insertValues <- c(insertValues, dx20)
  }
  
  if (!is.null(dx21)) {
    insertFields <- c(insertFields, "dx21")
    insertValues <- c(insertValues, dx21)
  }
  
  if (!is.null(dx22)) {
    insertFields <- c(insertFields, "dx22")
    insertValues <- c(insertValues, dx22)
  }
  
  if (!is.null(dx23)) {
    insertFields <- c(insertFields, "dx23")
    insertValues <- c(insertValues, dx23)
  }
  
  if (!is.null(dx24)) {
    insertFields <- c(insertFields, "dx24")
    insertValues <- c(insertValues, dx24)
  }
  
  if (!is.null(dx25)) {
    insertFields <- c(insertFields, "dx25")
    insertValues <- c(insertValues, dx25)
  }
  
  if (!is.null(dxccs16)) {
    insertFields <- c(insertFields, "dxccs16")
    insertValues <- c(insertValues, dxccs16)
  }
  
  if (!is.null(dxccs17)) {
    insertFields <- c(insertFields, "dxccs17")
    insertValues <- c(insertValues, dxccs17)
  }
  
  if (!is.null(dxccs18)) {
    insertFields <- c(insertFields, "dxccs18")
    insertValues <- c(insertValues, dxccs18)
  }
  
  if (!is.null(dxccs19)) {
    insertFields <- c(insertFields, "dxccs19")
    insertValues <- c(insertValues, dxccs19)
  }
  
  if (!is.null(dxccs20)) {
    insertFields <- c(insertFields, "dxccs20")
    insertValues <- c(insertValues, dxccs20)
  }
  
  if (!is.null(dxccs21)) {
    insertFields <- c(insertFields, "dxccs21")
    insertValues <- c(insertValues, dxccs21)
  }
  
  if (!is.null(dxccs22)) {
    insertFields <- c(insertFields, "dxccs22")
    insertValues <- c(insertValues, dxccs22)
  }
  
  if (!is.null(dxccs23)) {
    insertFields <- c(insertFields, "dxccs23")
    insertValues <- c(insertValues, dxccs23)
  }
  
  if (!is.null(dxccs24)) {
    insertFields <- c(insertFields, "dxccs24")
    insertValues <- c(insertValues, dxccs24)
  }
  
  if (!is.null(dxccs25)) {
    insertFields <- c(insertFields, "dxccs25")
    insertValues <- c(insertValues, dxccs25)
  }
  
  if (!is.null(ecode1)) {
    insertFields <- c(insertFields, "ecode1")
    insertValues <- c(insertValues, ecode1)
  }
  
  if (!is.null(ecode2)) {
    insertFields <- c(insertFields, "ecode2")
    insertValues <- c(insertValues, ecode2)
  }
  
  if (!is.null(ecode3)) {
    insertFields <- c(insertFields, "ecode3")
    insertValues <- c(insertValues, ecode3)
  }
  
  if (!is.null(ecode4)) {
    insertFields <- c(insertFields, "ecode4")
    insertValues <- c(insertValues, ecode4)
  }
  
  if (!is.null(elective)) {
    insertFields <- c(insertFields, "elective")
    insertValues <- c(insertValues, elective)
  }
  
  if (!is.null(e_ccs1)) {
    insertFields <- c(insertFields, "e_ccs1")
    insertValues <- c(insertValues, e_ccs1)
  }
  
  if (!is.null(e_ccs2)) {
    insertFields <- c(insertFields, "e_ccs2")
    insertValues <- c(insertValues, e_ccs2)
  }
  
  if (!is.null(e_ccs3)) {
    insertFields <- c(insertFields, "e_ccs3")
    insertValues <- c(insertValues, e_ccs3)
  }
  
  if (!is.null(e_ccs4)) {
    insertFields <- c(insertFields, "e_ccs4")
    insertValues <- c(insertValues, e_ccs4)
  }
  
  if (!is.null(hcup_ed)) {
    insertFields <- c(insertFields, "hcup_ed")
    insertValues <- c(insertValues, hcup_ed)
  }
  
  if (!is.null(hospbrth)) {
    insertFields <- c(insertFields, "hospbrth")
    insertValues <- c(insertValues, hospbrth)
  }
  
  if (!is.null(mdc24)) {
    insertFields <- c(insertFields, "mdc24")
    insertValues <- c(insertValues, mdc24)
  }
  
  if (!is.null(mdc_nopoa)) {
    insertFields <- c(insertFields, "mdc_nopoa")
    insertValues <- c(insertValues, mdc_nopoa)
  }
  
  if (!is.null(nchronic)) {
    insertFields <- c(insertFields, "nchronic")
    insertValues <- c(insertValues, nchronic)
  }
  
  if (!is.null(necode)) {
    insertFields <- c(insertFields, "necode")
    insertValues <- c(insertValues, necode)
  }
  
  if (!is.null(orproc)) {
    insertFields <- c(insertFields, "orproc")
    insertValues <- c(insertValues, orproc)
  }
  
  if (!is.null(pl_nchs2006)) {
    insertFields <- c(insertFields, "pl_nchs2006")
    insertValues <- c(insertValues, pl_nchs2006)
  }
  
  if (!is.null(pointoforiginub04)) {
    insertFields <- c(insertFields, "pointoforiginub04")
    insertValues <- c(insertValues, pointoforiginub04)
  }
  
  if (!is.null(pointoforigin_x)) {
    insertFields <- c(insertFields, "pointoforigin_x")
    insertValues <- c(insertValues, pointoforigin_x)
  }
  
  if (!is.null(tran_in)) {
    insertFields <- c(insertFields, "tran_in")
    insertValues <- c(insertValues, tran_in)
  }
  
  if (!is.null(tran_out)) {
    insertFields <- c(insertFields, "tran_out")
    insertValues <- c(insertValues, tran_out)
  }
  
  if (!is.null(zipinc_qrtl)) {
    insertFields <- c(insertFields, "zipinc_qrtl")
    insertValues <- c(insertValues, zipinc_qrtl)
  }
  
  if (!is.null(mdnum1_r)) {
    insertFields <- c(insertFields, "mdnum1_r")
    insertValues <- c(insertValues, mdnum1_r)
  }
  
  if (!is.null(mdnum2_r)) {
    insertFields <- c(insertFields, "mdnum2_r")
    insertValues <- c(insertValues, mdnum2_r)
  }
  
  if (!is.null(pl_ur_cat4)) {
    insertFields <- c(insertFields, "pl_ur_cat4")
    insertValues <- c(insertValues, pl_ur_cat4)
  }
  
  statement <- paste0("INSERT INTO core (", paste(insertFields, collapse = ", "), ") VALUES ('", paste(insertValues, collapse = "', '"), "');")
  assign("insertSql", c(get("insertSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

add_dx_pr_grps <- function(hospid = "12320", key = "List truncated...", chron1 = "0", chron2 = "0", chron3 = "1", chron4 = "1", chron5 = "1", chron6 = "-99", chron7 = "-99", chron8 = "-99", chron9 = "-99", chron10 = "-99", chron11 = "-99", chron12 = "-99", chron13 = "-99", chron14 = "-99", chron15 = "-99", chron16 = NULL, chron17 = NULL, chron18 = NULL, chron19 = NULL, chron20 = NULL, chron21 = NULL, chron22 = NULL, chron23 = NULL, chron24 = NULL, chron25 = NULL, chronb1 = "7", chronb2 = "7", chronb3 = "7", chronb4 = "-99", chronb5 = "-99", chronb6 = "-99", chronb7 = "-99", chronb8 = "-99", chronb9 = "-99", chronb10 = "-99", chronb11 = "-99", chronb12 = "-99", chronb13 = "-99", chronb14 = "-99", chronb15 = "-99", chronb16 = NULL, chronb17 = NULL, chronb18 = NULL, chronb19 = NULL, chronb20 = NULL, chronb21 = NULL, chronb22 = NULL, chronb23 = NULL, chronb24 = NULL, chronb25 = NULL, dxmccs1 = NULL, e_mccs1 = NULL, pclass1 = "-99", pclass2 = "-99", pclass3 = "-99", pclass4 = "-99", pclass5 = "-99", pclass6 = "-99", pclass7 = "-99", pclass8 = "-99", pclass9 = "-99", pclass10 = "-99", pclass11 = "-99", pclass12 = "-99", pclass13 = "-99", pclass14 = "-99", pclass15 = "-99", prmccs1 = NULL, ccsmgn1 = NULL, ccsmgn2 = NULL, ccsmgn3 = NULL, ccsmgn4 = NULL, ccsmgn5 = NULL, ccsmgn6 = NULL, ccsmgn7 = NULL, ccsmgn8 = NULL, ccsmgn9 = NULL, ccsmgn10 = NULL, ccsmgn11 = NULL, ccsmgn12 = NULL, ccsmgn13 = NULL, ccsmgn14 = NULL, ccsmgn15 = NULL, ccsmsp1 = NULL, ccsmsp2 = NULL, ccsmsp3 = NULL, ccsmsp4 = NULL, ccsmsp5 = NULL, ccsmsp6 = NULL, ccsmsp7 = NULL, ccsmsp8 = NULL, ccsmsp9 = NULL, ccsmsp10 = NULL, ccsmsp11 = NULL, ccsmsp12 = NULL, ccsmsp13 = NULL, ccsmsp14 = NULL, ccsmsp15 = NULL, eccsmgn1 = NULL, eccsmgn2 = NULL, eccsmgn3 = NULL, eccsmgn4 = NULL) {
  insertFields <- c()
  insertValues <- c()
  if (!is.null(hospid)) {
    insertFields <- c(insertFields, "hospid")
    insertValues <- c(insertValues, hospid)
  }
  
  if (!is.null(key)) {
    insertFields <- c(insertFields, "[key]")
    insertValues <- c(insertValues, key)
  }
  
  if (!is.null(chron1)) {
    insertFields <- c(insertFields, "chron1")
    insertValues <- c(insertValues, chron1)
  }
  
  if (!is.null(chron2)) {
    insertFields <- c(insertFields, "chron2")
    insertValues <- c(insertValues, chron2)
  }
  
  if (!is.null(chron3)) {
    insertFields <- c(insertFields, "chron3")
    insertValues <- c(insertValues, chron3)
  }
  
  if (!is.null(chron4)) {
    insertFields <- c(insertFields, "chron4")
    insertValues <- c(insertValues, chron4)
  }
  
  if (!is.null(chron5)) {
    insertFields <- c(insertFields, "chron5")
    insertValues <- c(insertValues, chron5)
  }
  
  if (!is.null(chron6)) {
    insertFields <- c(insertFields, "chron6")
    insertValues <- c(insertValues, chron6)
  }
  
  if (!is.null(chron7)) {
    insertFields <- c(insertFields, "chron7")
    insertValues <- c(insertValues, chron7)
  }
  
  if (!is.null(chron8)) {
    insertFields <- c(insertFields, "chron8")
    insertValues <- c(insertValues, chron8)
  }
  
  if (!is.null(chron9)) {
    insertFields <- c(insertFields, "chron9")
    insertValues <- c(insertValues, chron9)
  }
  
  if (!is.null(chron10)) {
    insertFields <- c(insertFields, "chron10")
    insertValues <- c(insertValues, chron10)
  }
  
  if (!is.null(chron11)) {
    insertFields <- c(insertFields, "chron11")
    insertValues <- c(insertValues, chron11)
  }
  
  if (!is.null(chron12)) {
    insertFields <- c(insertFields, "chron12")
    insertValues <- c(insertValues, chron12)
  }
  
  if (!is.null(chron13)) {
    insertFields <- c(insertFields, "chron13")
    insertValues <- c(insertValues, chron13)
  }
  
  if (!is.null(chron14)) {
    insertFields <- c(insertFields, "chron14")
    insertValues <- c(insertValues, chron14)
  }
  
  if (!is.null(chron15)) {
    insertFields <- c(insertFields, "chron15")
    insertValues <- c(insertValues, chron15)
  }
  
  if (!is.null(chron16)) {
    insertFields <- c(insertFields, "chron16")
    insertValues <- c(insertValues, chron16)
  }
  
  if (!is.null(chron17)) {
    insertFields <- c(insertFields, "chron17")
    insertValues <- c(insertValues, chron17)
  }
  
  if (!is.null(chron18)) {
    insertFields <- c(insertFields, "chron18")
    insertValues <- c(insertValues, chron18)
  }
  
  if (!is.null(chron19)) {
    insertFields <- c(insertFields, "chron19")
    insertValues <- c(insertValues, chron19)
  }
  
  if (!is.null(chron20)) {
    insertFields <- c(insertFields, "chron20")
    insertValues <- c(insertValues, chron20)
  }
  
  if (!is.null(chron21)) {
    insertFields <- c(insertFields, "chron21")
    insertValues <- c(insertValues, chron21)
  }
  
  if (!is.null(chron22)) {
    insertFields <- c(insertFields, "chron22")
    insertValues <- c(insertValues, chron22)
  }
  
  if (!is.null(chron23)) {
    insertFields <- c(insertFields, "chron23")
    insertValues <- c(insertValues, chron23)
  }
  
  if (!is.null(chron24)) {
    insertFields <- c(insertFields, "chron24")
    insertValues <- c(insertValues, chron24)
  }
  
  if (!is.null(chron25)) {
    insertFields <- c(insertFields, "chron25")
    insertValues <- c(insertValues, chron25)
  }
  
  if (!is.null(chronb1)) {
    insertFields <- c(insertFields, "chronb1")
    insertValues <- c(insertValues, chronb1)
  }
  
  if (!is.null(chronb2)) {
    insertFields <- c(insertFields, "chronb2")
    insertValues <- c(insertValues, chronb2)
  }
  
  if (!is.null(chronb3)) {
    insertFields <- c(insertFields, "chronb3")
    insertValues <- c(insertValues, chronb3)
  }
  
  if (!is.null(chronb4)) {
    insertFields <- c(insertFields, "chronb4")
    insertValues <- c(insertValues, chronb4)
  }
  
  if (!is.null(chronb5)) {
    insertFields <- c(insertFields, "chronb5")
    insertValues <- c(insertValues, chronb5)
  }
  
  if (!is.null(chronb6)) {
    insertFields <- c(insertFields, "chronb6")
    insertValues <- c(insertValues, chronb6)
  }
  
  if (!is.null(chronb7)) {
    insertFields <- c(insertFields, "chronb7")
    insertValues <- c(insertValues, chronb7)
  }
  
  if (!is.null(chronb8)) {
    insertFields <- c(insertFields, "chronb8")
    insertValues <- c(insertValues, chronb8)
  }
  
  if (!is.null(chronb9)) {
    insertFields <- c(insertFields, "chronb9")
    insertValues <- c(insertValues, chronb9)
  }
  
  if (!is.null(chronb10)) {
    insertFields <- c(insertFields, "chronb10")
    insertValues <- c(insertValues, chronb10)
  }
  
  if (!is.null(chronb11)) {
    insertFields <- c(insertFields, "chronb11")
    insertValues <- c(insertValues, chronb11)
  }
  
  if (!is.null(chronb12)) {
    insertFields <- c(insertFields, "chronb12")
    insertValues <- c(insertValues, chronb12)
  }
  
  if (!is.null(chronb13)) {
    insertFields <- c(insertFields, "chronb13")
    insertValues <- c(insertValues, chronb13)
  }
  
  if (!is.null(chronb14)) {
    insertFields <- c(insertFields, "chronb14")
    insertValues <- c(insertValues, chronb14)
  }
  
  if (!is.null(chronb15)) {
    insertFields <- c(insertFields, "chronb15")
    insertValues <- c(insertValues, chronb15)
  }
  
  if (!is.null(chronb16)) {
    insertFields <- c(insertFields, "chronb16")
    insertValues <- c(insertValues, chronb16)
  }
  
  if (!is.null(chronb17)) {
    insertFields <- c(insertFields, "chronb17")
    insertValues <- c(insertValues, chronb17)
  }
  
  if (!is.null(chronb18)) {
    insertFields <- c(insertFields, "chronb18")
    insertValues <- c(insertValues, chronb18)
  }
  
  if (!is.null(chronb19)) {
    insertFields <- c(insertFields, "chronb19")
    insertValues <- c(insertValues, chronb19)
  }
  
  if (!is.null(chronb20)) {
    insertFields <- c(insertFields, "chronb20")
    insertValues <- c(insertValues, chronb20)
  }
  
  if (!is.null(chronb21)) {
    insertFields <- c(insertFields, "chronb21")
    insertValues <- c(insertValues, chronb21)
  }
  
  if (!is.null(chronb22)) {
    insertFields <- c(insertFields, "chronb22")
    insertValues <- c(insertValues, chronb22)
  }
  
  if (!is.null(chronb23)) {
    insertFields <- c(insertFields, "chronb23")
    insertValues <- c(insertValues, chronb23)
  }
  
  if (!is.null(chronb24)) {
    insertFields <- c(insertFields, "chronb24")
    insertValues <- c(insertValues, chronb24)
  }
  
  if (!is.null(chronb25)) {
    insertFields <- c(insertFields, "chronb25")
    insertValues <- c(insertValues, chronb25)
  }
  
  if (!is.null(dxmccs1)) {
    insertFields <- c(insertFields, "dxmccs1")
    insertValues <- c(insertValues, dxmccs1)
  }
  
  if (!is.null(e_mccs1)) {
    insertFields <- c(insertFields, "e_mccs1")
    insertValues <- c(insertValues, e_mccs1)
  }
  
  if (!is.null(pclass1)) {
    insertFields <- c(insertFields, "pclass1")
    insertValues <- c(insertValues, pclass1)
  }
  
  if (!is.null(pclass2)) {
    insertFields <- c(insertFields, "pclass2")
    insertValues <- c(insertValues, pclass2)
  }
  
  if (!is.null(pclass3)) {
    insertFields <- c(insertFields, "pclass3")
    insertValues <- c(insertValues, pclass3)
  }
  
  if (!is.null(pclass4)) {
    insertFields <- c(insertFields, "pclass4")
    insertValues <- c(insertValues, pclass4)
  }
  
  if (!is.null(pclass5)) {
    insertFields <- c(insertFields, "pclass5")
    insertValues <- c(insertValues, pclass5)
  }
  
  if (!is.null(pclass6)) {
    insertFields <- c(insertFields, "pclass6")
    insertValues <- c(insertValues, pclass6)
  }
  
  if (!is.null(pclass7)) {
    insertFields <- c(insertFields, "pclass7")
    insertValues <- c(insertValues, pclass7)
  }
  
  if (!is.null(pclass8)) {
    insertFields <- c(insertFields, "pclass8")
    insertValues <- c(insertValues, pclass8)
  }
  
  if (!is.null(pclass9)) {
    insertFields <- c(insertFields, "pclass9")
    insertValues <- c(insertValues, pclass9)
  }
  
  if (!is.null(pclass10)) {
    insertFields <- c(insertFields, "pclass10")
    insertValues <- c(insertValues, pclass10)
  }
  
  if (!is.null(pclass11)) {
    insertFields <- c(insertFields, "pclass11")
    insertValues <- c(insertValues, pclass11)
  }
  
  if (!is.null(pclass12)) {
    insertFields <- c(insertFields, "pclass12")
    insertValues <- c(insertValues, pclass12)
  }
  
  if (!is.null(pclass13)) {
    insertFields <- c(insertFields, "pclass13")
    insertValues <- c(insertValues, pclass13)
  }
  
  if (!is.null(pclass14)) {
    insertFields <- c(insertFields, "pclass14")
    insertValues <- c(insertValues, pclass14)
  }
  
  if (!is.null(pclass15)) {
    insertFields <- c(insertFields, "pclass15")
    insertValues <- c(insertValues, pclass15)
  }
  
  if (!is.null(prmccs1)) {
    insertFields <- c(insertFields, "prmccs1")
    insertValues <- c(insertValues, prmccs1)
  }
  
  if (!is.null(ccsmgn1)) {
    insertFields <- c(insertFields, "ccsmgn1")
    insertValues <- c(insertValues, ccsmgn1)
  }
  
  if (!is.null(ccsmgn2)) {
    insertFields <- c(insertFields, "ccsmgn2")
    insertValues <- c(insertValues, ccsmgn2)
  }
  
  if (!is.null(ccsmgn3)) {
    insertFields <- c(insertFields, "ccsmgn3")
    insertValues <- c(insertValues, ccsmgn3)
  }
  
  if (!is.null(ccsmgn4)) {
    insertFields <- c(insertFields, "ccsmgn4")
    insertValues <- c(insertValues, ccsmgn4)
  }
  
  if (!is.null(ccsmgn5)) {
    insertFields <- c(insertFields, "ccsmgn5")
    insertValues <- c(insertValues, ccsmgn5)
  }
  
  if (!is.null(ccsmgn6)) {
    insertFields <- c(insertFields, "ccsmgn6")
    insertValues <- c(insertValues, ccsmgn6)
  }
  
  if (!is.null(ccsmgn7)) {
    insertFields <- c(insertFields, "ccsmgn7")
    insertValues <- c(insertValues, ccsmgn7)
  }
  
  if (!is.null(ccsmgn8)) {
    insertFields <- c(insertFields, "ccsmgn8")
    insertValues <- c(insertValues, ccsmgn8)
  }
  
  if (!is.null(ccsmgn9)) {
    insertFields <- c(insertFields, "ccsmgn9")
    insertValues <- c(insertValues, ccsmgn9)
  }
  
  if (!is.null(ccsmgn10)) {
    insertFields <- c(insertFields, "ccsmgn10")
    insertValues <- c(insertValues, ccsmgn10)
  }
  
  if (!is.null(ccsmgn11)) {
    insertFields <- c(insertFields, "ccsmgn11")
    insertValues <- c(insertValues, ccsmgn11)
  }
  
  if (!is.null(ccsmgn12)) {
    insertFields <- c(insertFields, "ccsmgn12")
    insertValues <- c(insertValues, ccsmgn12)
  }
  
  if (!is.null(ccsmgn13)) {
    insertFields <- c(insertFields, "ccsmgn13")
    insertValues <- c(insertValues, ccsmgn13)
  }
  
  if (!is.null(ccsmgn14)) {
    insertFields <- c(insertFields, "ccsmgn14")
    insertValues <- c(insertValues, ccsmgn14)
  }
  
  if (!is.null(ccsmgn15)) {
    insertFields <- c(insertFields, "ccsmgn15")
    insertValues <- c(insertValues, ccsmgn15)
  }
  
  if (!is.null(ccsmsp1)) {
    insertFields <- c(insertFields, "ccsmsp1")
    insertValues <- c(insertValues, ccsmsp1)
  }
  
  if (!is.null(ccsmsp2)) {
    insertFields <- c(insertFields, "ccsmsp2")
    insertValues <- c(insertValues, ccsmsp2)
  }
  
  if (!is.null(ccsmsp3)) {
    insertFields <- c(insertFields, "ccsmsp3")
    insertValues <- c(insertValues, ccsmsp3)
  }
  
  if (!is.null(ccsmsp4)) {
    insertFields <- c(insertFields, "ccsmsp4")
    insertValues <- c(insertValues, ccsmsp4)
  }
  
  if (!is.null(ccsmsp5)) {
    insertFields <- c(insertFields, "ccsmsp5")
    insertValues <- c(insertValues, ccsmsp5)
  }
  
  if (!is.null(ccsmsp6)) {
    insertFields <- c(insertFields, "ccsmsp6")
    insertValues <- c(insertValues, ccsmsp6)
  }
  
  if (!is.null(ccsmsp7)) {
    insertFields <- c(insertFields, "ccsmsp7")
    insertValues <- c(insertValues, ccsmsp7)
  }
  
  if (!is.null(ccsmsp8)) {
    insertFields <- c(insertFields, "ccsmsp8")
    insertValues <- c(insertValues, ccsmsp8)
  }
  
  if (!is.null(ccsmsp9)) {
    insertFields <- c(insertFields, "ccsmsp9")
    insertValues <- c(insertValues, ccsmsp9)
  }
  
  if (!is.null(ccsmsp10)) {
    insertFields <- c(insertFields, "ccsmsp10")
    insertValues <- c(insertValues, ccsmsp10)
  }
  
  if (!is.null(ccsmsp11)) {
    insertFields <- c(insertFields, "ccsmsp11")
    insertValues <- c(insertValues, ccsmsp11)
  }
  
  if (!is.null(ccsmsp12)) {
    insertFields <- c(insertFields, "ccsmsp12")
    insertValues <- c(insertValues, ccsmsp12)
  }
  
  if (!is.null(ccsmsp13)) {
    insertFields <- c(insertFields, "ccsmsp13")
    insertValues <- c(insertValues, ccsmsp13)
  }
  
  if (!is.null(ccsmsp14)) {
    insertFields <- c(insertFields, "ccsmsp14")
    insertValues <- c(insertValues, ccsmsp14)
  }
  
  if (!is.null(ccsmsp15)) {
    insertFields <- c(insertFields, "ccsmsp15")
    insertValues <- c(insertValues, ccsmsp15)
  }
  
  if (!is.null(eccsmgn1)) {
    insertFields <- c(insertFields, "eccsmgn1")
    insertValues <- c(insertValues, eccsmgn1)
  }
  
  if (!is.null(eccsmgn2)) {
    insertFields <- c(insertFields, "eccsmgn2")
    insertValues <- c(insertValues, eccsmgn2)
  }
  
  if (!is.null(eccsmgn3)) {
    insertFields <- c(insertFields, "eccsmgn3")
    insertValues <- c(insertValues, eccsmgn3)
  }
  
  if (!is.null(eccsmgn4)) {
    insertFields <- c(insertFields, "eccsmgn4")
    insertValues <- c(insertValues, eccsmgn4)
  }
  
  statement <- paste0("INSERT INTO dx_pr_grps (", paste(insertFields, collapse = ", "), ") VALUES ('", paste(insertValues, collapse = "', '"), "');")
  assign("insertSql", c(get("insertSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

add_hospital <- function(ahaid = "       ", discwt = "4.4322", hospaddr = "                              ", hospcity = "                    ", hospid = "List truncated...", hospname = "                              ", hospst = "TX", hospwt = "5.0000", hospzip = "     ", hosp_bedsize = "1", hosp_control = "0", hosp_location = "1", hosp_locteach = "2", hosp_region = "3", hosp_teach = "0", idnumber = "      ", nis_stratum = "2411", n_disc_u = "133443", n_hosp_u = "78", s_disc_u = "84786", s_hosp_u = "16", total_disc = "List truncated...", year = "2008", discwtcharge = NULL, hfipsstco = NULL, h_contrl = NULL, hospstco = "-9999", hosp_rnpct = NULL, hosp_rnfteapd = NULL, hosp_lpnfteapd = NULL, hosp_nafteapd = NULL, hosp_opsurgpct = NULL, hosp_mhsmember = NULL, hosp_mhscluster = NULL) {
  insertFields <- c()
  insertValues <- c()
  if (!is.null(ahaid)) {
    insertFields <- c(insertFields, "ahaid")
    insertValues <- c(insertValues, ahaid)
  }
  
  if (!is.null(discwt)) {
    insertFields <- c(insertFields, "discwt")
    insertValues <- c(insertValues, discwt)
  }
  
  if (!is.null(hospaddr)) {
    insertFields <- c(insertFields, "hospaddr")
    insertValues <- c(insertValues, hospaddr)
  }
  
  if (!is.null(hospcity)) {
    insertFields <- c(insertFields, "hospcity")
    insertValues <- c(insertValues, hospcity)
  }
  
  if (!is.null(hospid)) {
    insertFields <- c(insertFields, "hospid")
    insertValues <- c(insertValues, hospid)
  }
  
  if (!is.null(hospname)) {
    insertFields <- c(insertFields, "hospname")
    insertValues <- c(insertValues, hospname)
  }
  
  if (!is.null(hospst)) {
    insertFields <- c(insertFields, "hospst")
    insertValues <- c(insertValues, hospst)
  }
  
  if (!is.null(hospwt)) {
    insertFields <- c(insertFields, "hospwt")
    insertValues <- c(insertValues, hospwt)
  }
  
  if (!is.null(hospzip)) {
    insertFields <- c(insertFields, "hospzip")
    insertValues <- c(insertValues, hospzip)
  }
  
  if (!is.null(hosp_bedsize)) {
    insertFields <- c(insertFields, "hosp_bedsize")
    insertValues <- c(insertValues, hosp_bedsize)
  }
  
  if (!is.null(hosp_control)) {
    insertFields <- c(insertFields, "hosp_control")
    insertValues <- c(insertValues, hosp_control)
  }
  
  if (!is.null(hosp_location)) {
    insertFields <- c(insertFields, "hosp_location")
    insertValues <- c(insertValues, hosp_location)
  }
  
  if (!is.null(hosp_locteach)) {
    insertFields <- c(insertFields, "hosp_locteach")
    insertValues <- c(insertValues, hosp_locteach)
  }
  
  if (!is.null(hosp_region)) {
    insertFields <- c(insertFields, "hosp_region")
    insertValues <- c(insertValues, hosp_region)
  }
  
  if (!is.null(hosp_teach)) {
    insertFields <- c(insertFields, "hosp_teach")
    insertValues <- c(insertValues, hosp_teach)
  }
  
  if (!is.null(idnumber)) {
    insertFields <- c(insertFields, "idnumber")
    insertValues <- c(insertValues, idnumber)
  }
  
  if (!is.null(nis_stratum)) {
    insertFields <- c(insertFields, "nis_stratum")
    insertValues <- c(insertValues, nis_stratum)
  }
  
  if (!is.null(n_disc_u)) {
    insertFields <- c(insertFields, "n_disc_u")
    insertValues <- c(insertValues, n_disc_u)
  }
  
  if (!is.null(n_hosp_u)) {
    insertFields <- c(insertFields, "n_hosp_u")
    insertValues <- c(insertValues, n_hosp_u)
  }
  
  if (!is.null(s_disc_u)) {
    insertFields <- c(insertFields, "s_disc_u")
    insertValues <- c(insertValues, s_disc_u)
  }
  
  if (!is.null(s_hosp_u)) {
    insertFields <- c(insertFields, "s_hosp_u")
    insertValues <- c(insertValues, s_hosp_u)
  }
  
  if (!is.null(total_disc)) {
    insertFields <- c(insertFields, "total_disc")
    insertValues <- c(insertValues, total_disc)
  }
  
  if (!is.null(year)) {
    insertFields <- c(insertFields, "year")
    insertValues <- c(insertValues, year)
  }
  
  if (!is.null(discwtcharge)) {
    insertFields <- c(insertFields, "discwtcharge")
    insertValues <- c(insertValues, discwtcharge)
  }
  
  if (!is.null(hfipsstco)) {
    insertFields <- c(insertFields, "hfipsstco")
    insertValues <- c(insertValues, hfipsstco)
  }
  
  if (!is.null(h_contrl)) {
    insertFields <- c(insertFields, "h_contrl")
    insertValues <- c(insertValues, h_contrl)
  }
  
  if (!is.null(hospstco)) {
    insertFields <- c(insertFields, "hospstco")
    insertValues <- c(insertValues, hospstco)
  }
  
  if (!is.null(hosp_rnpct)) {
    insertFields <- c(insertFields, "hosp_rnpct")
    insertValues <- c(insertValues, hosp_rnpct)
  }
  
  if (!is.null(hosp_rnfteapd)) {
    insertFields <- c(insertFields, "hosp_rnfteapd")
    insertValues <- c(insertValues, hosp_rnfteapd)
  }
  
  if (!is.null(hosp_lpnfteapd)) {
    insertFields <- c(insertFields, "hosp_lpnfteapd")
    insertValues <- c(insertValues, hosp_lpnfteapd)
  }
  
  if (!is.null(hosp_nafteapd)) {
    insertFields <- c(insertFields, "hosp_nafteapd")
    insertValues <- c(insertValues, hosp_nafteapd)
  }
  
  if (!is.null(hosp_opsurgpct)) {
    insertFields <- c(insertFields, "hosp_opsurgpct")
    insertValues <- c(insertValues, hosp_opsurgpct)
  }
  
  if (!is.null(hosp_mhsmember)) {
    insertFields <- c(insertFields, "hosp_mhsmember")
    insertValues <- c(insertValues, hosp_mhsmember)
  }
  
  if (!is.null(hosp_mhscluster)) {
    insertFields <- c(insertFields, "hosp_mhscluster")
    insertValues <- c(insertValues, hosp_mhscluster)
  }
  
  statement <- paste0("INSERT INTO hospital (", paste(insertFields, collapse = ", "), ") VALUES ('", paste(insertValues, collapse = "', '"), "');")
  assign("insertSql", c(get("insertSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

add_severity <- function(hospid = "51043", key = "List truncated...", aprdrg = "640", aprdrg_risk_mortality = "1", aprdrg_severity = "1", cm_aids = "0", cm_alcohol = "0", cm_anemdef = "0", cm_arth = "0", cm_bldloss = "0", cm_chf = "0", cm_chrnlung = "0", cm_coag = "0", cm_depress = "0", cm_dm = "0", cm_dmcx = "0", cm_drug = "0", cm_htn_c = "0", cm_hypothy = "0", cm_liver = "0", cm_lymph = "0", cm_lytes = "0", cm_mets = "0", cm_neuro = "0", cm_obese = "0", cm_para = "0", cm_perivasc = "0", cm_psych = "0", cm_pulmcirc = "0", cm_renlfail = "0", cm_tumor = "0", cm_ulcer = "0", cm_valve = "0", cm_wghtloss = "0", ds_dx_category1 = NULL, ds_stage1 = "1.01", apsdrg = NULL, apsdrg_charge_weight = NULL, apsdrg_los_weight = NULL, apsdrg_mortality_weight = NULL, ds_los_level = NULL, ds_los_scale = NULL, ds_mrt_level = NULL, ds_mrt_scale = NULL, ds_rd_level = NULL, ds_rd_scale = NULL) {
  insertFields <- c()
  insertValues <- c()
  if (!is.null(hospid)) {
    insertFields <- c(insertFields, "hospid")
    insertValues <- c(insertValues, hospid)
  }
  
  if (!is.null(key)) {
    insertFields <- c(insertFields, "[key]")
    insertValues <- c(insertValues, key)
  }
  
  if (!is.null(aprdrg)) {
    insertFields <- c(insertFields, "aprdrg")
    insertValues <- c(insertValues, aprdrg)
  }
  
  if (!is.null(aprdrg_risk_mortality)) {
    insertFields <- c(insertFields, "aprdrg_risk_mortality")
    insertValues <- c(insertValues, aprdrg_risk_mortality)
  }
  
  if (!is.null(aprdrg_severity)) {
    insertFields <- c(insertFields, "aprdrg_severity")
    insertValues <- c(insertValues, aprdrg_severity)
  }
  
  if (!is.null(cm_aids)) {
    insertFields <- c(insertFields, "cm_aids")
    insertValues <- c(insertValues, cm_aids)
  }
  
  if (!is.null(cm_alcohol)) {
    insertFields <- c(insertFields, "cm_alcohol")
    insertValues <- c(insertValues, cm_alcohol)
  }
  
  if (!is.null(cm_anemdef)) {
    insertFields <- c(insertFields, "cm_anemdef")
    insertValues <- c(insertValues, cm_anemdef)
  }
  
  if (!is.null(cm_arth)) {
    insertFields <- c(insertFields, "cm_arth")
    insertValues <- c(insertValues, cm_arth)
  }
  
  if (!is.null(cm_bldloss)) {
    insertFields <- c(insertFields, "cm_bldloss")
    insertValues <- c(insertValues, cm_bldloss)
  }
  
  if (!is.null(cm_chf)) {
    insertFields <- c(insertFields, "cm_chf")
    insertValues <- c(insertValues, cm_chf)
  }
  
  if (!is.null(cm_chrnlung)) {
    insertFields <- c(insertFields, "cm_chrnlung")
    insertValues <- c(insertValues, cm_chrnlung)
  }
  
  if (!is.null(cm_coag)) {
    insertFields <- c(insertFields, "cm_coag")
    insertValues <- c(insertValues, cm_coag)
  }
  
  if (!is.null(cm_depress)) {
    insertFields <- c(insertFields, "cm_depress")
    insertValues <- c(insertValues, cm_depress)
  }
  
  if (!is.null(cm_dm)) {
    insertFields <- c(insertFields, "cm_dm")
    insertValues <- c(insertValues, cm_dm)
  }
  
  if (!is.null(cm_dmcx)) {
    insertFields <- c(insertFields, "cm_dmcx")
    insertValues <- c(insertValues, cm_dmcx)
  }
  
  if (!is.null(cm_drug)) {
    insertFields <- c(insertFields, "cm_drug")
    insertValues <- c(insertValues, cm_drug)
  }
  
  if (!is.null(cm_htn_c)) {
    insertFields <- c(insertFields, "cm_htn_c")
    insertValues <- c(insertValues, cm_htn_c)
  }
  
  if (!is.null(cm_hypothy)) {
    insertFields <- c(insertFields, "cm_hypothy")
    insertValues <- c(insertValues, cm_hypothy)
  }
  
  if (!is.null(cm_liver)) {
    insertFields <- c(insertFields, "cm_liver")
    insertValues <- c(insertValues, cm_liver)
  }
  
  if (!is.null(cm_lymph)) {
    insertFields <- c(insertFields, "cm_lymph")
    insertValues <- c(insertValues, cm_lymph)
  }
  
  if (!is.null(cm_lytes)) {
    insertFields <- c(insertFields, "cm_lytes")
    insertValues <- c(insertValues, cm_lytes)
  }
  
  if (!is.null(cm_mets)) {
    insertFields <- c(insertFields, "cm_mets")
    insertValues <- c(insertValues, cm_mets)
  }
  
  if (!is.null(cm_neuro)) {
    insertFields <- c(insertFields, "cm_neuro")
    insertValues <- c(insertValues, cm_neuro)
  }
  
  if (!is.null(cm_obese)) {
    insertFields <- c(insertFields, "cm_obese")
    insertValues <- c(insertValues, cm_obese)
  }
  
  if (!is.null(cm_para)) {
    insertFields <- c(insertFields, "cm_para")
    insertValues <- c(insertValues, cm_para)
  }
  
  if (!is.null(cm_perivasc)) {
    insertFields <- c(insertFields, "cm_perivasc")
    insertValues <- c(insertValues, cm_perivasc)
  }
  
  if (!is.null(cm_psych)) {
    insertFields <- c(insertFields, "cm_psych")
    insertValues <- c(insertValues, cm_psych)
  }
  
  if (!is.null(cm_pulmcirc)) {
    insertFields <- c(insertFields, "cm_pulmcirc")
    insertValues <- c(insertValues, cm_pulmcirc)
  }
  
  if (!is.null(cm_renlfail)) {
    insertFields <- c(insertFields, "cm_renlfail")
    insertValues <- c(insertValues, cm_renlfail)
  }
  
  if (!is.null(cm_tumor)) {
    insertFields <- c(insertFields, "cm_tumor")
    insertValues <- c(insertValues, cm_tumor)
  }
  
  if (!is.null(cm_ulcer)) {
    insertFields <- c(insertFields, "cm_ulcer")
    insertValues <- c(insertValues, cm_ulcer)
  }
  
  if (!is.null(cm_valve)) {
    insertFields <- c(insertFields, "cm_valve")
    insertValues <- c(insertValues, cm_valve)
  }
  
  if (!is.null(cm_wghtloss)) {
    insertFields <- c(insertFields, "cm_wghtloss")
    insertValues <- c(insertValues, cm_wghtloss)
  }
  
  if (!is.null(ds_dx_category1)) {
    insertFields <- c(insertFields, "ds_dx_category1")
    insertValues <- c(insertValues, ds_dx_category1)
  }
  
  if (!is.null(ds_stage1)) {
    insertFields <- c(insertFields, "ds_stage1")
    insertValues <- c(insertValues, ds_stage1)
  }
  
  if (!is.null(apsdrg)) {
    insertFields <- c(insertFields, "apsdrg")
    insertValues <- c(insertValues, apsdrg)
  }
  
  if (!is.null(apsdrg_charge_weight)) {
    insertFields <- c(insertFields, "apsdrg_charge_weight")
    insertValues <- c(insertValues, apsdrg_charge_weight)
  }
  
  if (!is.null(apsdrg_los_weight)) {
    insertFields <- c(insertFields, "apsdrg_los_weight")
    insertValues <- c(insertValues, apsdrg_los_weight)
  }
  
  if (!is.null(apsdrg_mortality_weight)) {
    insertFields <- c(insertFields, "apsdrg_mortality_weight")
    insertValues <- c(insertValues, apsdrg_mortality_weight)
  }
  
  if (!is.null(ds_los_level)) {
    insertFields <- c(insertFields, "ds_los_level")
    insertValues <- c(insertValues, ds_los_level)
  }
  
  if (!is.null(ds_los_scale)) {
    insertFields <- c(insertFields, "ds_los_scale")
    insertValues <- c(insertValues, ds_los_scale)
  }
  
  if (!is.null(ds_mrt_level)) {
    insertFields <- c(insertFields, "ds_mrt_level")
    insertValues <- c(insertValues, ds_mrt_level)
  }
  
  if (!is.null(ds_mrt_scale)) {
    insertFields <- c(insertFields, "ds_mrt_scale")
    insertValues <- c(insertValues, ds_mrt_scale)
  }
  
  if (!is.null(ds_rd_level)) {
    insertFields <- c(insertFields, "ds_rd_level")
    insertValues <- c(insertValues, ds_rd_level)
  }
  
  if (!is.null(ds_rd_scale)) {
    insertFields <- c(insertFields, "ds_rd_scale")
    insertValues <- c(insertValues, ds_rd_scale)
  }
  
  statement <- paste0("INSERT INTO severity (", paste(insertFields, collapse = ", "), ") VALUES ('", paste(insertValues, collapse = "', '"), "');")
  assign("insertSql", c(get("insertSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_person <- function(person_id, person_source_value, gender_concept_id, gender_source_value, year_of_birth, month_of_birth, day_of_birth, race_concept_id, race_source_value, ethnicity_concept_id, ethnicity_source_value, time_of_birth, location_id, provider_id, care_site_id, gender_source_concept_id, race_source_concept_id, ethnicity_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE")
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(person_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_source_value)) {
      statement <- paste0(statement, " person_source_value IS NULL")
    } else {
      statement <- paste0(statement, " person_source_value = '", person_source_value,"'")
    }
  }
  
  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_concept_id)) {
      statement <- paste0(statement, " gender_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " gender_concept_id = '", gender_concept_id,"'")
    }
  }
  
  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_source_value)) {
      statement <- paste0(statement, " gender_source_value IS NULL")
    } else {
      statement <- paste0(statement, " gender_source_value = '", gender_source_value,"'")
    }
  }
  
  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(year_of_birth)) {
      statement <- paste0(statement, " year_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " year_of_birth = '", year_of_birth,"'")
    }
  }
  
  if (!missing(month_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(month_of_birth)) {
      statement <- paste0(statement, " month_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " month_of_birth = '", month_of_birth,"'")
    }
  }
  
  if (!missing(day_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(day_of_birth)) {
      statement <- paste0(statement, " day_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " day_of_birth = '", day_of_birth,"'")
    }
  }
  
  if (!missing(race_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(race_concept_id)) {
      statement <- paste0(statement, " race_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " race_concept_id = '", race_concept_id,"'")
    }
  }
  
  if (!missing(race_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(race_source_value)) {
      statement <- paste0(statement, " race_source_value IS NULL")
    } else {
      statement <- paste0(statement, " race_source_value = '", race_source_value,"'")
    }
  }
  
  if (!missing(ethnicity_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(ethnicity_concept_id)) {
      statement <- paste0(statement, " ethnicity_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " ethnicity_concept_id = '", ethnicity_concept_id,"'")
    }
  }
  
  if (!missing(ethnicity_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(ethnicity_source_value)) {
      statement <- paste0(statement, " ethnicity_source_value IS NULL")
    } else {
      statement <- paste0(statement, " ethnicity_source_value = '", ethnicity_source_value,"'")
    }
  }
  
  if (!missing(time_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(time_of_birth)) {
      statement <- paste0(statement, " time_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " time_of_birth = '", time_of_birth,"'")
    }
  }
  
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(location_id)) {
      statement <- paste0(statement, " location_id IS NULL")
    } else {
      statement <- paste0(statement, " location_id = '", location_id,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_id)) {
      statement <- paste0(statement, " care_site_id IS NULL")
    } else {
      statement <- paste0(statement, " care_site_id = '", care_site_id,"'")
    }
  }
  
  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_source_concept_id)) {
      statement <- paste0(statement, " gender_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " gender_source_concept_id = '", gender_source_concept_id,"'")
    }
  }
  
  if (!missing(race_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(race_source_concept_id)) {
      statement <- paste0(statement, " race_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " race_source_concept_id = '", race_source_concept_id,"'")
    }
  }
  
  if (!missing(ethnicity_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(ethnicity_source_concept_id)) {
      statement <- paste0(statement, " ethnicity_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " ethnicity_source_concept_id = '", ethnicity_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_visit_occurrence <- function(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_time, visit_end_date, visit_end_time, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE")
  first <- TRUE
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(visit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_concept_id)) {
      statement <- paste0(statement, " visit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_concept_id = '", visit_concept_id,"'")
    }
  }
  
  if (!missing(visit_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_start_date)) {
      statement <- paste0(statement, " visit_start_date IS NULL")
    } else {
      statement <- paste0(statement, " visit_start_date = '", visit_start_date,"'")
    }
  }
  
  if (!missing(visit_start_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_start_time)) {
      statement <- paste0(statement, " visit_start_time IS NULL")
    } else {
      statement <- paste0(statement, " visit_start_time = '", visit_start_time,"'")
    }
  }
  
  if (!missing(visit_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_end_date)) {
      statement <- paste0(statement, " visit_end_date IS NULL")
    } else {
      statement <- paste0(statement, " visit_end_date = '", visit_end_date,"'")
    }
  }
  
  if (!missing(visit_end_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_end_time)) {
      statement <- paste0(statement, " visit_end_time IS NULL")
    } else {
      statement <- paste0(statement, " visit_end_time = '", visit_end_time,"'")
    }
  }
  
  if (!missing(visit_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_type_concept_id)) {
      statement <- paste0(statement, " visit_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_type_concept_id = '", visit_type_concept_id,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_id)) {
      statement <- paste0(statement, " care_site_id IS NULL")
    } else {
      statement <- paste0(statement, " care_site_id = '", care_site_id,"'")
    }
  }
  
  if (!missing(visit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_source_value)) {
      statement <- paste0(statement, " visit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " visit_source_value = '", visit_source_value,"'")
    }
  }
  
  if (!missing(visit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_source_concept_id)) {
      statement <- paste0(statement, " visit_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_source_concept_id = '", visit_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_observation_period <- function(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE")
  first <- TRUE
  if (!missing(observation_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_period_id)) {
      statement <- paste0(statement, " observation_period_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_period_id = '", observation_period_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(observation_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_period_start_date)) {
      statement <- paste0(statement, " observation_period_start_date IS NULL")
    } else {
      statement <- paste0(statement, " observation_period_start_date = '", observation_period_start_date,"'")
    }
  }
  
  if (!missing(observation_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_period_end_date)) {
      statement <- paste0(statement, " observation_period_end_date IS NULL")
    } else {
      statement <- paste0(statement, " observation_period_end_date = '", observation_period_end_date,"'")
    }
  }
  
  if (!missing(period_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(period_type_concept_id)) {
      statement <- paste0(statement, " period_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " period_type_concept_id = '", period_type_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_location <- function(location_id, address_1, address_2, city, state, zip, county, location_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect location' AS test, CASE WHEN(SELECT COUNT(*) FROM location WHERE")
  first <- TRUE
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(location_id)) {
      statement <- paste0(statement, " location_id IS NULL")
    } else {
      statement <- paste0(statement, " location_id = '", location_id,"'")
    }
  }
  
  if (!missing(address_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(address_1)) {
      statement <- paste0(statement, " address_1 IS NULL")
    } else {
      statement <- paste0(statement, " address_1 = '", address_1,"'")
    }
  }
  
  if (!missing(address_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(address_2)) {
      statement <- paste0(statement, " address_2 IS NULL")
    } else {
      statement <- paste0(statement, " address_2 = '", address_2,"'")
    }
  }
  
  if (!missing(city)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(city)) {
      statement <- paste0(statement, " city IS NULL")
    } else {
      statement <- paste0(statement, " city = '", city,"'")
    }
  }
  
  if (!missing(state)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(state)) {
      statement <- paste0(statement, " state IS NULL")
    } else {
      statement <- paste0(statement, " state = '", state,"'")
    }
  }
  
  if (!missing(zip)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(zip)) {
      statement <- paste0(statement, " zip IS NULL")
    } else {
      statement <- paste0(statement, " zip = '", zip,"'")
    }
  }
  
  if (!missing(county)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(county)) {
      statement <- paste0(statement, " county IS NULL")
    } else {
      statement <- paste0(statement, " county = '", county,"'")
    }
  }
  
  if (!missing(location_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(location_source_value)) {
      statement <- paste0(statement, " location_source_value IS NULL")
    } else {
      statement <- paste0(statement, " location_source_value = '", location_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_care_site <- function(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect care_site' AS test, CASE WHEN(SELECT COUNT(*) FROM care_site WHERE")
  first <- TRUE
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_id)) {
      statement <- paste0(statement, " care_site_id IS NULL")
    } else {
      statement <- paste0(statement, " care_site_id = '", care_site_id,"'")
    }
  }
  
  if (!missing(care_site_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_name)) {
      statement <- paste0(statement, " care_site_name IS NULL")
    } else {
      statement <- paste0(statement, " care_site_name = '", care_site_name,"'")
    }
  }
  
  if (!missing(place_of_service_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(place_of_service_concept_id)) {
      statement <- paste0(statement, " place_of_service_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " place_of_service_concept_id = '", place_of_service_concept_id,"'")
    }
  }
  
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(location_id)) {
      statement <- paste0(statement, " location_id IS NULL")
    } else {
      statement <- paste0(statement, " location_id = '", location_id,"'")
    }
  }
  
  if (!missing(care_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_source_value)) {
      statement <- paste0(statement, " care_site_source_value IS NULL")
    } else {
      statement <- paste0(statement, " care_site_source_value = '", care_site_source_value,"'")
    }
  }
  
  if (!missing(place_of_service_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(place_of_service_source_value)) {
      statement <- paste0(statement, " place_of_service_source_value IS NULL")
    } else {
      statement <- paste0(statement, " place_of_service_source_value = '", place_of_service_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_condition_occurrence <- function(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_end_date, condition_type_concept_id, stop_reason, provider_id, visit_occurrence_id, condition_source_value, condition_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE")
  first <- TRUE
  if (!missing(condition_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_occurrence_id)) {
      statement <- paste0(statement, " condition_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_occurrence_id = '", condition_occurrence_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_concept_id)) {
      statement <- paste0(statement, " condition_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_concept_id = '", condition_concept_id,"'")
    }
  }
  
  if (!missing(condition_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_start_date)) {
      statement <- paste0(statement, " condition_start_date IS NULL")
    } else {
      statement <- paste0(statement, " condition_start_date = '", condition_start_date,"'")
    }
  }
  
  if (!missing(condition_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_end_date)) {
      statement <- paste0(statement, " condition_end_date IS NULL")
    } else {
      statement <- paste0(statement, " condition_end_date = '", condition_end_date,"'")
    }
  }
  
  if (!missing(condition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_type_concept_id)) {
      statement <- paste0(statement, " condition_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_type_concept_id = '", condition_type_concept_id,"'")
    }
  }
  
  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(stop_reason)) {
      statement <- paste0(statement, " stop_reason IS NULL")
    } else {
      statement <- paste0(statement, " stop_reason = '", stop_reason,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(condition_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_source_value)) {
      statement <- paste0(statement, " condition_source_value IS NULL")
    } else {
      statement <- paste0(statement, " condition_source_value = '", condition_source_value,"'")
    }
  }
  
  if (!missing(condition_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_source_concept_id)) {
      statement <- paste0(statement, " condition_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_source_concept_id = '", condition_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_death <- function(person_id, death_date, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect death' AS test, CASE WHEN(SELECT COUNT(*) FROM death WHERE")
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(death_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(death_date)) {
      statement <- paste0(statement, " death_date IS NULL")
    } else {
      statement <- paste0(statement, " death_date = '", death_date,"'")
    }
  }
  
  if (!missing(death_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(death_type_concept_id)) {
      statement <- paste0(statement, " death_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " death_type_concept_id = '", death_type_concept_id,"'")
    }
  }
  
  if (!missing(cause_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cause_concept_id)) {
      statement <- paste0(statement, " cause_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " cause_concept_id = '", cause_concept_id,"'")
    }
  }
  
  if (!missing(cause_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cause_source_value)) {
      statement <- paste0(statement, " cause_source_value IS NULL")
    } else {
      statement <- paste0(statement, " cause_source_value = '", cause_source_value,"'")
    }
  }
  
  if (!missing(cause_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cause_source_concept_id)) {
      statement <- paste0(statement, " cause_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " cause_source_concept_id = '", cause_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_drug_exposure <- function(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, effective_drug_dose, dose_unit_concept_id, lot_number, provider_id, visit_occurrence_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect drug_exposure' AS test, CASE WHEN(SELECT COUNT(*) FROM drug_exposure WHERE")
  first <- TRUE
  if (!missing(drug_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_id)) {
      statement <- paste0(statement, " drug_exposure_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_id = '", drug_exposure_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_concept_id)) {
      statement <- paste0(statement, " drug_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_concept_id = '", drug_concept_id,"'")
    }
  }
  
  if (!missing(drug_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_start_date)) {
      statement <- paste0(statement, " drug_exposure_start_date IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_start_date = '", drug_exposure_start_date,"'")
    }
  }
  
  if (!missing(drug_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_end_date)) {
      statement <- paste0(statement, " drug_exposure_end_date IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_end_date = '", drug_exposure_end_date,"'")
    }
  }
  
  if (!missing(drug_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_type_concept_id)) {
      statement <- paste0(statement, " drug_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_type_concept_id = '", drug_type_concept_id,"'")
    }
  }
  
  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(stop_reason)) {
      statement <- paste0(statement, " stop_reason IS NULL")
    } else {
      statement <- paste0(statement, " stop_reason = '", stop_reason,"'")
    }
  }
  
  if (!missing(refills)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(refills)) {
      statement <- paste0(statement, " refills IS NULL")
    } else {
      statement <- paste0(statement, " refills = '", refills,"'")
    }
  }
  
  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(quantity)) {
      statement <- paste0(statement, " quantity IS NULL")
    } else {
      statement <- paste0(statement, " quantity = '", quantity,"'")
    }
  }
  
  if (!missing(days_supply)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(days_supply)) {
      statement <- paste0(statement, " days_supply IS NULL")
    } else {
      statement <- paste0(statement, " days_supply = '", days_supply,"'")
    }
  }
  
  if (!missing(sig)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(sig)) {
      statement <- paste0(statement, " sig IS NULL")
    } else {
      statement <- paste0(statement, " sig = '", sig,"'")
    }
  }
  
  if (!missing(route_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(route_concept_id)) {
      statement <- paste0(statement, " route_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " route_concept_id = '", route_concept_id,"'")
    }
  }
  
  if (!missing(effective_drug_dose)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(effective_drug_dose)) {
      statement <- paste0(statement, " effective_drug_dose IS NULL")
    } else {
      statement <- paste0(statement, " effective_drug_dose = '", effective_drug_dose,"'")
    }
  }
  
  if (!missing(dose_unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_unit_concept_id)) {
      statement <- paste0(statement, " dose_unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " dose_unit_concept_id = '", dose_unit_concept_id,"'")
    }
  }
  
  if (!missing(lot_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(lot_number)) {
      statement <- paste0(statement, " lot_number IS NULL")
    } else {
      statement <- paste0(statement, " lot_number = '", lot_number,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(drug_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_source_value)) {
      statement <- paste0(statement, " drug_source_value IS NULL")
    } else {
      statement <- paste0(statement, " drug_source_value = '", drug_source_value,"'")
    }
  }
  
  if (!missing(drug_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_source_concept_id)) {
      statement <- paste0(statement, " drug_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_source_concept_id = '", drug_source_concept_id,"'")
    }
  }
  
  if (!missing(route_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(route_source_value)) {
      statement <- paste0(statement, " route_source_value IS NULL")
    } else {
      statement <- paste0(statement, " route_source_value = '", route_source_value,"'")
    }
  }
  
  if (!missing(dose_unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_unit_source_value)) {
      statement <- paste0(statement, " dose_unit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " dose_unit_source_value = '", dose_unit_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_device_exposure <- function(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_end_date, device_type_concept_id, unique_device_id, quantity, provider_id, visit_occurrence_id, device_source_value, device_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect device_exposure' AS test, CASE WHEN(SELECT COUNT(*) FROM device_exposure WHERE")
  first <- TRUE
  if (!missing(device_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_exposure_id)) {
      statement <- paste0(statement, " device_exposure_id IS NULL")
    } else {
      statement <- paste0(statement, " device_exposure_id = '", device_exposure_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(device_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_concept_id)) {
      statement <- paste0(statement, " device_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " device_concept_id = '", device_concept_id,"'")
    }
  }
  
  if (!missing(device_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_exposure_start_date)) {
      statement <- paste0(statement, " device_exposure_start_date IS NULL")
    } else {
      statement <- paste0(statement, " device_exposure_start_date = '", device_exposure_start_date,"'")
    }
  }
  
  if (!missing(device_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_exposure_end_date)) {
      statement <- paste0(statement, " device_exposure_end_date IS NULL")
    } else {
      statement <- paste0(statement, " device_exposure_end_date = '", device_exposure_end_date,"'")
    }
  }
  
  if (!missing(device_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_type_concept_id)) {
      statement <- paste0(statement, " device_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " device_type_concept_id = '", device_type_concept_id,"'")
    }
  }
  
  if (!missing(unique_device_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unique_device_id)) {
      statement <- paste0(statement, " unique_device_id IS NULL")
    } else {
      statement <- paste0(statement, " unique_device_id = '", unique_device_id,"'")
    }
  }
  
  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(quantity)) {
      statement <- paste0(statement, " quantity IS NULL")
    } else {
      statement <- paste0(statement, " quantity = '", quantity,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(device_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_source_value)) {
      statement <- paste0(statement, " device_source_value IS NULL")
    } else {
      statement <- paste0(statement, " device_source_value = '", device_source_value,"'")
    }
  }
  
  if (!missing(device_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_source_concept_id)) {
      statement <- paste0(statement, " device_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " device_source_concept_id = '", device_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_procedure_occurrence <- function(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, procedure_source_value, procedure_source_concept_id, qualifier_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE")
  first <- TRUE
  if (!missing(procedure_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_occurrence_id)) {
      statement <- paste0(statement, " procedure_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_occurrence_id = '", procedure_occurrence_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(procedure_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_concept_id)) {
      statement <- paste0(statement, " procedure_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_concept_id = '", procedure_concept_id,"'")
    }
  }
  
  if (!missing(procedure_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_date)) {
      statement <- paste0(statement, " procedure_date IS NULL")
    } else {
      statement <- paste0(statement, " procedure_date = '", procedure_date,"'")
    }
  }
  
  if (!missing(procedure_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_type_concept_id)) {
      statement <- paste0(statement, " procedure_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_type_concept_id = '", procedure_type_concept_id,"'")
    }
  }
  
  if (!missing(modifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(modifier_concept_id)) {
      statement <- paste0(statement, " modifier_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " modifier_concept_id = '", modifier_concept_id,"'")
    }
  }
  
  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(quantity)) {
      statement <- paste0(statement, " quantity IS NULL")
    } else {
      statement <- paste0(statement, " quantity = '", quantity,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(procedure_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_source_value)) {
      statement <- paste0(statement, " procedure_source_value IS NULL")
    } else {
      statement <- paste0(statement, " procedure_source_value = '", procedure_source_value,"'")
    }
  }
  
  if (!missing(procedure_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_source_concept_id)) {
      statement <- paste0(statement, " procedure_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_source_concept_id = '", procedure_source_concept_id,"'")
    }
  }
  
  if (!missing(qualifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(qualifier_source_value)) {
      statement <- paste0(statement, " qualifier_source_value IS NULL")
    } else {
      statement <- paste0(statement, " qualifier_source_value = '", qualifier_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_measurement <- function(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect measurement' AS test, CASE WHEN(SELECT COUNT(*) FROM measurement WHERE")
  first <- TRUE
  if (!missing(measurement_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_id)) {
      statement <- paste0(statement, " measurement_id IS NULL")
    } else {
      statement <- paste0(statement, " measurement_id = '", measurement_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(measurement_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_concept_id)) {
      statement <- paste0(statement, " measurement_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " measurement_concept_id = '", measurement_concept_id,"'")
    }
  }
  
  if (!missing(measurement_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_date)) {
      statement <- paste0(statement, " measurement_date IS NULL")
    } else {
      statement <- paste0(statement, " measurement_date = '", measurement_date,"'")
    }
  }
  
  if (!missing(measurement_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_time)) {
      statement <- paste0(statement, " measurement_time IS NULL")
    } else {
      statement <- paste0(statement, " measurement_time = '", measurement_time,"'")
    }
  }
  
  if (!missing(measurement_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_type_concept_id)) {
      statement <- paste0(statement, " measurement_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " measurement_type_concept_id = '", measurement_type_concept_id,"'")
    }
  }
  
  if (!missing(operator_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(operator_concept_id)) {
      statement <- paste0(statement, " operator_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " operator_concept_id = '", operator_concept_id,"'")
    }
  }
  
  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_number)) {
      statement <- paste0(statement, " value_as_number IS NULL")
    } else {
      statement <- paste0(statement, " value_as_number = '", value_as_number,"'")
    }
  }
  
  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_concept_id)) {
      statement <- paste0(statement, " value_as_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " value_as_concept_id = '", value_as_concept_id,"'")
    }
  }
  
  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_concept_id)) {
      statement <- paste0(statement, " unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " unit_concept_id = '", unit_concept_id,"'")
    }
  }
  
  if (!missing(range_low)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(range_low)) {
      statement <- paste0(statement, " range_low IS NULL")
    } else {
      statement <- paste0(statement, " range_low = '", range_low,"'")
    }
  }
  
  if (!missing(range_high)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(range_high)) {
      statement <- paste0(statement, " range_high IS NULL")
    } else {
      statement <- paste0(statement, " range_high = '", range_high,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(measurement_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_source_value)) {
      statement <- paste0(statement, " measurement_source_value IS NULL")
    } else {
      statement <- paste0(statement, " measurement_source_value = '", measurement_source_value,"'")
    }
  }
  
  if (!missing(measurement_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_source_concept_id)) {
      statement <- paste0(statement, " measurement_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " measurement_source_concept_id = '", measurement_source_concept_id,"'")
    }
  }
  
  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_source_value)) {
      statement <- paste0(statement, " unit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " unit_source_value = '", unit_source_value,"'")
    }
  }
  
  if (!missing(value_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_source_value)) {
      statement <- paste0(statement, " value_source_value IS NULL")
    } else {
      statement <- paste0(statement, " value_source_value = '", value_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_observation <- function(observation_id, person_id, observation_concept_id, observation_date, observation_time, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect observation' AS test, CASE WHEN(SELECT COUNT(*) FROM observation WHERE")
  first <- TRUE
  if (!missing(observation_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_id)) {
      statement <- paste0(statement, " observation_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_id = '", observation_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(observation_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_concept_id)) {
      statement <- paste0(statement, " observation_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_concept_id = '", observation_concept_id,"'")
    }
  }
  
  if (!missing(observation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_date)) {
      statement <- paste0(statement, " observation_date IS NULL")
    } else {
      statement <- paste0(statement, " observation_date = '", observation_date,"'")
    }
  }
  
  if (!missing(observation_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_time)) {
      statement <- paste0(statement, " observation_time IS NULL")
    } else {
      statement <- paste0(statement, " observation_time = '", observation_time,"'")
    }
  }
  
  if (!missing(observation_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_type_concept_id)) {
      statement <- paste0(statement, " observation_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_type_concept_id = '", observation_type_concept_id,"'")
    }
  }
  
  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_number)) {
      statement <- paste0(statement, " value_as_number IS NULL")
    } else {
      statement <- paste0(statement, " value_as_number = '", value_as_number,"'")
    }
  }
  
  if (!missing(value_as_string)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_string)) {
      statement <- paste0(statement, " value_as_string IS NULL")
    } else {
      statement <- paste0(statement, " value_as_string = '", value_as_string,"'")
    }
  }
  
  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_concept_id)) {
      statement <- paste0(statement, " value_as_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " value_as_concept_id = '", value_as_concept_id,"'")
    }
  }
  
  if (!missing(qualifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(qualifier_concept_id)) {
      statement <- paste0(statement, " qualifier_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " qualifier_concept_id = '", qualifier_concept_id,"'")
    }
  }
  
  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_concept_id)) {
      statement <- paste0(statement, " unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " unit_concept_id = '", unit_concept_id,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(observation_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_source_value)) {
      statement <- paste0(statement, " observation_source_value IS NULL")
    } else {
      statement <- paste0(statement, " observation_source_value = '", observation_source_value,"'")
    }
  }
  
  if (!missing(observation_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_source_concept_id)) {
      statement <- paste0(statement, " observation_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_source_concept_id = '", observation_source_concept_id,"'")
    }
  }
  
  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_source_value)) {
      statement <- paste0(statement, " unit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " unit_source_value = '", unit_source_value,"'")
    }
  }
  
  if (!missing(qualifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(qualifier_source_value)) {
      statement <- paste0(statement, " qualifier_source_value IS NULL")
    } else {
      statement <- paste0(statement, " qualifier_source_value = '", qualifier_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_provider <- function(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect provider' AS test, CASE WHEN(SELECT COUNT(*) FROM provider WHERE")
  first <- TRUE
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(provider_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_name)) {
      statement <- paste0(statement, " provider_name IS NULL")
    } else {
      statement <- paste0(statement, " provider_name = '", provider_name,"'")
    }
  }
  
  if (!missing(npi)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(npi)) {
      statement <- paste0(statement, " npi IS NULL")
    } else {
      statement <- paste0(statement, " npi = '", npi,"'")
    }
  }
  
  if (!missing(dea)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dea)) {
      statement <- paste0(statement, " dea IS NULL")
    } else {
      statement <- paste0(statement, " dea = '", dea,"'")
    }
  }
  
  if (!missing(specialty_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specialty_concept_id)) {
      statement <- paste0(statement, " specialty_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " specialty_concept_id = '", specialty_concept_id,"'")
    }
  }
  
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_id)) {
      statement <- paste0(statement, " care_site_id IS NULL")
    } else {
      statement <- paste0(statement, " care_site_id = '", care_site_id,"'")
    }
  }
  
  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(year_of_birth)) {
      statement <- paste0(statement, " year_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " year_of_birth = '", year_of_birth,"'")
    }
  }
  
  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_concept_id)) {
      statement <- paste0(statement, " gender_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " gender_concept_id = '", gender_concept_id,"'")
    }
  }
  
  if (!missing(provider_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_source_value)) {
      statement <- paste0(statement, " provider_source_value IS NULL")
    } else {
      statement <- paste0(statement, " provider_source_value = '", provider_source_value,"'")
    }
  }
  
  if (!missing(specialty_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specialty_source_value)) {
      statement <- paste0(statement, " specialty_source_value IS NULL")
    } else {
      statement <- paste0(statement, " specialty_source_value = '", specialty_source_value,"'")
    }
  }
  
  if (!missing(specialty_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specialty_source_concept_id)) {
      statement <- paste0(statement, " specialty_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " specialty_source_concept_id = '", specialty_source_concept_id,"'")
    }
  }
  
  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_source_value)) {
      statement <- paste0(statement, " gender_source_value IS NULL")
    } else {
      statement <- paste0(statement, " gender_source_value = '", gender_source_value,"'")
    }
  }
  
  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_source_concept_id)) {
      statement <- paste0(statement, " gender_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " gender_source_concept_id = '", gender_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_note <- function(note_id, person_id, note_date, note_time, note_type_concept_id, note_text, provider_id, visit_occurrence_id, note_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect note' AS test, CASE WHEN(SELECT COUNT(*) FROM note WHERE")
  first <- TRUE
  if (!missing(note_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_id)) {
      statement <- paste0(statement, " note_id IS NULL")
    } else {
      statement <- paste0(statement, " note_id = '", note_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(note_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_date)) {
      statement <- paste0(statement, " note_date IS NULL")
    } else {
      statement <- paste0(statement, " note_date = '", note_date,"'")
    }
  }
  
  if (!missing(note_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_time)) {
      statement <- paste0(statement, " note_time IS NULL")
    } else {
      statement <- paste0(statement, " note_time = '", note_time,"'")
    }
  }
  
  if (!missing(note_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_type_concept_id)) {
      statement <- paste0(statement, " note_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " note_type_concept_id = '", note_type_concept_id,"'")
    }
  }
  
  if (!missing(note_text)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_text)) {
      statement <- paste0(statement, " note_text IS NULL")
    } else {
      statement <- paste0(statement, " note_text = '", note_text,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(note_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_source_value)) {
      statement <- paste0(statement, " note_source_value IS NULL")
    } else {
      statement <- paste0(statement, " note_source_value = '", note_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_specimen <- function(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_time, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect specimen' AS test, CASE WHEN(SELECT COUNT(*) FROM specimen WHERE")
  first <- TRUE
  if (!missing(specimen_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_id)) {
      statement <- paste0(statement, " specimen_id IS NULL")
    } else {
      statement <- paste0(statement, " specimen_id = '", specimen_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(specimen_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_concept_id)) {
      statement <- paste0(statement, " specimen_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " specimen_concept_id = '", specimen_concept_id,"'")
    }
  }
  
  if (!missing(specimen_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_type_concept_id)) {
      statement <- paste0(statement, " specimen_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " specimen_type_concept_id = '", specimen_type_concept_id,"'")
    }
  }
  
  if (!missing(specimen_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_date)) {
      statement <- paste0(statement, " specimen_date IS NULL")
    } else {
      statement <- paste0(statement, " specimen_date = '", specimen_date,"'")
    }
  }
  
  if (!missing(specimen_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_time)) {
      statement <- paste0(statement, " specimen_time IS NULL")
    } else {
      statement <- paste0(statement, " specimen_time = '", specimen_time,"'")
    }
  }
  
  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(quantity)) {
      statement <- paste0(statement, " quantity IS NULL")
    } else {
      statement <- paste0(statement, " quantity = '", quantity,"'")
    }
  }
  
  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_concept_id)) {
      statement <- paste0(statement, " unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " unit_concept_id = '", unit_concept_id,"'")
    }
  }
  
  if (!missing(anatomic_site_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(anatomic_site_concept_id)) {
      statement <- paste0(statement, " anatomic_site_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " anatomic_site_concept_id = '", anatomic_site_concept_id,"'")
    }
  }
  
  if (!missing(disease_status_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(disease_status_concept_id)) {
      statement <- paste0(statement, " disease_status_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " disease_status_concept_id = '", disease_status_concept_id,"'")
    }
  }
  
  if (!missing(specimen_source_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_source_id)) {
      statement <- paste0(statement, " specimen_source_id IS NULL")
    } else {
      statement <- paste0(statement, " specimen_source_id = '", specimen_source_id,"'")
    }
  }
  
  if (!missing(specimen_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_source_value)) {
      statement <- paste0(statement, " specimen_source_value IS NULL")
    } else {
      statement <- paste0(statement, " specimen_source_value = '", specimen_source_value,"'")
    }
  }
  
  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_source_value)) {
      statement <- paste0(statement, " unit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " unit_source_value = '", unit_source_value,"'")
    }
  }
  
  if (!missing(anatomic_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(anatomic_site_source_value)) {
      statement <- paste0(statement, " anatomic_site_source_value IS NULL")
    } else {
      statement <- paste0(statement, " anatomic_site_source_value = '", anatomic_site_source_value,"'")
    }
  }
  
  if (!missing(disease_status_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(disease_status_source_value)) {
      statement <- paste0(statement, " disease_status_source_value IS NULL")
    } else {
      statement <- paste0(statement, " disease_status_source_value = '", disease_status_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_fact_relationship <- function(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect fact_relationship' AS test, CASE WHEN(SELECT COUNT(*) FROM fact_relationship WHERE")
  first <- TRUE
  if (!missing(domain_concept_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(domain_concept_id_1)) {
      statement <- paste0(statement, " domain_concept_id_1 IS NULL")
    } else {
      statement <- paste0(statement, " domain_concept_id_1 = '", domain_concept_id_1,"'")
    }
  }
  
  if (!missing(fact_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(fact_id_1)) {
      statement <- paste0(statement, " fact_id_1 IS NULL")
    } else {
      statement <- paste0(statement, " fact_id_1 = '", fact_id_1,"'")
    }
  }
  
  if (!missing(domain_concept_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(domain_concept_id_2)) {
      statement <- paste0(statement, " domain_concept_id_2 IS NULL")
    } else {
      statement <- paste0(statement, " domain_concept_id_2 = '", domain_concept_id_2,"'")
    }
  }
  
  if (!missing(fact_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(fact_id_2)) {
      statement <- paste0(statement, " fact_id_2 IS NULL")
    } else {
      statement <- paste0(statement, " fact_id_2 = '", fact_id_2,"'")
    }
  }
  
  if (!missing(relationship_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(relationship_concept_id)) {
      statement <- paste0(statement, " relationship_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " relationship_concept_id = '", relationship_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_procedure_cost <- function(procedure_cost_id, procedure_occurrence_id, currency_concept_id, paid_copay, paid_coinsurance, paid_toward_deductible, paid_by_payer, paid_by_coordination_benefits, total_out_of_pocket, total_paid, revenue_code_concept_id, payer_plan_period_id, revenue_code_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect procedure_cost' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_cost WHERE")
  first <- TRUE
  if (!missing(procedure_cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_cost_id)) {
      statement <- paste0(statement, " procedure_cost_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_cost_id = '", procedure_cost_id,"'")
    }
  }
  
  if (!missing(procedure_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_occurrence_id)) {
      statement <- paste0(statement, " procedure_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_occurrence_id = '", procedure_occurrence_id,"'")
    }
  }
  
  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(currency_concept_id)) {
      statement <- paste0(statement, " currency_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " currency_concept_id = '", currency_concept_id,"'")
    }
  }
  
  if (!missing(paid_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_copay)) {
      statement <- paste0(statement, " paid_copay IS NULL")
    } else {
      statement <- paste0(statement, " paid_copay = '", paid_copay,"'")
    }
  }
  
  if (!missing(paid_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_coinsurance)) {
      statement <- paste0(statement, " paid_coinsurance IS NULL")
    } else {
      statement <- paste0(statement, " paid_coinsurance = '", paid_coinsurance,"'")
    }
  }
  
  if (!missing(paid_toward_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_toward_deductible)) {
      statement <- paste0(statement, " paid_toward_deductible IS NULL")
    } else {
      statement <- paste0(statement, " paid_toward_deductible = '", paid_toward_deductible,"'")
    }
  }
  
  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_payer)) {
      statement <- paste0(statement, " paid_by_payer IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_payer = '", paid_by_payer,"'")
    }
  }
  
  if (!missing(paid_by_coordination_benefits)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_coordination_benefits)) {
      statement <- paste0(statement, " paid_by_coordination_benefits IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_coordination_benefits = '", paid_by_coordination_benefits,"'")
    }
  }
  
  if (!missing(total_out_of_pocket)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_out_of_pocket)) {
      statement <- paste0(statement, " total_out_of_pocket IS NULL")
    } else {
      statement <- paste0(statement, " total_out_of_pocket = '", total_out_of_pocket,"'")
    }
  }
  
  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_paid)) {
      statement <- paste0(statement, " total_paid IS NULL")
    } else {
      statement <- paste0(statement, " total_paid = '", total_paid,"'")
    }
  }
  
  if (!missing(revenue_code_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(revenue_code_concept_id)) {
      statement <- paste0(statement, " revenue_code_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " revenue_code_concept_id = '", revenue_code_concept_id,"'")
    }
  }
  
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  if (!missing(revenue_code_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(revenue_code_source_value)) {
      statement <- paste0(statement, " revenue_code_source_value IS NULL")
    } else {
      statement <- paste0(statement, " revenue_code_source_value = '", revenue_code_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_visit_cost <- function(visit_cost_id, visit_occurrence_id, currency_concept_id, paid_copay, paid_coinsurance, paid_toward_deductible, paid_by_payer, paid_by_coordination_benefits, total_out_of_pocket, total_paid, payer_plan_period_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect visit_cost' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_cost WHERE")
  first <- TRUE
  if (!missing(visit_cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_cost_id)) {
      statement <- paste0(statement, " visit_cost_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_cost_id = '", visit_cost_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(currency_concept_id)) {
      statement <- paste0(statement, " currency_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " currency_concept_id = '", currency_concept_id,"'")
    }
  }
  
  if (!missing(paid_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_copay)) {
      statement <- paste0(statement, " paid_copay IS NULL")
    } else {
      statement <- paste0(statement, " paid_copay = '", paid_copay,"'")
    }
  }
  
  if (!missing(paid_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_coinsurance)) {
      statement <- paste0(statement, " paid_coinsurance IS NULL")
    } else {
      statement <- paste0(statement, " paid_coinsurance = '", paid_coinsurance,"'")
    }
  }
  
  if (!missing(paid_toward_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_toward_deductible)) {
      statement <- paste0(statement, " paid_toward_deductible IS NULL")
    } else {
      statement <- paste0(statement, " paid_toward_deductible = '", paid_toward_deductible,"'")
    }
  }
  
  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_payer)) {
      statement <- paste0(statement, " paid_by_payer IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_payer = '", paid_by_payer,"'")
    }
  }
  
  if (!missing(paid_by_coordination_benefits)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_coordination_benefits)) {
      statement <- paste0(statement, " paid_by_coordination_benefits IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_coordination_benefits = '", paid_by_coordination_benefits,"'")
    }
  }
  
  if (!missing(total_out_of_pocket)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_out_of_pocket)) {
      statement <- paste0(statement, " total_out_of_pocket IS NULL")
    } else {
      statement <- paste0(statement, " total_out_of_pocket = '", total_out_of_pocket,"'")
    }
  }
  
  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_paid)) {
      statement <- paste0(statement, " total_paid IS NULL")
    } else {
      statement <- paste0(statement, " total_paid = '", total_paid,"'")
    }
  }
  
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_drug_cost <- function(drug_cost_id, drug_exposure_id, currency_concept_id, paid_copay, paid_coinsurance, paid_toward_deductible, paid_by_payer, paid_by_coordination_benefits, total_out_of_pocket, total_paid, ingredient_cost, dispensing_fee, average_wholesale_price, payer_plan_period_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect drug_cost' AS test, CASE WHEN(SELECT COUNT(*) FROM drug_cost WHERE")
  first <- TRUE
  if (!missing(drug_cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_cost_id)) {
      statement <- paste0(statement, " drug_cost_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_cost_id = '", drug_cost_id,"'")
    }
  }
  
  if (!missing(drug_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_id)) {
      statement <- paste0(statement, " drug_exposure_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_id = '", drug_exposure_id,"'")
    }
  }
  
  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(currency_concept_id)) {
      statement <- paste0(statement, " currency_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " currency_concept_id = '", currency_concept_id,"'")
    }
  }
  
  if (!missing(paid_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_copay)) {
      statement <- paste0(statement, " paid_copay IS NULL")
    } else {
      statement <- paste0(statement, " paid_copay = '", paid_copay,"'")
    }
  }
  
  if (!missing(paid_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_coinsurance)) {
      statement <- paste0(statement, " paid_coinsurance IS NULL")
    } else {
      statement <- paste0(statement, " paid_coinsurance = '", paid_coinsurance,"'")
    }
  }
  
  if (!missing(paid_toward_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_toward_deductible)) {
      statement <- paste0(statement, " paid_toward_deductible IS NULL")
    } else {
      statement <- paste0(statement, " paid_toward_deductible = '", paid_toward_deductible,"'")
    }
  }
  
  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_payer)) {
      statement <- paste0(statement, " paid_by_payer IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_payer = '", paid_by_payer,"'")
    }
  }
  
  if (!missing(paid_by_coordination_benefits)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_coordination_benefits)) {
      statement <- paste0(statement, " paid_by_coordination_benefits IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_coordination_benefits = '", paid_by_coordination_benefits,"'")
    }
  }
  
  if (!missing(total_out_of_pocket)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_out_of_pocket)) {
      statement <- paste0(statement, " total_out_of_pocket IS NULL")
    } else {
      statement <- paste0(statement, " total_out_of_pocket = '", total_out_of_pocket,"'")
    }
  }
  
  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_paid)) {
      statement <- paste0(statement, " total_paid IS NULL")
    } else {
      statement <- paste0(statement, " total_paid = '", total_paid,"'")
    }
  }
  
  if (!missing(ingredient_cost)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(ingredient_cost)) {
      statement <- paste0(statement, " ingredient_cost IS NULL")
    } else {
      statement <- paste0(statement, " ingredient_cost = '", ingredient_cost,"'")
    }
  }
  
  if (!missing(dispensing_fee)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dispensing_fee)) {
      statement <- paste0(statement, " dispensing_fee IS NULL")
    } else {
      statement <- paste0(statement, " dispensing_fee = '", dispensing_fee,"'")
    }
  }
  
  if (!missing(average_wholesale_price)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(average_wholesale_price)) {
      statement <- paste0(statement, " average_wholesale_price IS NULL")
    } else {
      statement <- paste0(statement, " average_wholesale_price = '", average_wholesale_price,"'")
    }
  }
  
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_payer_plan_period <- function(payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_source_value, plan_source_value, family_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect payer_plan_period' AS test, CASE WHEN(SELECT COUNT(*) FROM payer_plan_period WHERE")
  first <- TRUE
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(payer_plan_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_start_date)) {
      statement <- paste0(statement, " payer_plan_period_start_date IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_start_date = '", payer_plan_period_start_date,"'")
    }
  }
  
  if (!missing(payer_plan_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_end_date)) {
      statement <- paste0(statement, " payer_plan_period_end_date IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_end_date = '", payer_plan_period_end_date,"'")
    }
  }
  
  if (!missing(payer_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_source_value)) {
      statement <- paste0(statement, " payer_source_value IS NULL")
    } else {
      statement <- paste0(statement, " payer_source_value = '", payer_source_value,"'")
    }
  }
  
  if (!missing(plan_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(plan_source_value)) {
      statement <- paste0(statement, " plan_source_value IS NULL")
    } else {
      statement <- paste0(statement, " plan_source_value = '", plan_source_value,"'")
    }
  }
  
  if (!missing(family_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(family_source_value)) {
      statement <- paste0(statement, " family_source_value IS NULL")
    } else {
      statement <- paste0(statement, " family_source_value = '", family_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_device_cost <- function(device_cost_id, device_exposure_id, currency_concept_id, paid_copay, paid_coinsurance, paid_toward_deductible, paid_by_payer, paid_by_coordination_benefits, total_out_of_pocket, total_paid, payer_plan_period_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect device_cost' AS test, CASE WHEN(SELECT COUNT(*) FROM device_cost WHERE")
  first <- TRUE
  if (!missing(device_cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_cost_id)) {
      statement <- paste0(statement, " device_cost_id IS NULL")
    } else {
      statement <- paste0(statement, " device_cost_id = '", device_cost_id,"'")
    }
  }
  
  if (!missing(device_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_exposure_id)) {
      statement <- paste0(statement, " device_exposure_id IS NULL")
    } else {
      statement <- paste0(statement, " device_exposure_id = '", device_exposure_id,"'")
    }
  }
  
  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(currency_concept_id)) {
      statement <- paste0(statement, " currency_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " currency_concept_id = '", currency_concept_id,"'")
    }
  }
  
  if (!missing(paid_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_copay)) {
      statement <- paste0(statement, " paid_copay IS NULL")
    } else {
      statement <- paste0(statement, " paid_copay = '", paid_copay,"'")
    }
  }
  
  if (!missing(paid_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_coinsurance)) {
      statement <- paste0(statement, " paid_coinsurance IS NULL")
    } else {
      statement <- paste0(statement, " paid_coinsurance = '", paid_coinsurance,"'")
    }
  }
  
  if (!missing(paid_toward_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_toward_deductible)) {
      statement <- paste0(statement, " paid_toward_deductible IS NULL")
    } else {
      statement <- paste0(statement, " paid_toward_deductible = '", paid_toward_deductible,"'")
    }
  }
  
  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_payer)) {
      statement <- paste0(statement, " paid_by_payer IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_payer = '", paid_by_payer,"'")
    }
  }
  
  if (!missing(paid_by_coordination_benefits)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_coordination_benefits)) {
      statement <- paste0(statement, " paid_by_coordination_benefits IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_coordination_benefits = '", paid_by_coordination_benefits,"'")
    }
  }
  
  if (!missing(total_out_of_pocket)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_out_of_pocket)) {
      statement <- paste0(statement, " total_out_of_pocket IS NULL")
    } else {
      statement <- paste0(statement, " total_out_of_pocket = '", total_out_of_pocket,"'")
    }
  }
  
  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_paid)) {
      statement <- paste0(statement, " total_paid IS NULL")
    } else {
      statement <- paste0(statement, " total_paid = '", total_paid,"'")
    }
  }
  
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_drug_era <- function(drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect drug_era' AS test, CASE WHEN(SELECT COUNT(*) FROM drug_era WHERE")
  first <- TRUE
  if (!missing(drug_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_era_id)) {
      statement <- paste0(statement, " drug_era_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_era_id = '", drug_era_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_concept_id)) {
      statement <- paste0(statement, " drug_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_concept_id = '", drug_concept_id,"'")
    }
  }
  
  if (!missing(drug_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_era_start_date)) {
      statement <- paste0(statement, " drug_era_start_date IS NULL")
    } else {
      statement <- paste0(statement, " drug_era_start_date = '", drug_era_start_date,"'")
    }
  }
  
  if (!missing(drug_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_era_end_date)) {
      statement <- paste0(statement, " drug_era_end_date IS NULL")
    } else {
      statement <- paste0(statement, " drug_era_end_date = '", drug_era_end_date,"'")
    }
  }
  
  if (!missing(drug_exposure_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_count)) {
      statement <- paste0(statement, " drug_exposure_count IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_count = '", drug_exposure_count,"'")
    }
  }
  
  if (!missing(gap_days)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gap_days)) {
      statement <- paste0(statement, " gap_days IS NULL")
    } else {
      statement <- paste0(statement, " gap_days = '", gap_days,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_dose_era <- function(dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect dose_era' AS test, CASE WHEN(SELECT COUNT(*) FROM dose_era WHERE")
  first <- TRUE
  if (!missing(dose_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_era_id)) {
      statement <- paste0(statement, " dose_era_id IS NULL")
    } else {
      statement <- paste0(statement, " dose_era_id = '", dose_era_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_concept_id)) {
      statement <- paste0(statement, " drug_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_concept_id = '", drug_concept_id,"'")
    }
  }
  
  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_concept_id)) {
      statement <- paste0(statement, " unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " unit_concept_id = '", unit_concept_id,"'")
    }
  }
  
  if (!missing(dose_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_value)) {
      statement <- paste0(statement, " dose_value IS NULL")
    } else {
      statement <- paste0(statement, " dose_value = '", dose_value,"'")
    }
  }
  
  if (!missing(dose_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_era_start_date)) {
      statement <- paste0(statement, " dose_era_start_date IS NULL")
    } else {
      statement <- paste0(statement, " dose_era_start_date = '", dose_era_start_date,"'")
    }
  }
  
  if (!missing(dose_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_era_end_date)) {
      statement <- paste0(statement, " dose_era_end_date IS NULL")
    } else {
      statement <- paste0(statement, " dose_era_end_date = '", dose_era_end_date,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_condition_era <- function(condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect condition_era' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_era WHERE")
  first <- TRUE
  if (!missing(condition_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_era_id)) {
      statement <- paste0(statement, " condition_era_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_era_id = '", condition_era_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_concept_id)) {
      statement <- paste0(statement, " condition_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_concept_id = '", condition_concept_id,"'")
    }
  }
  
  if (!missing(condition_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_era_start_date)) {
      statement <- paste0(statement, " condition_era_start_date IS NULL")
    } else {
      statement <- paste0(statement, " condition_era_start_date = '", condition_era_start_date,"'")
    }
  }
  
  if (!missing(condition_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_era_end_date)) {
      statement <- paste0(statement, " condition_era_end_date IS NULL")
    } else {
      statement <- paste0(statement, " condition_era_end_date = '", condition_era_end_date,"'")
    }
  }
  
  if (!missing(condition_occurrence_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_occurrence_count)) {
      statement <- paste0(statement, " condition_occurrence_count IS NULL")
    } else {
      statement <- paste0(statement, " condition_occurrence_count = '", condition_occurrence_count,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_cdm_source <- function(cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, vocabulary_version) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect cdm_source' AS test, CASE WHEN(SELECT COUNT(*) FROM cdm_source WHERE")
  first <- TRUE
  if (!missing(cdm_source_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_source_name)) {
      statement <- paste0(statement, " cdm_source_name IS NULL")
    } else {
      statement <- paste0(statement, " cdm_source_name = '", cdm_source_name,"'")
    }
  }
  
  if (!missing(cdm_source_abbreviation)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_source_abbreviation)) {
      statement <- paste0(statement, " cdm_source_abbreviation IS NULL")
    } else {
      statement <- paste0(statement, " cdm_source_abbreviation = '", cdm_source_abbreviation,"'")
    }
  }
  
  if (!missing(cdm_holder)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_holder)) {
      statement <- paste0(statement, " cdm_holder IS NULL")
    } else {
      statement <- paste0(statement, " cdm_holder = '", cdm_holder,"'")
    }
  }
  
  if (!missing(source_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(source_description)) {
      statement <- paste0(statement, " source_description IS NULL")
    } else {
      statement <- paste0(statement, " source_description = '", source_description,"'")
    }
  }
  
  if (!missing(source_documentation_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(source_documentation_reference)) {
      statement <- paste0(statement, " source_documentation_reference IS NULL")
    } else {
      statement <- paste0(statement, " source_documentation_reference = '", source_documentation_reference,"'")
    }
  }
  
  if (!missing(cdm_etl_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_etl_reference)) {
      statement <- paste0(statement, " cdm_etl_reference IS NULL")
    } else {
      statement <- paste0(statement, " cdm_etl_reference = '", cdm_etl_reference,"'")
    }
  }
  
  if (!missing(source_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(source_release_date)) {
      statement <- paste0(statement, " source_release_date IS NULL")
    } else {
      statement <- paste0(statement, " source_release_date = '", source_release_date,"'")
    }
  }
  
  if (!missing(cdm_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_release_date)) {
      statement <- paste0(statement, " cdm_release_date IS NULL")
    } else {
      statement <- paste0(statement, " cdm_release_date = '", cdm_release_date,"'")
    }
  }
  
  if (!missing(cdm_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_version)) {
      statement <- paste0(statement, " cdm_version IS NULL")
    } else {
      statement <- paste0(statement, " cdm_version = '", cdm_version,"'")
    }
  }
  
  if (!missing(vocabulary_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(vocabulary_version)) {
      statement <- paste0(statement, " vocabulary_version IS NULL")
    } else {
      statement <- paste0(statement, " vocabulary_version = '", vocabulary_version,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_cohort <- function(cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect cohort' AS test, CASE WHEN(SELECT COUNT(*) FROM cohort WHERE")
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_id)) {
      statement <- paste0(statement, " cohort_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_id = '", cohort_definition_id,"'")
    }
  }
  
  if (!missing(subject_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(subject_id)) {
      statement <- paste0(statement, " subject_id IS NULL")
    } else {
      statement <- paste0(statement, " subject_id = '", subject_id,"'")
    }
  }
  
  if (!missing(cohort_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_start_date)) {
      statement <- paste0(statement, " cohort_start_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_start_date = '", cohort_start_date,"'")
    }
  }
  
  if (!missing(cohort_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_end_date)) {
      statement <- paste0(statement, " cohort_end_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_end_date = '", cohort_end_date,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_cohort_definition <- function(cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_instantiation_date) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect cohort_definition' AS test, CASE WHEN(SELECT COUNT(*) FROM cohort_definition WHERE")
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_id)) {
      statement <- paste0(statement, " cohort_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_id = '", cohort_definition_id,"'")
    }
  }
  
  if (!missing(cohort_definition_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_name)) {
      statement <- paste0(statement, " cohort_definition_name IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_name = '", cohort_definition_name,"'")
    }
  }
  
  if (!missing(cohort_definition_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_description)) {
      statement <- paste0(statement, " cohort_definition_description IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_description = '", cohort_definition_description,"'")
    }
  }
  
  if (!missing(definition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(definition_type_concept_id)) {
      statement <- paste0(statement, " definition_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " definition_type_concept_id = '", definition_type_concept_id,"'")
    }
  }
  
  if (!missing(cohort_definition_syntax)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_syntax)) {
      statement <- paste0(statement, " cohort_definition_syntax IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_syntax = '", cohort_definition_syntax,"'")
    }
  }
  
  if (!missing(subject_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(subject_concept_id)) {
      statement <- paste0(statement, " subject_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " subject_concept_id = '", subject_concept_id,"'")
    }
  }
  
  if (!missing(cohort_instantiation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_instantiation_date)) {
      statement <- paste0(statement, " cohort_instantiation_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_instantiation_date = '", cohort_instantiation_date,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_cohort_attribute <- function(cohort_definition_id, cohort_start_date, cohort_end_date, subject_id, attribute_definition_id, value_as_number, value_as_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect cohort_attribute' AS test, CASE WHEN(SELECT COUNT(*) FROM cohort_attribute WHERE")
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_id)) {
      statement <- paste0(statement, " cohort_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_id = '", cohort_definition_id,"'")
    }
  }
  
  if (!missing(cohort_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_start_date)) {
      statement <- paste0(statement, " cohort_start_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_start_date = '", cohort_start_date,"'")
    }
  }
  
  if (!missing(cohort_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_end_date)) {
      statement <- paste0(statement, " cohort_end_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_end_date = '", cohort_end_date,"'")
    }
  }
  
  if (!missing(subject_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(subject_id)) {
      statement <- paste0(statement, " subject_id IS NULL")
    } else {
      statement <- paste0(statement, " subject_id = '", subject_id,"'")
    }
  }
  
  if (!missing(attribute_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_definition_id)) {
      statement <- paste0(statement, " attribute_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " attribute_definition_id = '", attribute_definition_id,"'")
    }
  }
  
  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_number)) {
      statement <- paste0(statement, " value_as_number IS NULL")
    } else {
      statement <- paste0(statement, " value_as_number = '", value_as_number,"'")
    }
  }
  
  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_concept_id)) {
      statement <- paste0(statement, " value_as_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " value_as_concept_id = '", value_as_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_attribute_definition <- function(attribute_definition_id, attribute_name, attribute_description, attribute_type_concept_id, attribute_syntax) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect attribute_definition' AS test, CASE WHEN(SELECT COUNT(*) FROM attribute_definition WHERE")
  first <- TRUE
  if (!missing(attribute_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_definition_id)) {
      statement <- paste0(statement, " attribute_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " attribute_definition_id = '", attribute_definition_id,"'")
    }
  }
  
  if (!missing(attribute_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_name)) {
      statement <- paste0(statement, " attribute_name IS NULL")
    } else {
      statement <- paste0(statement, " attribute_name = '", attribute_name,"'")
    }
  }
  
  if (!missing(attribute_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_description)) {
      statement <- paste0(statement, " attribute_description IS NULL")
    } else {
      statement <- paste0(statement, " attribute_description = '", attribute_description,"'")
    }
  }
  
  if (!missing(attribute_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_type_concept_id)) {
      statement <- paste0(statement, " attribute_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " attribute_type_concept_id = '", attribute_type_concept_id,"'")
    }
  }
  
  if (!missing(attribute_syntax)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_syntax)) {
      statement <- paste0(statement, " attribute_syntax IS NULL")
    } else {
      statement <- paste0(statement, " attribute_syntax = '", attribute_syntax,"'")
    }
  }
  
  statement <- paste0(statement, ") = 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_person <- function(person_id, person_source_value, gender_concept_id, gender_source_value, year_of_birth, month_of_birth, day_of_birth, race_concept_id, race_source_value, ethnicity_concept_id, ethnicity_source_value, time_of_birth, location_id, provider_id, care_site_id, gender_source_concept_id, race_source_concept_id, ethnicity_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE")
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(person_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_source_value)) {
      statement <- paste0(statement, " person_source_value IS NULL")
    } else {
      statement <- paste0(statement, " person_source_value = '", person_source_value,"'")
    }
  }
  
  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_concept_id)) {
      statement <- paste0(statement, " gender_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " gender_concept_id = '", gender_concept_id,"'")
    }
  }
  
  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_source_value)) {
      statement <- paste0(statement, " gender_source_value IS NULL")
    } else {
      statement <- paste0(statement, " gender_source_value = '", gender_source_value,"'")
    }
  }
  
  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(year_of_birth)) {
      statement <- paste0(statement, " year_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " year_of_birth = '", year_of_birth,"'")
    }
  }
  
  if (!missing(month_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(month_of_birth)) {
      statement <- paste0(statement, " month_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " month_of_birth = '", month_of_birth,"'")
    }
  }
  
  if (!missing(day_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(day_of_birth)) {
      statement <- paste0(statement, " day_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " day_of_birth = '", day_of_birth,"'")
    }
  }
  
  if (!missing(race_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(race_concept_id)) {
      statement <- paste0(statement, " race_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " race_concept_id = '", race_concept_id,"'")
    }
  }
  
  if (!missing(race_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(race_source_value)) {
      statement <- paste0(statement, " race_source_value IS NULL")
    } else {
      statement <- paste0(statement, " race_source_value = '", race_source_value,"'")
    }
  }
  
  if (!missing(ethnicity_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(ethnicity_concept_id)) {
      statement <- paste0(statement, " ethnicity_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " ethnicity_concept_id = '", ethnicity_concept_id,"'")
    }
  }
  
  if (!missing(ethnicity_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(ethnicity_source_value)) {
      statement <- paste0(statement, " ethnicity_source_value IS NULL")
    } else {
      statement <- paste0(statement, " ethnicity_source_value = '", ethnicity_source_value,"'")
    }
  }
  
  if (!missing(time_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(time_of_birth)) {
      statement <- paste0(statement, " time_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " time_of_birth = '", time_of_birth,"'")
    }
  }
  
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(location_id)) {
      statement <- paste0(statement, " location_id IS NULL")
    } else {
      statement <- paste0(statement, " location_id = '", location_id,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_id)) {
      statement <- paste0(statement, " care_site_id IS NULL")
    } else {
      statement <- paste0(statement, " care_site_id = '", care_site_id,"'")
    }
  }
  
  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_source_concept_id)) {
      statement <- paste0(statement, " gender_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " gender_source_concept_id = '", gender_source_concept_id,"'")
    }
  }
  
  if (!missing(race_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(race_source_concept_id)) {
      statement <- paste0(statement, " race_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " race_source_concept_id = '", race_source_concept_id,"'")
    }
  }
  
  if (!missing(ethnicity_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(ethnicity_source_concept_id)) {
      statement <- paste0(statement, " ethnicity_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " ethnicity_source_concept_id = '", ethnicity_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_visit_occurrence <- function(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_time, visit_end_date, visit_end_time, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE")
  first <- TRUE
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(visit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_concept_id)) {
      statement <- paste0(statement, " visit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_concept_id = '", visit_concept_id,"'")
    }
  }
  
  if (!missing(visit_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_start_date)) {
      statement <- paste0(statement, " visit_start_date IS NULL")
    } else {
      statement <- paste0(statement, " visit_start_date = '", visit_start_date,"'")
    }
  }
  
  if (!missing(visit_start_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_start_time)) {
      statement <- paste0(statement, " visit_start_time IS NULL")
    } else {
      statement <- paste0(statement, " visit_start_time = '", visit_start_time,"'")
    }
  }
  
  if (!missing(visit_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_end_date)) {
      statement <- paste0(statement, " visit_end_date IS NULL")
    } else {
      statement <- paste0(statement, " visit_end_date = '", visit_end_date,"'")
    }
  }
  
  if (!missing(visit_end_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_end_time)) {
      statement <- paste0(statement, " visit_end_time IS NULL")
    } else {
      statement <- paste0(statement, " visit_end_time = '", visit_end_time,"'")
    }
  }
  
  if (!missing(visit_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_type_concept_id)) {
      statement <- paste0(statement, " visit_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_type_concept_id = '", visit_type_concept_id,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_id)) {
      statement <- paste0(statement, " care_site_id IS NULL")
    } else {
      statement <- paste0(statement, " care_site_id = '", care_site_id,"'")
    }
  }
  
  if (!missing(visit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_source_value)) {
      statement <- paste0(statement, " visit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " visit_source_value = '", visit_source_value,"'")
    }
  }
  
  if (!missing(visit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_source_concept_id)) {
      statement <- paste0(statement, " visit_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_source_concept_id = '", visit_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_observation_period <- function(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE")
  first <- TRUE
  if (!missing(observation_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_period_id)) {
      statement <- paste0(statement, " observation_period_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_period_id = '", observation_period_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(observation_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_period_start_date)) {
      statement <- paste0(statement, " observation_period_start_date IS NULL")
    } else {
      statement <- paste0(statement, " observation_period_start_date = '", observation_period_start_date,"'")
    }
  }
  
  if (!missing(observation_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_period_end_date)) {
      statement <- paste0(statement, " observation_period_end_date IS NULL")
    } else {
      statement <- paste0(statement, " observation_period_end_date = '", observation_period_end_date,"'")
    }
  }
  
  if (!missing(period_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(period_type_concept_id)) {
      statement <- paste0(statement, " period_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " period_type_concept_id = '", period_type_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_location <- function(location_id, address_1, address_2, city, state, zip, county, location_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect location' AS test, CASE WHEN(SELECT COUNT(*) FROM location WHERE")
  first <- TRUE
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(location_id)) {
      statement <- paste0(statement, " location_id IS NULL")
    } else {
      statement <- paste0(statement, " location_id = '", location_id,"'")
    }
  }
  
  if (!missing(address_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(address_1)) {
      statement <- paste0(statement, " address_1 IS NULL")
    } else {
      statement <- paste0(statement, " address_1 = '", address_1,"'")
    }
  }
  
  if (!missing(address_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(address_2)) {
      statement <- paste0(statement, " address_2 IS NULL")
    } else {
      statement <- paste0(statement, " address_2 = '", address_2,"'")
    }
  }
  
  if (!missing(city)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(city)) {
      statement <- paste0(statement, " city IS NULL")
    } else {
      statement <- paste0(statement, " city = '", city,"'")
    }
  }
  
  if (!missing(state)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(state)) {
      statement <- paste0(statement, " state IS NULL")
    } else {
      statement <- paste0(statement, " state = '", state,"'")
    }
  }
  
  if (!missing(zip)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(zip)) {
      statement <- paste0(statement, " zip IS NULL")
    } else {
      statement <- paste0(statement, " zip = '", zip,"'")
    }
  }
  
  if (!missing(county)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(county)) {
      statement <- paste0(statement, " county IS NULL")
    } else {
      statement <- paste0(statement, " county = '", county,"'")
    }
  }
  
  if (!missing(location_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(location_source_value)) {
      statement <- paste0(statement, " location_source_value IS NULL")
    } else {
      statement <- paste0(statement, " location_source_value = '", location_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_care_site <- function(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect care_site' AS test, CASE WHEN(SELECT COUNT(*) FROM care_site WHERE")
  first <- TRUE
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_id)) {
      statement <- paste0(statement, " care_site_id IS NULL")
    } else {
      statement <- paste0(statement, " care_site_id = '", care_site_id,"'")
    }
  }
  
  if (!missing(care_site_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_name)) {
      statement <- paste0(statement, " care_site_name IS NULL")
    } else {
      statement <- paste0(statement, " care_site_name = '", care_site_name,"'")
    }
  }
  
  if (!missing(place_of_service_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(place_of_service_concept_id)) {
      statement <- paste0(statement, " place_of_service_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " place_of_service_concept_id = '", place_of_service_concept_id,"'")
    }
  }
  
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(location_id)) {
      statement <- paste0(statement, " location_id IS NULL")
    } else {
      statement <- paste0(statement, " location_id = '", location_id,"'")
    }
  }
  
  if (!missing(care_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_source_value)) {
      statement <- paste0(statement, " care_site_source_value IS NULL")
    } else {
      statement <- paste0(statement, " care_site_source_value = '", care_site_source_value,"'")
    }
  }
  
  if (!missing(place_of_service_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(place_of_service_source_value)) {
      statement <- paste0(statement, " place_of_service_source_value IS NULL")
    } else {
      statement <- paste0(statement, " place_of_service_source_value = '", place_of_service_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_condition_occurrence <- function(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_end_date, condition_type_concept_id, stop_reason, provider_id, visit_occurrence_id, condition_source_value, condition_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE")
  first <- TRUE
  if (!missing(condition_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_occurrence_id)) {
      statement <- paste0(statement, " condition_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_occurrence_id = '", condition_occurrence_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_concept_id)) {
      statement <- paste0(statement, " condition_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_concept_id = '", condition_concept_id,"'")
    }
  }
  
  if (!missing(condition_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_start_date)) {
      statement <- paste0(statement, " condition_start_date IS NULL")
    } else {
      statement <- paste0(statement, " condition_start_date = '", condition_start_date,"'")
    }
  }
  
  if (!missing(condition_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_end_date)) {
      statement <- paste0(statement, " condition_end_date IS NULL")
    } else {
      statement <- paste0(statement, " condition_end_date = '", condition_end_date,"'")
    }
  }
  
  if (!missing(condition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_type_concept_id)) {
      statement <- paste0(statement, " condition_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_type_concept_id = '", condition_type_concept_id,"'")
    }
  }
  
  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(stop_reason)) {
      statement <- paste0(statement, " stop_reason IS NULL")
    } else {
      statement <- paste0(statement, " stop_reason = '", stop_reason,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(condition_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_source_value)) {
      statement <- paste0(statement, " condition_source_value IS NULL")
    } else {
      statement <- paste0(statement, " condition_source_value = '", condition_source_value,"'")
    }
  }
  
  if (!missing(condition_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_source_concept_id)) {
      statement <- paste0(statement, " condition_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_source_concept_id = '", condition_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_death <- function(person_id, death_date, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect death' AS test, CASE WHEN(SELECT COUNT(*) FROM death WHERE")
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(death_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(death_date)) {
      statement <- paste0(statement, " death_date IS NULL")
    } else {
      statement <- paste0(statement, " death_date = '", death_date,"'")
    }
  }
  
  if (!missing(death_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(death_type_concept_id)) {
      statement <- paste0(statement, " death_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " death_type_concept_id = '", death_type_concept_id,"'")
    }
  }
  
  if (!missing(cause_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cause_concept_id)) {
      statement <- paste0(statement, " cause_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " cause_concept_id = '", cause_concept_id,"'")
    }
  }
  
  if (!missing(cause_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cause_source_value)) {
      statement <- paste0(statement, " cause_source_value IS NULL")
    } else {
      statement <- paste0(statement, " cause_source_value = '", cause_source_value,"'")
    }
  }
  
  if (!missing(cause_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cause_source_concept_id)) {
      statement <- paste0(statement, " cause_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " cause_source_concept_id = '", cause_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_drug_exposure <- function(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, effective_drug_dose, dose_unit_concept_id, lot_number, provider_id, visit_occurrence_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect drug_exposure' AS test, CASE WHEN(SELECT COUNT(*) FROM drug_exposure WHERE")
  first <- TRUE
  if (!missing(drug_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_id)) {
      statement <- paste0(statement, " drug_exposure_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_id = '", drug_exposure_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_concept_id)) {
      statement <- paste0(statement, " drug_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_concept_id = '", drug_concept_id,"'")
    }
  }
  
  if (!missing(drug_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_start_date)) {
      statement <- paste0(statement, " drug_exposure_start_date IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_start_date = '", drug_exposure_start_date,"'")
    }
  }
  
  if (!missing(drug_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_end_date)) {
      statement <- paste0(statement, " drug_exposure_end_date IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_end_date = '", drug_exposure_end_date,"'")
    }
  }
  
  if (!missing(drug_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_type_concept_id)) {
      statement <- paste0(statement, " drug_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_type_concept_id = '", drug_type_concept_id,"'")
    }
  }
  
  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(stop_reason)) {
      statement <- paste0(statement, " stop_reason IS NULL")
    } else {
      statement <- paste0(statement, " stop_reason = '", stop_reason,"'")
    }
  }
  
  if (!missing(refills)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(refills)) {
      statement <- paste0(statement, " refills IS NULL")
    } else {
      statement <- paste0(statement, " refills = '", refills,"'")
    }
  }
  
  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(quantity)) {
      statement <- paste0(statement, " quantity IS NULL")
    } else {
      statement <- paste0(statement, " quantity = '", quantity,"'")
    }
  }
  
  if (!missing(days_supply)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(days_supply)) {
      statement <- paste0(statement, " days_supply IS NULL")
    } else {
      statement <- paste0(statement, " days_supply = '", days_supply,"'")
    }
  }
  
  if (!missing(sig)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(sig)) {
      statement <- paste0(statement, " sig IS NULL")
    } else {
      statement <- paste0(statement, " sig = '", sig,"'")
    }
  }
  
  if (!missing(route_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(route_concept_id)) {
      statement <- paste0(statement, " route_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " route_concept_id = '", route_concept_id,"'")
    }
  }
  
  if (!missing(effective_drug_dose)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(effective_drug_dose)) {
      statement <- paste0(statement, " effective_drug_dose IS NULL")
    } else {
      statement <- paste0(statement, " effective_drug_dose = '", effective_drug_dose,"'")
    }
  }
  
  if (!missing(dose_unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_unit_concept_id)) {
      statement <- paste0(statement, " dose_unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " dose_unit_concept_id = '", dose_unit_concept_id,"'")
    }
  }
  
  if (!missing(lot_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(lot_number)) {
      statement <- paste0(statement, " lot_number IS NULL")
    } else {
      statement <- paste0(statement, " lot_number = '", lot_number,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(drug_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_source_value)) {
      statement <- paste0(statement, " drug_source_value IS NULL")
    } else {
      statement <- paste0(statement, " drug_source_value = '", drug_source_value,"'")
    }
  }
  
  if (!missing(drug_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_source_concept_id)) {
      statement <- paste0(statement, " drug_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_source_concept_id = '", drug_source_concept_id,"'")
    }
  }
  
  if (!missing(route_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(route_source_value)) {
      statement <- paste0(statement, " route_source_value IS NULL")
    } else {
      statement <- paste0(statement, " route_source_value = '", route_source_value,"'")
    }
  }
  
  if (!missing(dose_unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_unit_source_value)) {
      statement <- paste0(statement, " dose_unit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " dose_unit_source_value = '", dose_unit_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_device_exposure <- function(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_end_date, device_type_concept_id, unique_device_id, quantity, provider_id, visit_occurrence_id, device_source_value, device_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect device_exposure' AS test, CASE WHEN(SELECT COUNT(*) FROM device_exposure WHERE")
  first <- TRUE
  if (!missing(device_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_exposure_id)) {
      statement <- paste0(statement, " device_exposure_id IS NULL")
    } else {
      statement <- paste0(statement, " device_exposure_id = '", device_exposure_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(device_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_concept_id)) {
      statement <- paste0(statement, " device_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " device_concept_id = '", device_concept_id,"'")
    }
  }
  
  if (!missing(device_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_exposure_start_date)) {
      statement <- paste0(statement, " device_exposure_start_date IS NULL")
    } else {
      statement <- paste0(statement, " device_exposure_start_date = '", device_exposure_start_date,"'")
    }
  }
  
  if (!missing(device_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_exposure_end_date)) {
      statement <- paste0(statement, " device_exposure_end_date IS NULL")
    } else {
      statement <- paste0(statement, " device_exposure_end_date = '", device_exposure_end_date,"'")
    }
  }
  
  if (!missing(device_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_type_concept_id)) {
      statement <- paste0(statement, " device_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " device_type_concept_id = '", device_type_concept_id,"'")
    }
  }
  
  if (!missing(unique_device_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unique_device_id)) {
      statement <- paste0(statement, " unique_device_id IS NULL")
    } else {
      statement <- paste0(statement, " unique_device_id = '", unique_device_id,"'")
    }
  }
  
  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(quantity)) {
      statement <- paste0(statement, " quantity IS NULL")
    } else {
      statement <- paste0(statement, " quantity = '", quantity,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(device_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_source_value)) {
      statement <- paste0(statement, " device_source_value IS NULL")
    } else {
      statement <- paste0(statement, " device_source_value = '", device_source_value,"'")
    }
  }
  
  if (!missing(device_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_source_concept_id)) {
      statement <- paste0(statement, " device_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " device_source_concept_id = '", device_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_procedure_occurrence <- function(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, procedure_source_value, procedure_source_concept_id, qualifier_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE")
  first <- TRUE
  if (!missing(procedure_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_occurrence_id)) {
      statement <- paste0(statement, " procedure_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_occurrence_id = '", procedure_occurrence_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(procedure_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_concept_id)) {
      statement <- paste0(statement, " procedure_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_concept_id = '", procedure_concept_id,"'")
    }
  }
  
  if (!missing(procedure_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_date)) {
      statement <- paste0(statement, " procedure_date IS NULL")
    } else {
      statement <- paste0(statement, " procedure_date = '", procedure_date,"'")
    }
  }
  
  if (!missing(procedure_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_type_concept_id)) {
      statement <- paste0(statement, " procedure_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_type_concept_id = '", procedure_type_concept_id,"'")
    }
  }
  
  if (!missing(modifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(modifier_concept_id)) {
      statement <- paste0(statement, " modifier_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " modifier_concept_id = '", modifier_concept_id,"'")
    }
  }
  
  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(quantity)) {
      statement <- paste0(statement, " quantity IS NULL")
    } else {
      statement <- paste0(statement, " quantity = '", quantity,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(procedure_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_source_value)) {
      statement <- paste0(statement, " procedure_source_value IS NULL")
    } else {
      statement <- paste0(statement, " procedure_source_value = '", procedure_source_value,"'")
    }
  }
  
  if (!missing(procedure_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_source_concept_id)) {
      statement <- paste0(statement, " procedure_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_source_concept_id = '", procedure_source_concept_id,"'")
    }
  }
  
  if (!missing(qualifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(qualifier_source_value)) {
      statement <- paste0(statement, " qualifier_source_value IS NULL")
    } else {
      statement <- paste0(statement, " qualifier_source_value = '", qualifier_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_measurement <- function(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect measurement' AS test, CASE WHEN(SELECT COUNT(*) FROM measurement WHERE")
  first <- TRUE
  if (!missing(measurement_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_id)) {
      statement <- paste0(statement, " measurement_id IS NULL")
    } else {
      statement <- paste0(statement, " measurement_id = '", measurement_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(measurement_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_concept_id)) {
      statement <- paste0(statement, " measurement_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " measurement_concept_id = '", measurement_concept_id,"'")
    }
  }
  
  if (!missing(measurement_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_date)) {
      statement <- paste0(statement, " measurement_date IS NULL")
    } else {
      statement <- paste0(statement, " measurement_date = '", measurement_date,"'")
    }
  }
  
  if (!missing(measurement_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_time)) {
      statement <- paste0(statement, " measurement_time IS NULL")
    } else {
      statement <- paste0(statement, " measurement_time = '", measurement_time,"'")
    }
  }
  
  if (!missing(measurement_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_type_concept_id)) {
      statement <- paste0(statement, " measurement_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " measurement_type_concept_id = '", measurement_type_concept_id,"'")
    }
  }
  
  if (!missing(operator_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(operator_concept_id)) {
      statement <- paste0(statement, " operator_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " operator_concept_id = '", operator_concept_id,"'")
    }
  }
  
  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_number)) {
      statement <- paste0(statement, " value_as_number IS NULL")
    } else {
      statement <- paste0(statement, " value_as_number = '", value_as_number,"'")
    }
  }
  
  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_concept_id)) {
      statement <- paste0(statement, " value_as_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " value_as_concept_id = '", value_as_concept_id,"'")
    }
  }
  
  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_concept_id)) {
      statement <- paste0(statement, " unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " unit_concept_id = '", unit_concept_id,"'")
    }
  }
  
  if (!missing(range_low)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(range_low)) {
      statement <- paste0(statement, " range_low IS NULL")
    } else {
      statement <- paste0(statement, " range_low = '", range_low,"'")
    }
  }
  
  if (!missing(range_high)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(range_high)) {
      statement <- paste0(statement, " range_high IS NULL")
    } else {
      statement <- paste0(statement, " range_high = '", range_high,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(measurement_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_source_value)) {
      statement <- paste0(statement, " measurement_source_value IS NULL")
    } else {
      statement <- paste0(statement, " measurement_source_value = '", measurement_source_value,"'")
    }
  }
  
  if (!missing(measurement_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(measurement_source_concept_id)) {
      statement <- paste0(statement, " measurement_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " measurement_source_concept_id = '", measurement_source_concept_id,"'")
    }
  }
  
  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_source_value)) {
      statement <- paste0(statement, " unit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " unit_source_value = '", unit_source_value,"'")
    }
  }
  
  if (!missing(value_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_source_value)) {
      statement <- paste0(statement, " value_source_value IS NULL")
    } else {
      statement <- paste0(statement, " value_source_value = '", value_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_observation <- function(observation_id, person_id, observation_concept_id, observation_date, observation_time, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect observation' AS test, CASE WHEN(SELECT COUNT(*) FROM observation WHERE")
  first <- TRUE
  if (!missing(observation_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_id)) {
      statement <- paste0(statement, " observation_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_id = '", observation_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(observation_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_concept_id)) {
      statement <- paste0(statement, " observation_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_concept_id = '", observation_concept_id,"'")
    }
  }
  
  if (!missing(observation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_date)) {
      statement <- paste0(statement, " observation_date IS NULL")
    } else {
      statement <- paste0(statement, " observation_date = '", observation_date,"'")
    }
  }
  
  if (!missing(observation_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_time)) {
      statement <- paste0(statement, " observation_time IS NULL")
    } else {
      statement <- paste0(statement, " observation_time = '", observation_time,"'")
    }
  }
  
  if (!missing(observation_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_type_concept_id)) {
      statement <- paste0(statement, " observation_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_type_concept_id = '", observation_type_concept_id,"'")
    }
  }
  
  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_number)) {
      statement <- paste0(statement, " value_as_number IS NULL")
    } else {
      statement <- paste0(statement, " value_as_number = '", value_as_number,"'")
    }
  }
  
  if (!missing(value_as_string)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_string)) {
      statement <- paste0(statement, " value_as_string IS NULL")
    } else {
      statement <- paste0(statement, " value_as_string = '", value_as_string,"'")
    }
  }
  
  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_concept_id)) {
      statement <- paste0(statement, " value_as_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " value_as_concept_id = '", value_as_concept_id,"'")
    }
  }
  
  if (!missing(qualifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(qualifier_concept_id)) {
      statement <- paste0(statement, " qualifier_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " qualifier_concept_id = '", qualifier_concept_id,"'")
    }
  }
  
  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_concept_id)) {
      statement <- paste0(statement, " unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " unit_concept_id = '", unit_concept_id,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(observation_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_source_value)) {
      statement <- paste0(statement, " observation_source_value IS NULL")
    } else {
      statement <- paste0(statement, " observation_source_value = '", observation_source_value,"'")
    }
  }
  
  if (!missing(observation_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(observation_source_concept_id)) {
      statement <- paste0(statement, " observation_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " observation_source_concept_id = '", observation_source_concept_id,"'")
    }
  }
  
  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_source_value)) {
      statement <- paste0(statement, " unit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " unit_source_value = '", unit_source_value,"'")
    }
  }
  
  if (!missing(qualifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(qualifier_source_value)) {
      statement <- paste0(statement, " qualifier_source_value IS NULL")
    } else {
      statement <- paste0(statement, " qualifier_source_value = '", qualifier_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_provider <- function(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect provider' AS test, CASE WHEN(SELECT COUNT(*) FROM provider WHERE")
  first <- TRUE
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(provider_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_name)) {
      statement <- paste0(statement, " provider_name IS NULL")
    } else {
      statement <- paste0(statement, " provider_name = '", provider_name,"'")
    }
  }
  
  if (!missing(npi)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(npi)) {
      statement <- paste0(statement, " npi IS NULL")
    } else {
      statement <- paste0(statement, " npi = '", npi,"'")
    }
  }
  
  if (!missing(dea)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dea)) {
      statement <- paste0(statement, " dea IS NULL")
    } else {
      statement <- paste0(statement, " dea = '", dea,"'")
    }
  }
  
  if (!missing(specialty_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specialty_concept_id)) {
      statement <- paste0(statement, " specialty_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " specialty_concept_id = '", specialty_concept_id,"'")
    }
  }
  
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(care_site_id)) {
      statement <- paste0(statement, " care_site_id IS NULL")
    } else {
      statement <- paste0(statement, " care_site_id = '", care_site_id,"'")
    }
  }
  
  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(year_of_birth)) {
      statement <- paste0(statement, " year_of_birth IS NULL")
    } else {
      statement <- paste0(statement, " year_of_birth = '", year_of_birth,"'")
    }
  }
  
  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_concept_id)) {
      statement <- paste0(statement, " gender_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " gender_concept_id = '", gender_concept_id,"'")
    }
  }
  
  if (!missing(provider_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_source_value)) {
      statement <- paste0(statement, " provider_source_value IS NULL")
    } else {
      statement <- paste0(statement, " provider_source_value = '", provider_source_value,"'")
    }
  }
  
  if (!missing(specialty_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specialty_source_value)) {
      statement <- paste0(statement, " specialty_source_value IS NULL")
    } else {
      statement <- paste0(statement, " specialty_source_value = '", specialty_source_value,"'")
    }
  }
  
  if (!missing(specialty_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specialty_source_concept_id)) {
      statement <- paste0(statement, " specialty_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " specialty_source_concept_id = '", specialty_source_concept_id,"'")
    }
  }
  
  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_source_value)) {
      statement <- paste0(statement, " gender_source_value IS NULL")
    } else {
      statement <- paste0(statement, " gender_source_value = '", gender_source_value,"'")
    }
  }
  
  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gender_source_concept_id)) {
      statement <- paste0(statement, " gender_source_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " gender_source_concept_id = '", gender_source_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_note <- function(note_id, person_id, note_date, note_time, note_type_concept_id, note_text, provider_id, visit_occurrence_id, note_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect note' AS test, CASE WHEN(SELECT COUNT(*) FROM note WHERE")
  first <- TRUE
  if (!missing(note_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_id)) {
      statement <- paste0(statement, " note_id IS NULL")
    } else {
      statement <- paste0(statement, " note_id = '", note_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(note_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_date)) {
      statement <- paste0(statement, " note_date IS NULL")
    } else {
      statement <- paste0(statement, " note_date = '", note_date,"'")
    }
  }
  
  if (!missing(note_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_time)) {
      statement <- paste0(statement, " note_time IS NULL")
    } else {
      statement <- paste0(statement, " note_time = '", note_time,"'")
    }
  }
  
  if (!missing(note_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_type_concept_id)) {
      statement <- paste0(statement, " note_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " note_type_concept_id = '", note_type_concept_id,"'")
    }
  }
  
  if (!missing(note_text)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_text)) {
      statement <- paste0(statement, " note_text IS NULL")
    } else {
      statement <- paste0(statement, " note_text = '", note_text,"'")
    }
  }
  
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(provider_id)) {
      statement <- paste0(statement, " provider_id IS NULL")
    } else {
      statement <- paste0(statement, " provider_id = '", provider_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(note_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(note_source_value)) {
      statement <- paste0(statement, " note_source_value IS NULL")
    } else {
      statement <- paste0(statement, " note_source_value = '", note_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_specimen <- function(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_time, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect specimen' AS test, CASE WHEN(SELECT COUNT(*) FROM specimen WHERE")
  first <- TRUE
  if (!missing(specimen_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_id)) {
      statement <- paste0(statement, " specimen_id IS NULL")
    } else {
      statement <- paste0(statement, " specimen_id = '", specimen_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(specimen_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_concept_id)) {
      statement <- paste0(statement, " specimen_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " specimen_concept_id = '", specimen_concept_id,"'")
    }
  }
  
  if (!missing(specimen_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_type_concept_id)) {
      statement <- paste0(statement, " specimen_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " specimen_type_concept_id = '", specimen_type_concept_id,"'")
    }
  }
  
  if (!missing(specimen_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_date)) {
      statement <- paste0(statement, " specimen_date IS NULL")
    } else {
      statement <- paste0(statement, " specimen_date = '", specimen_date,"'")
    }
  }
  
  if (!missing(specimen_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_time)) {
      statement <- paste0(statement, " specimen_time IS NULL")
    } else {
      statement <- paste0(statement, " specimen_time = '", specimen_time,"'")
    }
  }
  
  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(quantity)) {
      statement <- paste0(statement, " quantity IS NULL")
    } else {
      statement <- paste0(statement, " quantity = '", quantity,"'")
    }
  }
  
  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_concept_id)) {
      statement <- paste0(statement, " unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " unit_concept_id = '", unit_concept_id,"'")
    }
  }
  
  if (!missing(anatomic_site_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(anatomic_site_concept_id)) {
      statement <- paste0(statement, " anatomic_site_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " anatomic_site_concept_id = '", anatomic_site_concept_id,"'")
    }
  }
  
  if (!missing(disease_status_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(disease_status_concept_id)) {
      statement <- paste0(statement, " disease_status_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " disease_status_concept_id = '", disease_status_concept_id,"'")
    }
  }
  
  if (!missing(specimen_source_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_source_id)) {
      statement <- paste0(statement, " specimen_source_id IS NULL")
    } else {
      statement <- paste0(statement, " specimen_source_id = '", specimen_source_id,"'")
    }
  }
  
  if (!missing(specimen_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(specimen_source_value)) {
      statement <- paste0(statement, " specimen_source_value IS NULL")
    } else {
      statement <- paste0(statement, " specimen_source_value = '", specimen_source_value,"'")
    }
  }
  
  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_source_value)) {
      statement <- paste0(statement, " unit_source_value IS NULL")
    } else {
      statement <- paste0(statement, " unit_source_value = '", unit_source_value,"'")
    }
  }
  
  if (!missing(anatomic_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(anatomic_site_source_value)) {
      statement <- paste0(statement, " anatomic_site_source_value IS NULL")
    } else {
      statement <- paste0(statement, " anatomic_site_source_value = '", anatomic_site_source_value,"'")
    }
  }
  
  if (!missing(disease_status_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(disease_status_source_value)) {
      statement <- paste0(statement, " disease_status_source_value IS NULL")
    } else {
      statement <- paste0(statement, " disease_status_source_value = '", disease_status_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_fact_relationship <- function(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect fact_relationship' AS test, CASE WHEN(SELECT COUNT(*) FROM fact_relationship WHERE")
  first <- TRUE
  if (!missing(domain_concept_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(domain_concept_id_1)) {
      statement <- paste0(statement, " domain_concept_id_1 IS NULL")
    } else {
      statement <- paste0(statement, " domain_concept_id_1 = '", domain_concept_id_1,"'")
    }
  }
  
  if (!missing(fact_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(fact_id_1)) {
      statement <- paste0(statement, " fact_id_1 IS NULL")
    } else {
      statement <- paste0(statement, " fact_id_1 = '", fact_id_1,"'")
    }
  }
  
  if (!missing(domain_concept_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(domain_concept_id_2)) {
      statement <- paste0(statement, " domain_concept_id_2 IS NULL")
    } else {
      statement <- paste0(statement, " domain_concept_id_2 = '", domain_concept_id_2,"'")
    }
  }
  
  if (!missing(fact_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(fact_id_2)) {
      statement <- paste0(statement, " fact_id_2 IS NULL")
    } else {
      statement <- paste0(statement, " fact_id_2 = '", fact_id_2,"'")
    }
  }
  
  if (!missing(relationship_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(relationship_concept_id)) {
      statement <- paste0(statement, " relationship_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " relationship_concept_id = '", relationship_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_procedure_cost <- function(procedure_cost_id, procedure_occurrence_id, currency_concept_id, paid_copay, paid_coinsurance, paid_toward_deductible, paid_by_payer, paid_by_coordination_benefits, total_out_of_pocket, total_paid, revenue_code_concept_id, payer_plan_period_id, revenue_code_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect procedure_cost' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_cost WHERE")
  first <- TRUE
  if (!missing(procedure_cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_cost_id)) {
      statement <- paste0(statement, " procedure_cost_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_cost_id = '", procedure_cost_id,"'")
    }
  }
  
  if (!missing(procedure_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(procedure_occurrence_id)) {
      statement <- paste0(statement, " procedure_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " procedure_occurrence_id = '", procedure_occurrence_id,"'")
    }
  }
  
  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(currency_concept_id)) {
      statement <- paste0(statement, " currency_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " currency_concept_id = '", currency_concept_id,"'")
    }
  }
  
  if (!missing(paid_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_copay)) {
      statement <- paste0(statement, " paid_copay IS NULL")
    } else {
      statement <- paste0(statement, " paid_copay = '", paid_copay,"'")
    }
  }
  
  if (!missing(paid_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_coinsurance)) {
      statement <- paste0(statement, " paid_coinsurance IS NULL")
    } else {
      statement <- paste0(statement, " paid_coinsurance = '", paid_coinsurance,"'")
    }
  }
  
  if (!missing(paid_toward_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_toward_deductible)) {
      statement <- paste0(statement, " paid_toward_deductible IS NULL")
    } else {
      statement <- paste0(statement, " paid_toward_deductible = '", paid_toward_deductible,"'")
    }
  }
  
  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_payer)) {
      statement <- paste0(statement, " paid_by_payer IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_payer = '", paid_by_payer,"'")
    }
  }
  
  if (!missing(paid_by_coordination_benefits)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_coordination_benefits)) {
      statement <- paste0(statement, " paid_by_coordination_benefits IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_coordination_benefits = '", paid_by_coordination_benefits,"'")
    }
  }
  
  if (!missing(total_out_of_pocket)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_out_of_pocket)) {
      statement <- paste0(statement, " total_out_of_pocket IS NULL")
    } else {
      statement <- paste0(statement, " total_out_of_pocket = '", total_out_of_pocket,"'")
    }
  }
  
  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_paid)) {
      statement <- paste0(statement, " total_paid IS NULL")
    } else {
      statement <- paste0(statement, " total_paid = '", total_paid,"'")
    }
  }
  
  if (!missing(revenue_code_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(revenue_code_concept_id)) {
      statement <- paste0(statement, " revenue_code_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " revenue_code_concept_id = '", revenue_code_concept_id,"'")
    }
  }
  
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  if (!missing(revenue_code_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(revenue_code_source_value)) {
      statement <- paste0(statement, " revenue_code_source_value IS NULL")
    } else {
      statement <- paste0(statement, " revenue_code_source_value = '", revenue_code_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_visit_cost <- function(visit_cost_id, visit_occurrence_id, currency_concept_id, paid_copay, paid_coinsurance, paid_toward_deductible, paid_by_payer, paid_by_coordination_benefits, total_out_of_pocket, total_paid, payer_plan_period_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect visit_cost' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_cost WHERE")
  first <- TRUE
  if (!missing(visit_cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_cost_id)) {
      statement <- paste0(statement, " visit_cost_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_cost_id = '", visit_cost_id,"'")
    }
  }
  
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(visit_occurrence_id)) {
      statement <- paste0(statement, " visit_occurrence_id IS NULL")
    } else {
      statement <- paste0(statement, " visit_occurrence_id = '", visit_occurrence_id,"'")
    }
  }
  
  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(currency_concept_id)) {
      statement <- paste0(statement, " currency_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " currency_concept_id = '", currency_concept_id,"'")
    }
  }
  
  if (!missing(paid_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_copay)) {
      statement <- paste0(statement, " paid_copay IS NULL")
    } else {
      statement <- paste0(statement, " paid_copay = '", paid_copay,"'")
    }
  }
  
  if (!missing(paid_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_coinsurance)) {
      statement <- paste0(statement, " paid_coinsurance IS NULL")
    } else {
      statement <- paste0(statement, " paid_coinsurance = '", paid_coinsurance,"'")
    }
  }
  
  if (!missing(paid_toward_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_toward_deductible)) {
      statement <- paste0(statement, " paid_toward_deductible IS NULL")
    } else {
      statement <- paste0(statement, " paid_toward_deductible = '", paid_toward_deductible,"'")
    }
  }
  
  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_payer)) {
      statement <- paste0(statement, " paid_by_payer IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_payer = '", paid_by_payer,"'")
    }
  }
  
  if (!missing(paid_by_coordination_benefits)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_coordination_benefits)) {
      statement <- paste0(statement, " paid_by_coordination_benefits IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_coordination_benefits = '", paid_by_coordination_benefits,"'")
    }
  }
  
  if (!missing(total_out_of_pocket)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_out_of_pocket)) {
      statement <- paste0(statement, " total_out_of_pocket IS NULL")
    } else {
      statement <- paste0(statement, " total_out_of_pocket = '", total_out_of_pocket,"'")
    }
  }
  
  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_paid)) {
      statement <- paste0(statement, " total_paid IS NULL")
    } else {
      statement <- paste0(statement, " total_paid = '", total_paid,"'")
    }
  }
  
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_drug_cost <- function(drug_cost_id, drug_exposure_id, currency_concept_id, paid_copay, paid_coinsurance, paid_toward_deductible, paid_by_payer, paid_by_coordination_benefits, total_out_of_pocket, total_paid, ingredient_cost, dispensing_fee, average_wholesale_price, payer_plan_period_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect drug_cost' AS test, CASE WHEN(SELECT COUNT(*) FROM drug_cost WHERE")
  first <- TRUE
  if (!missing(drug_cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_cost_id)) {
      statement <- paste0(statement, " drug_cost_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_cost_id = '", drug_cost_id,"'")
    }
  }
  
  if (!missing(drug_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_id)) {
      statement <- paste0(statement, " drug_exposure_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_id = '", drug_exposure_id,"'")
    }
  }
  
  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(currency_concept_id)) {
      statement <- paste0(statement, " currency_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " currency_concept_id = '", currency_concept_id,"'")
    }
  }
  
  if (!missing(paid_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_copay)) {
      statement <- paste0(statement, " paid_copay IS NULL")
    } else {
      statement <- paste0(statement, " paid_copay = '", paid_copay,"'")
    }
  }
  
  if (!missing(paid_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_coinsurance)) {
      statement <- paste0(statement, " paid_coinsurance IS NULL")
    } else {
      statement <- paste0(statement, " paid_coinsurance = '", paid_coinsurance,"'")
    }
  }
  
  if (!missing(paid_toward_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_toward_deductible)) {
      statement <- paste0(statement, " paid_toward_deductible IS NULL")
    } else {
      statement <- paste0(statement, " paid_toward_deductible = '", paid_toward_deductible,"'")
    }
  }
  
  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_payer)) {
      statement <- paste0(statement, " paid_by_payer IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_payer = '", paid_by_payer,"'")
    }
  }
  
  if (!missing(paid_by_coordination_benefits)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_coordination_benefits)) {
      statement <- paste0(statement, " paid_by_coordination_benefits IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_coordination_benefits = '", paid_by_coordination_benefits,"'")
    }
  }
  
  if (!missing(total_out_of_pocket)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_out_of_pocket)) {
      statement <- paste0(statement, " total_out_of_pocket IS NULL")
    } else {
      statement <- paste0(statement, " total_out_of_pocket = '", total_out_of_pocket,"'")
    }
  }
  
  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_paid)) {
      statement <- paste0(statement, " total_paid IS NULL")
    } else {
      statement <- paste0(statement, " total_paid = '", total_paid,"'")
    }
  }
  
  if (!missing(ingredient_cost)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(ingredient_cost)) {
      statement <- paste0(statement, " ingredient_cost IS NULL")
    } else {
      statement <- paste0(statement, " ingredient_cost = '", ingredient_cost,"'")
    }
  }
  
  if (!missing(dispensing_fee)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dispensing_fee)) {
      statement <- paste0(statement, " dispensing_fee IS NULL")
    } else {
      statement <- paste0(statement, " dispensing_fee = '", dispensing_fee,"'")
    }
  }
  
  if (!missing(average_wholesale_price)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(average_wholesale_price)) {
      statement <- paste0(statement, " average_wholesale_price IS NULL")
    } else {
      statement <- paste0(statement, " average_wholesale_price = '", average_wholesale_price,"'")
    }
  }
  
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_payer_plan_period <- function(payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_source_value, plan_source_value, family_source_value) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect payer_plan_period' AS test, CASE WHEN(SELECT COUNT(*) FROM payer_plan_period WHERE")
  first <- TRUE
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(payer_plan_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_start_date)) {
      statement <- paste0(statement, " payer_plan_period_start_date IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_start_date = '", payer_plan_period_start_date,"'")
    }
  }
  
  if (!missing(payer_plan_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_end_date)) {
      statement <- paste0(statement, " payer_plan_period_end_date IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_end_date = '", payer_plan_period_end_date,"'")
    }
  }
  
  if (!missing(payer_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_source_value)) {
      statement <- paste0(statement, " payer_source_value IS NULL")
    } else {
      statement <- paste0(statement, " payer_source_value = '", payer_source_value,"'")
    }
  }
  
  if (!missing(plan_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(plan_source_value)) {
      statement <- paste0(statement, " plan_source_value IS NULL")
    } else {
      statement <- paste0(statement, " plan_source_value = '", plan_source_value,"'")
    }
  }
  
  if (!missing(family_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(family_source_value)) {
      statement <- paste0(statement, " family_source_value IS NULL")
    } else {
      statement <- paste0(statement, " family_source_value = '", family_source_value,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_device_cost <- function(device_cost_id, device_exposure_id, currency_concept_id, paid_copay, paid_coinsurance, paid_toward_deductible, paid_by_payer, paid_by_coordination_benefits, total_out_of_pocket, total_paid, payer_plan_period_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect device_cost' AS test, CASE WHEN(SELECT COUNT(*) FROM device_cost WHERE")
  first <- TRUE
  if (!missing(device_cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_cost_id)) {
      statement <- paste0(statement, " device_cost_id IS NULL")
    } else {
      statement <- paste0(statement, " device_cost_id = '", device_cost_id,"'")
    }
  }
  
  if (!missing(device_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(device_exposure_id)) {
      statement <- paste0(statement, " device_exposure_id IS NULL")
    } else {
      statement <- paste0(statement, " device_exposure_id = '", device_exposure_id,"'")
    }
  }
  
  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(currency_concept_id)) {
      statement <- paste0(statement, " currency_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " currency_concept_id = '", currency_concept_id,"'")
    }
  }
  
  if (!missing(paid_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_copay)) {
      statement <- paste0(statement, " paid_copay IS NULL")
    } else {
      statement <- paste0(statement, " paid_copay = '", paid_copay,"'")
    }
  }
  
  if (!missing(paid_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_coinsurance)) {
      statement <- paste0(statement, " paid_coinsurance IS NULL")
    } else {
      statement <- paste0(statement, " paid_coinsurance = '", paid_coinsurance,"'")
    }
  }
  
  if (!missing(paid_toward_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_toward_deductible)) {
      statement <- paste0(statement, " paid_toward_deductible IS NULL")
    } else {
      statement <- paste0(statement, " paid_toward_deductible = '", paid_toward_deductible,"'")
    }
  }
  
  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_payer)) {
      statement <- paste0(statement, " paid_by_payer IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_payer = '", paid_by_payer,"'")
    }
  }
  
  if (!missing(paid_by_coordination_benefits)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(paid_by_coordination_benefits)) {
      statement <- paste0(statement, " paid_by_coordination_benefits IS NULL")
    } else {
      statement <- paste0(statement, " paid_by_coordination_benefits = '", paid_by_coordination_benefits,"'")
    }
  }
  
  if (!missing(total_out_of_pocket)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_out_of_pocket)) {
      statement <- paste0(statement, " total_out_of_pocket IS NULL")
    } else {
      statement <- paste0(statement, " total_out_of_pocket = '", total_out_of_pocket,"'")
    }
  }
  
  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(total_paid)) {
      statement <- paste0(statement, " total_paid IS NULL")
    } else {
      statement <- paste0(statement, " total_paid = '", total_paid,"'")
    }
  }
  
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(payer_plan_period_id)) {
      statement <- paste0(statement, " payer_plan_period_id IS NULL")
    } else {
      statement <- paste0(statement, " payer_plan_period_id = '", payer_plan_period_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_drug_era <- function(drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect drug_era' AS test, CASE WHEN(SELECT COUNT(*) FROM drug_era WHERE")
  first <- TRUE
  if (!missing(drug_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_era_id)) {
      statement <- paste0(statement, " drug_era_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_era_id = '", drug_era_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_concept_id)) {
      statement <- paste0(statement, " drug_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_concept_id = '", drug_concept_id,"'")
    }
  }
  
  if (!missing(drug_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_era_start_date)) {
      statement <- paste0(statement, " drug_era_start_date IS NULL")
    } else {
      statement <- paste0(statement, " drug_era_start_date = '", drug_era_start_date,"'")
    }
  }
  
  if (!missing(drug_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_era_end_date)) {
      statement <- paste0(statement, " drug_era_end_date IS NULL")
    } else {
      statement <- paste0(statement, " drug_era_end_date = '", drug_era_end_date,"'")
    }
  }
  
  if (!missing(drug_exposure_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_exposure_count)) {
      statement <- paste0(statement, " drug_exposure_count IS NULL")
    } else {
      statement <- paste0(statement, " drug_exposure_count = '", drug_exposure_count,"'")
    }
  }
  
  if (!missing(gap_days)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(gap_days)) {
      statement <- paste0(statement, " gap_days IS NULL")
    } else {
      statement <- paste0(statement, " gap_days = '", gap_days,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_dose_era <- function(dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect dose_era' AS test, CASE WHEN(SELECT COUNT(*) FROM dose_era WHERE")
  first <- TRUE
  if (!missing(dose_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_era_id)) {
      statement <- paste0(statement, " dose_era_id IS NULL")
    } else {
      statement <- paste0(statement, " dose_era_id = '", dose_era_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(drug_concept_id)) {
      statement <- paste0(statement, " drug_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " drug_concept_id = '", drug_concept_id,"'")
    }
  }
  
  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(unit_concept_id)) {
      statement <- paste0(statement, " unit_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " unit_concept_id = '", unit_concept_id,"'")
    }
  }
  
  if (!missing(dose_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_value)) {
      statement <- paste0(statement, " dose_value IS NULL")
    } else {
      statement <- paste0(statement, " dose_value = '", dose_value,"'")
    }
  }
  
  if (!missing(dose_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_era_start_date)) {
      statement <- paste0(statement, " dose_era_start_date IS NULL")
    } else {
      statement <- paste0(statement, " dose_era_start_date = '", dose_era_start_date,"'")
    }
  }
  
  if (!missing(dose_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(dose_era_end_date)) {
      statement <- paste0(statement, " dose_era_end_date IS NULL")
    } else {
      statement <- paste0(statement, " dose_era_end_date = '", dose_era_end_date,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_condition_era <- function(condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect condition_era' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_era WHERE")
  first <- TRUE
  if (!missing(condition_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_era_id)) {
      statement <- paste0(statement, " condition_era_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_era_id = '", condition_era_id,"'")
    }
  }
  
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(person_id)) {
      statement <- paste0(statement, " person_id IS NULL")
    } else {
      statement <- paste0(statement, " person_id = '", person_id,"'")
    }
  }
  
  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_concept_id)) {
      statement <- paste0(statement, " condition_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " condition_concept_id = '", condition_concept_id,"'")
    }
  }
  
  if (!missing(condition_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_era_start_date)) {
      statement <- paste0(statement, " condition_era_start_date IS NULL")
    } else {
      statement <- paste0(statement, " condition_era_start_date = '", condition_era_start_date,"'")
    }
  }
  
  if (!missing(condition_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_era_end_date)) {
      statement <- paste0(statement, " condition_era_end_date IS NULL")
    } else {
      statement <- paste0(statement, " condition_era_end_date = '", condition_era_end_date,"'")
    }
  }
  
  if (!missing(condition_occurrence_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(condition_occurrence_count)) {
      statement <- paste0(statement, " condition_occurrence_count IS NULL")
    } else {
      statement <- paste0(statement, " condition_occurrence_count = '", condition_occurrence_count,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_cdm_source <- function(cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, vocabulary_version) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect cdm_source' AS test, CASE WHEN(SELECT COUNT(*) FROM cdm_source WHERE")
  first <- TRUE
  if (!missing(cdm_source_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_source_name)) {
      statement <- paste0(statement, " cdm_source_name IS NULL")
    } else {
      statement <- paste0(statement, " cdm_source_name = '", cdm_source_name,"'")
    }
  }
  
  if (!missing(cdm_source_abbreviation)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_source_abbreviation)) {
      statement <- paste0(statement, " cdm_source_abbreviation IS NULL")
    } else {
      statement <- paste0(statement, " cdm_source_abbreviation = '", cdm_source_abbreviation,"'")
    }
  }
  
  if (!missing(cdm_holder)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_holder)) {
      statement <- paste0(statement, " cdm_holder IS NULL")
    } else {
      statement <- paste0(statement, " cdm_holder = '", cdm_holder,"'")
    }
  }
  
  if (!missing(source_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(source_description)) {
      statement <- paste0(statement, " source_description IS NULL")
    } else {
      statement <- paste0(statement, " source_description = '", source_description,"'")
    }
  }
  
  if (!missing(source_documentation_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(source_documentation_reference)) {
      statement <- paste0(statement, " source_documentation_reference IS NULL")
    } else {
      statement <- paste0(statement, " source_documentation_reference = '", source_documentation_reference,"'")
    }
  }
  
  if (!missing(cdm_etl_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_etl_reference)) {
      statement <- paste0(statement, " cdm_etl_reference IS NULL")
    } else {
      statement <- paste0(statement, " cdm_etl_reference = '", cdm_etl_reference,"'")
    }
  }
  
  if (!missing(source_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(source_release_date)) {
      statement <- paste0(statement, " source_release_date IS NULL")
    } else {
      statement <- paste0(statement, " source_release_date = '", source_release_date,"'")
    }
  }
  
  if (!missing(cdm_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_release_date)) {
      statement <- paste0(statement, " cdm_release_date IS NULL")
    } else {
      statement <- paste0(statement, " cdm_release_date = '", cdm_release_date,"'")
    }
  }
  
  if (!missing(cdm_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cdm_version)) {
      statement <- paste0(statement, " cdm_version IS NULL")
    } else {
      statement <- paste0(statement, " cdm_version = '", cdm_version,"'")
    }
  }
  
  if (!missing(vocabulary_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(vocabulary_version)) {
      statement <- paste0(statement, " vocabulary_version IS NULL")
    } else {
      statement <- paste0(statement, " vocabulary_version = '", vocabulary_version,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_cohort <- function(cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect cohort' AS test, CASE WHEN(SELECT COUNT(*) FROM cohort WHERE")
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_id)) {
      statement <- paste0(statement, " cohort_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_id = '", cohort_definition_id,"'")
    }
  }
  
  if (!missing(subject_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(subject_id)) {
      statement <- paste0(statement, " subject_id IS NULL")
    } else {
      statement <- paste0(statement, " subject_id = '", subject_id,"'")
    }
  }
  
  if (!missing(cohort_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_start_date)) {
      statement <- paste0(statement, " cohort_start_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_start_date = '", cohort_start_date,"'")
    }
  }
  
  if (!missing(cohort_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_end_date)) {
      statement <- paste0(statement, " cohort_end_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_end_date = '", cohort_end_date,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_cohort_definition <- function(cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_instantiation_date) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect cohort_definition' AS test, CASE WHEN(SELECT COUNT(*) FROM cohort_definition WHERE")
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_id)) {
      statement <- paste0(statement, " cohort_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_id = '", cohort_definition_id,"'")
    }
  }
  
  if (!missing(cohort_definition_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_name)) {
      statement <- paste0(statement, " cohort_definition_name IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_name = '", cohort_definition_name,"'")
    }
  }
  
  if (!missing(cohort_definition_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_description)) {
      statement <- paste0(statement, " cohort_definition_description IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_description = '", cohort_definition_description,"'")
    }
  }
  
  if (!missing(definition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(definition_type_concept_id)) {
      statement <- paste0(statement, " definition_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " definition_type_concept_id = '", definition_type_concept_id,"'")
    }
  }
  
  if (!missing(cohort_definition_syntax)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_syntax)) {
      statement <- paste0(statement, " cohort_definition_syntax IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_syntax = '", cohort_definition_syntax,"'")
    }
  }
  
  if (!missing(subject_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(subject_concept_id)) {
      statement <- paste0(statement, " subject_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " subject_concept_id = '", subject_concept_id,"'")
    }
  }
  
  if (!missing(cohort_instantiation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_instantiation_date)) {
      statement <- paste0(statement, " cohort_instantiation_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_instantiation_date = '", cohort_instantiation_date,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_cohort_attribute <- function(cohort_definition_id, cohort_start_date, cohort_end_date, subject_id, attribute_definition_id, value_as_number, value_as_concept_id) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect cohort_attribute' AS test, CASE WHEN(SELECT COUNT(*) FROM cohort_attribute WHERE")
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_definition_id)) {
      statement <- paste0(statement, " cohort_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " cohort_definition_id = '", cohort_definition_id,"'")
    }
  }
  
  if (!missing(cohort_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_start_date)) {
      statement <- paste0(statement, " cohort_start_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_start_date = '", cohort_start_date,"'")
    }
  }
  
  if (!missing(cohort_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(cohort_end_date)) {
      statement <- paste0(statement, " cohort_end_date IS NULL")
    } else {
      statement <- paste0(statement, " cohort_end_date = '", cohort_end_date,"'")
    }
  }
  
  if (!missing(subject_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(subject_id)) {
      statement <- paste0(statement, " subject_id IS NULL")
    } else {
      statement <- paste0(statement, " subject_id = '", subject_id,"'")
    }
  }
  
  if (!missing(attribute_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_definition_id)) {
      statement <- paste0(statement, " attribute_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " attribute_definition_id = '", attribute_definition_id,"'")
    }
  }
  
  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_number)) {
      statement <- paste0(statement, " value_as_number IS NULL")
    } else {
      statement <- paste0(statement, " value_as_number = '", value_as_number,"'")
    }
  }
  
  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(value_as_concept_id)) {
      statement <- paste0(statement, " value_as_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " value_as_concept_id = '", value_as_concept_id,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

expect_no_attribute_definition <- function(attribute_definition_id, attribute_name, attribute_description, attribute_type_concept_id, attribute_syntax) {
  statement <- paste0("INSERT INTO test_results SELECT ", get("testId", envir = globalenv()), " AS id, '", get("testDescription", envir = globalenv()), "' AS description, 'Expect attribute_definition' AS test, CASE WHEN(SELECT COUNT(*) FROM attribute_definition WHERE")
  first <- TRUE
  if (!missing(attribute_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_definition_id)) {
      statement <- paste0(statement, " attribute_definition_id IS NULL")
    } else {
      statement <- paste0(statement, " attribute_definition_id = '", attribute_definition_id,"'")
    }
  }
  
  if (!missing(attribute_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_name)) {
      statement <- paste0(statement, " attribute_name IS NULL")
    } else {
      statement <- paste0(statement, " attribute_name = '", attribute_name,"'")
    }
  }
  
  if (!missing(attribute_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_description)) {
      statement <- paste0(statement, " attribute_description IS NULL")
    } else {
      statement <- paste0(statement, " attribute_description = '", attribute_description,"'")
    }
  }
  
  if (!missing(attribute_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_type_concept_id)) {
      statement <- paste0(statement, " attribute_type_concept_id IS NULL")
    } else {
      statement <- paste0(statement, " attribute_type_concept_id = '", attribute_type_concept_id,"'")
    }
  }
  
  if (!missing(attribute_syntax)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    if (is.null(attribute_syntax)) {
      statement <- paste0(statement, " attribute_syntax IS NULL")
    } else {
      statement <- paste0(statement, " attribute_syntax = '", attribute_syntax,"'")
    }
  }
  
  statement <- paste0(statement, ") != 0 THEN 'FAIL' ELSE 'PASS' END AS status;")
  assign("testSql", c(get("testSql", envir = globalenv()), statement), envir = globalenv())
  invisible(statement)
}

