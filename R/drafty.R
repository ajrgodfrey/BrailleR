#' drafty
#' @title Interactively choose, knit, and show R Markdown Drafts.

#' @aliases drafty
#' @keywords drafty

#' @description This function provides non-RStudio users with alternative methods to interactively choose Rmd templates based upon already-existing packages on system, help users edit their Rmd drafts in a preferable text editor, quickly knit it and show the results simultaneously.

#' @export drafty

#' @details
#' You can use this function to conveniently draft your R Markdown documents based on other templates provided by the available packages installed on your system.

#' @return NULL

#' @examples
#' if(interactive()) {
#' # Use BrailleR::drafty(), then follow the instructions.
#' }

#' @author JooYoung Seo, \email{jooyoung@psu.edu}

drafty <- function() {
    if (interactive()) {
        # Making tidy object out of rmarkdown:::list_template_dirs:
        df <- tidyr::separate(tibble::tibble(utils::capture.output(rmarkdown:::list_template_dirs())), 
            1, c("package", "template"), sep = "[|]")
        
        # Pulling out package column:
        pkg <- tibble::rowid_to_column(dplyr::distinct(dplyr::select(df, package)), 
            "id")
        num_pkg <- nrow(pkg)
        if (num_pkg == 0) {
            stop("No package found for Rmd templates.")
        }
        pkg_message <- if (num_pkg > 1) {
            paste0(" packages have ")
        } else {
            paste0(" package has ")
        }
        user_input_pkg <- ""
        
        while (TRUE) {
            message(paste0(num_pkg, pkg_message, "been found for Rmd templates. Enter the package number to use: "))
            
            for (i in 1:num_pkg) {
                message(paste0(pkg[i, 1], ". ", pkg[i, 2]))
            }
            message("99. Quit.")
            
            user_input_pkg <- readLines(n = 1)
            
            if (user_input_pkg == "") {
                next
            } else if (!(user_input_pkg %in% 1:num_pkg)) {
                return(invisible())
            } else {
                while (TRUE) {
                  pkg_select <- as.character(pkg[user_input_pkg, "package"])
                  
                  templ <- tibble::rowid_to_column(dplyr::filter(df, package == pkg_select), 
                    "id")
                  num_templ <- nrow(templ)
                  if (num_templ == 0) {
                    stop("No template found.")
                  }
                  templ_message <- if (num_templ > 1) {
                    paste0(" templates have ")
                  } else {
                    paste0(" template has ")
                  }
                  
                  message(paste0(num_templ, templ_message, " been found under ", 
                    pkg_select, ". Enter the template number to use: "))
                  
                  for (i in 1:num_templ) {
                    message(paste0(templ[i, 1], ". ", base::basename(as.character(templ[i, 
                      3]))))
                  }
                  message("99. Quit.")
                  message("Press \"B\" to go back to the previous menu.")
                  
                  
                  user_input_templ <- readLines(n = 1)
                  
                  if (base::tolower(user_input_templ) == "b") {
                    break
                  } else if (!(user_input_templ %in% 1:num_templ)) {
                    return(invisible())
                  } else {
                    templ_select <- base::basename(as.character(templ[user_input_templ, 
                      "template"]))
                    
                    message("Enter the draft file name to use: ")
                    user_template <- readLines(n = 1)
                    
                    editor <- getOption("editor")
                    editor_option <- yesno::yesno2(paste0("Your default text editor is set to: ", 
                      editor, ". Do you want to keep using it? "))
                    
                    if (!editor_option) {
                      message("Choose your preferable text editor: ")
                      editor_path <- enc2native(file.choose())
                      options(editor = editor_path)
                    }
                    
                    file <- rmarkdown::draft(user_template, templ_select, pkg_select, 
                      create_dir = TRUE, edit = TRUE)
                    
                    while (TRUE) {
                      render_option <- yesno::yesno2("Do you want to render the Rmd file?", 
                        no = "Go back to the previous menu.")
                      
                      if (render_option) {
                        setwd(base::dirname(file))
                        lapply(rmarkdown::render(input = base::basename(file), output_format = "all"), 
                          utils::browseURL)
                        setwd("..")
                      } else if (render_option == FALSE) {
                        break
                      } else {
                        return(invisible())
                      }
                    }
                  }
                }  # while ends.
                # end
            }
        }
        
        
    } else {
        warning("This function is meant for use in interactive mode only.\n")
    }
    return(invisible(NULL))
}
