import re

text = clipboard.get_selection()
text = " ".join(text.split())  # remove extra spaces and new lines

pattern = r'\b\d{1,2}:\d{2}\b'  # "4:54", "12:34", etc.
text = re.sub(pattern, '', text).strip()
keyboard.send_keys(text+'\n')
