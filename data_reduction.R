setwd("C:/Users/Pigkappa/Dropbox/Data_Science/Digit_Recognition")

source("data_munging.R")

pixel_names = character(19*19)
for (k in 1:(19*19)){
    pixel_names[k] = paste0(c("pixel", as.character(k)), collapse = "")
}

nmax = 70000
reduced_data = data.frame(matrix(nrow = nmax, ncol = 19*19))

stime = system.time({
    for(obs in 1:nmax){
        pixelMatrix = matrix(as.numeric(full[obs,2:785, with = F]), nrow = 28, ncol=28, byrow = T)
        rowStart = full[obs,rowStart]
        rowEnd = full[obs,rowEnd]
        colStart = full[obs,colStart]
        colEnd = full[obs,colEnd]
        
        pixelMatrixReduced = matrix(0, nrow = 19, ncol = 19, byrow = T)
        for (r in seq(rowStart, min(rowStart+18, rowEnd))){
            for (k in seq(colStart, min(colStart+18, colEnd))){
                pixelMatrixReduced[1+r-rowStart,1+k-colStart] = pixelMatrix[r,k]
            }       
        }
        reduced_data[obs,] = as.vector(t(pixelMatrixReduced))
    }
})


reduced_data = cbind(full[1:nmax,label], reduced_data)

names(reduced_data) = c("label",pixel_names)

write.table(reduced_data, "reduced.data.csv", sep = ",", row.names = F)
