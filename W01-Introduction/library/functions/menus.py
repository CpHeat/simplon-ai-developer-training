from classes import Book, Library, Magazine
from functions.document import books_menu, borrow_document, magazines_menu
from functions.input_checks import check_user_choice
from functions.library import create_library, library_menu

def menu(library: Library|None, books: list[Book|None], magazines: list[Magazine|None]) -> Library:
    
    final_choice = False
    
    while not final_choice:
        choice_results = home_menu(library, books, magazines)
        library = choice_results[0]
        final_choice = choice_results[1]
    
    return library

def home_menu(library: Library|None, books: list[Book|None], magazines: list[Magazine|None]) -> list[Library, bool]:

    user_choice = ""

    while not check_user_choice(user_choice, "012345"):
        user_choice = input(f"""Que souhaitez-vous faire ?
0 - Terminer la gestion
1 - {"Afficher la bibliothèque" if library else "Créer une bibliotèque"}
2 - Gérer les livres
3 - Gérer les magazines
4 - Gérer la bibliothèque
5 - Gérer les emprunts
""")
    
    final_choice = False
    
    match int(user_choice):
        case 0:
            final_choice = True
        case 1:
            if library:
                library.display()
            else:
                library = create_library()
        case 2:
            books_menu(books)
        case 3:
            magazines_menu(magazines)
        case 4:
            library_menu(library, books, magazines)
        case 5:
            borrow_menu(books, magazines)
            
    return [library, final_choice]

def borrow_menu(books, magazines):
    
    user_choice = ""
    
    while not check_user_choice(user_choice, "012"):
        user_choice = input("""Que souhaitez-vous emprunter ?
0 - Retour
1 - Un livre
2 - Un magazine
""")
        
    match int(user_choice):
        case 0:
            pass
        case 1:
            borrow_document(books, "livre")
        case 2:
            borrow_document(magazines, "magazine")