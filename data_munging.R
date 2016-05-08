setwd("C:/Users/Pigkappa/Dropbox/Data_Science/Digit_Recognition")
library(data.table)
train = fread("train.csv", stringsAsFactors = F, sep = ",")
test = fread("test.csv", stringsAsFactors = F, sep = ",")
test$label = NA
test <- test[,c(785,1:784), with = F]
full = rbind(train, test)

full = as.data.table(cbind(full[,1,with=F],apply(full[,2:785, with = F], 
                                                 MARGIN = 2, function(x) x/255)))
full = as.data.table(cbind(full[,1,with=F],apply(full[,2:785, with = F], 
                                                 MARGIN = 2, function(x) x > 0.2)))
row_names = character(28)
for (k in 1:28){
    row_names[k] = paste0(c("row", as.character(k)), collapse = "")
}

row_sum = as.data.frame(setNames(replicate(28, numeric(70000),simplify = F), row_names))
for (k in 1:28){
    row_sum[,k] = apply(full[,1+28*(k-1)+seq(1,28), with = F], FUN = sum, MARGIN = 1)
}

full = cbind(full, row_sum)

column_names = character(28)
for (k in 1:28){
    column_names[k] = paste0(c("column", as.character(k)), collapse = "")
}

column_sum = as.data.frame(setNames(replicate(28, numeric(70000),simplify = F), column_names))
for (k in 1:28){
    column_sum[,k] = apply(full[,1+seq(k,783,28), with = F], FUN = sum, MARGIN = 1)
}
    
full = cbind(full, column_sum)

full$rowMax = apply(full[,786:813, with = F], MARGIN = 1, max)

source("starting_row_and_column.R")
full$rowStart = apply(full[,786:814, with = F], MARGIN = 1, starting_index)
full$rowEnd = apply(full[,786:814, with = F], MARGIN = 1, ending_index)
full$rowWidth = full$rowEnd - full$rowStart


full$colMax = apply(full[,814:841, with = F], MARGIN = 1, max)
full$colStart = apply(full[,814:841, with = F], MARGIN = 1, starting_index)
full$colEnd = apply(full[,814:841, with = F], MARGIN = 1, ending_index)

full$colWidth = full$colEnd - full$colStart

full$Area = apply(full[,786:814, with = F], MARGIN = 1, sum)

table(full$rowWidth, full$colWidth)
# this table shows that every image has a has height and width between 1 and 19.
