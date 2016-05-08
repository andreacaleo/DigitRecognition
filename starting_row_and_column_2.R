starting_index = function(vec){
    thres = vec[length(vec)] / 10
    for (k in 1:19){
        if (vec[k] > thres)
            return(k)
    }
    return(0)
}

ending_index = function(vec){
    thres = vec[length(vec)] / 10
    for (k in seq(19,1,-1)){
        if (vec[k] > thres)
            return(k)
    }
    return(0)
}