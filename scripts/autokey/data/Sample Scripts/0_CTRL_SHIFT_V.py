import re

text = clipboard.get_selection()

# remove time patterns "4:54", "12:34", etc.
pattern = r'\b\d{1,2}:\d{2}\b'
text = re.sub(pattern, '', text).strip()
# remove extra spaces and new lines
text = " ".join(text.split())

keyboard.send_keys(text+'\n')
