def check_is_spam(email_title:str) -> None:
    """
    Checks if a mail title is spam or not.

    :param email_title: The mail title to check.
    """

    banned_words = ["free", "surprise", "prize", "gift", "request"]

    for banned_word in banned_words:
        if banned_word in email_title.lower():
            print(f"{email_title} is a SPAM")
            return
    print(f"{email_title} may not be a spam")

if __name__ == '__main__':
    email_titles:list = ["win a free Iphone now",
                   "meeting a scheduled to Monday",
                   "Your invoice is attached",
                   "Click here for a surprise",
                   "Last chance a claim your prize",
                   "Lunch tomorrow?",
                   "You are selected! free gift awaits",
                   "Quarterly performance review attached",
                   "Let's catch up",
                   "Re; your request"]

    for email_title in email_titles:
        check_is_spam(email_title)