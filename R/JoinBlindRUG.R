
ThankYou =
    function() {
      if (interactive()) {
        create.post(
            address = "a.j.godfrey@massey.ac.nz",
            subject = "Thank you for BrailleR",
            instructions = "Hello Jonathan,\n\n",
            info = "Please let me know a little about yourself, where you are working or studying, and how you learned about BrailleR.\n")
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

JoinBlindRUG =
    function() {
      if (interactive()) {
        create.post(
            address = "BlindRUG-request@nfbnet.org", subject = "subscribe",
            instructions = "end",
            info = "Just send this message without altering it in any way; wait for an automated reply from the mail server. Just press reply to that message and send it back. You will be joined to BlindRUG very soon afterwards.\n")
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }
