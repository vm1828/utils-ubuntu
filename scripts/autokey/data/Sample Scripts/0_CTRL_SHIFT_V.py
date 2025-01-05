text = clipboard.get_selection()
text = " ".join(text.split())  # remove extra spaces and new lines
keyboard.send_keys(text)
