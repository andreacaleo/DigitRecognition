setwd("C:/Users/Pigkappa/Dropbox/Data_Science/Digit_Recognition")
library(data.table)
full = fread("reduced.data.csv", stringsAsFactors = F)

row_names = character(19)
for (k in 1:19){
    row_names[k] = paste0(c("row", as.character(k)), collapse = "")
}

row_sum = as.data.frame(setNames(replicate(19, numeric(70000),simplify = F), row_names))
for (k in 1:19){
    row_sum[,k] = apply(full[,1+19*(k-1)+seq(1,19), with = F], FUN = sum, MARGIN = 1)
}

full = cbind(full, row_sum)

column_names = character(19)
for (k in 1:19){
    column_names[k] = paste0(c("column", as.character(k)), collapse = "")
}

column_sum = as.data.frame(setNames(replicate(19, numeric(70000),simplify = F), column_names))
for (k in 1:19){
    column_sum[,k] = apply(full[,1+seq(k,360,19), with = F], FUN = sum, MARGIN = 1)
}

full = cbind(full, column_sum)

full$rowMax = apply(full[,363:381, with = F], MARGIN = 1, max)

source("starting_row_and_column_2.R")
full$rowStart = apply(full[,363:381, with = F], MARGIN = 1, starting_index)
full$rowEnd = apply(full[,363:381, with = F], MARGIN = 1, ending_index)
full$rowWidth = full$rowEnd - full$rowStart


full$colMax = apply(full[,382:400, with = F], MARGIN = 1, max)
full$colStart = apply(full[,382:400, with = F], MARGIN = 1, starting_index)
full$colEnd = apply(full[,382:400, with = F], MARGIN = 1, ending_index)

full$colWidth = full$colEnd - full$colStart

full$Area = apply(full[,382:400, with = F], MARGIN = 1, sum)

source("border_comparison.R")   #creates full$Perimeter

#the following feature may not be useful but sounds interesting to me
full$AreaoverPerim = full$Area / full$Perimeter 

source("row_column_changes.R") #creates additional features

write.table(full, "final_data.csv", sep = ",", row.names = F)
