full_border = data.frame(matrix(nrow = 70000, ncol = 362))
full_border[,] = FALSE

for (c in 2:362){
    if (c %% 19 != 2){
        comparison = full[[c]] !=  full[[c-1]] 
        full_border[comparison,c] = TRUE
    }

    if (c %% 19 != 1){
        comparison = full[[c]] !=  full[[c+1]] 
        full_border[comparison,c] = TRUE
    }
    
    if (c > 20){
        comparison = full[[c]] !=  full[[c-19]] 
        full_border[comparison,c] = TRUE
    }
    
    if (c < 362-18){
        comparison = full[[c]] !=  full[[c+19]] 
        full_border[comparison,c] = TRUE
    }
}

full$Perimeter = apply(full_border, MARGIN = 1, FUN = sum)