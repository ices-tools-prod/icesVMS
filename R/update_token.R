#' Update user token for project
#' 
#' Must be run in interactive mode.  User is promted for a password, and if successful
#' a Javascript Web Token (JWT) is saved to the project root (current working directory).
#' The token will last for 1 hour, after which the user needs to update the token using 
#' this function again.
#' @param user a character string giving the users ICES username
#' @return TRUE or FALSE depenting on the success of the operation
#' @export
update_token <- function(user) {  
  uri <- "https://taf.ices.dk/vms/api/"

  res <-
    httr::POST(paste0(uri, "token"), 
               body = list(UserName = user, password = askpass::askpass(paste("Enter password for user,", user))),
               encode = "json")

  if (httr::status_code(res) == 200) {
    jwt <- httr::content(res)
    cat("\n# JWT token for access to ICES vms web services\n.ices-jwt\n", file = ".gitignore", append = file.exists(".gitignore"))
    cat(jwt$token, "\n", file = ".ices-jwt", sep = "")
    return(TRUE)
  } else {
    return(FALSE)
  }
}
