setwd("C:/Users/Pigkappa/Dropbox/Data_Science/Digit_Recognition")
full = read.csv("final_data.csv", stringsAsFactors = F)

library(xgboost); set.seed(1)

ntrain = 42000
full_sample = full[c(1:ntrain),]

features = as.matrix(full_sample[,-1])
target = as.matrix(full_sample[,1])

ptime = system.time({
    model_xgb_cv <- xgb.cv(data=as.matrix(features), label=as.matrix(target), 
                    objective="multi:softprob", num_class=10, 
                    nfold=4, 
                    nrounds=1500, eta=0.05, max_depth=6, subsample=0.9, 
                    colsample_bytree=0.5, min_child_weight=1, 
                    print.every.n = 30,
                    eval_metric='merror')
}) 
    

model_xgb = xgboost(data=as.matrix(features), label=as.matrix(target), 
                   objective="multi:softprob", num_class=10, 
                   nrounds=1500, eta=0.05, max_depth=6, subsample=0.9, 
                   colsample_bytree=0.5, min_child_weight=1, 
                   print.every.n = 30,
                   eval_metric='merror')
    
test_sample = as.matrix(full[c(42001:70000),2:453])
prob_matrix = matrix(predict(model_xgb,newdata = test_sample), nrow = 28000, byrow = T)
preds = apply(prob_matrix, MARGIN = 1, FUN = which.max) - 1

pred.results = data.frame(ImageId = 1:28000, Label = preds)
write.csv(pred.results, file = "submission_xgb2.csv", row.names = F)
