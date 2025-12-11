from classes import Book, Document, Library, Magazine
from functions.input_checks import check_user_choice


def library_menu(library, books: list[Book|None], magazines: list[Magazine|None]):
    
    user_choice = ""
    
    while not check_user_choice(user_choice, "012"):
        user_choice = input("""Que souhaitez-vous faire ?
0 - Retour
1 - Ajouter un livre
2 - Ajouter un magazine
""")        
        
    match int(user_choice):
        case 0:
            pass
        case 1:
            add_document(library, books, "livre")
        case 2:
            add_document(library, magazines, "magazine")
            
def add_document(library: Library, documents: Document, document_type: str):
    user_choice = ""
    
    while not check_user_choice(user_choice, len(documents)):
        
        print(f"""Choisissez un {document_type} à ajouter :
0 - Retour""")
        
        for i, document in enumerate(documents):
            if document not in library.documents:
                print(f"{i+1} - {document.title}")
            
        user_choice = input()
        
        if int(user_choice) == 0:
            break
        else:        
            library.add(documents[int(user_choice)-1])

def create_library() -> Library:
    
    library_name = input("Choisissez un nom pour la bibliothèque :")
    
    return Library(library_name, [])