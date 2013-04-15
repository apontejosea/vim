ObjectSizes <- function() {
    return(rev(sort(sapply(ls(envir=.GlobalEnv), function (object.name)
        object.size(get(object.name))))))
}
