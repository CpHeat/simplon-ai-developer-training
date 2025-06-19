

def print_word(word: str, found_letters: list, tries):
    
    show_word = []
    word_found = False
    
    for letter in word:
        if letter in found_letters:
            show_word.append(letter)
        else:
            show_word.append(" ")
    
    if " " not in show_word:
        word_found = True
        print(f"Bravo ! le mot était {word}")
    else:
        print(f"{show_word}, essais restants : {tries}")
    
    return word_found

word = input("Choisissez le mot à trouver : ")
tries = 3
found_letters = []
tried_letters = []

while not print_word(word, found_letters, tries):
    guess = input("Choisissez une lettre : ")

    if guess in tried_letters:
        print("Déjà essayé, tente une autre lettre")
        continue
    if guess in word:
        found_letters.append(guess)
    else:
        tries -= 1
    
    tried_letters.append(guess)
    
    if tries == 0:
        print(f"Perdu ! Le mot à trouver était {word}")
        break