text = clipboard.get_selection()
if text[-1] in ['.', ',', '\n']:
    text = text[:-1] + ':\n'
else:
    text = text + ':\n'
keyboard.send_keys(text)
