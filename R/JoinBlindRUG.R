#' @rdname JoinBlindRUG
#' @title Join the Blind R Users Group email list
#' @aliases JoinBlindRUG
#' @description  The BlindRUG email list is a forum where we can discuss issues about using R as a blind person. List traffic is light. You can join and leave as you see fit.

#' @details You will get an email prepared in your selected email client. Just press send without editing that message at all. Pretty soon, the server will send you a message that you will need to reply to in order to finalise the subscription. Once you have joined the list you will be sent an initial welcome message.
#' @author A. Jonathan R. Godfrey
#' @export JoinBlindRUG


JoinBlindRUG= function(){
if(interactive()){
create.post(address = "BlindRUG-request@nfbnet.org", subject = "subscribe", instructions="end", info="Just send this message without altering it in any way; wait for an automated reply from the mail server. Just press reply to that message and send it back. You will be joined to BlindRUG very soon afterwards.\n")
} else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}
