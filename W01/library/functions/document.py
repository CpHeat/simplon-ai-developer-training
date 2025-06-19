from classes import Book, Document, Magazine
from functions.input_checks import check_user_choice


def books_menu(books: list[Book|None]):
    
    user_choice = ""
    
    while not check_user_choice(user_choice, "012"):
        user_choice = input("""Que souhaitez-vous faire ?
0 - Retour
1 - Afficher les livres
2 - Créer un livre
""")
        
    match int(user_choice):
        case 0:
            pass
        case 1:
            show_documents(books)
        case 2:
            books.append(create_document_menu("livre"))
            
    return books

def magazines_menu(magazines: list[Magazine|None]):
    
    user_choice = ""
    
    while not check_user_choice(user_choice, "012"):
        user_choice = input("""Que souhaitez-vous faire ?
0 - Retour
1 - Afficher les magazines
2 - Créer un magazine
""")
        
    match int(user_choice):
        case 0:
            pass
        case 1:
            show_documents(magazines)
        case 2:
            magazines.append(create_document_menu("magazine"))
            
    return magazines

def create_document_menu(document_type: str):
    
    document_id = input(f"Quel est l'identifiant du {document_type} ?")
    title = input(f"Quel est le titre du {document_type} ?")
    author = input(f"Quel est l'auteur du {document_type} ?")
    
    if document_type == "livre":
        pages = input("Combien de pages comporte le livre ?")
        return Book(document_id, title, author, True, pages)
    else:
        issue_number = input("Quel est le numéro du magazine ?")
        return Magazine(document_id, title, author, True, issue_number)
    
def show_documents(documents: list[Document|None]):
    
    for document in documents:
        document.display_infos()
        
def borrow_document(documents: list[Document|None], document_type: str):

    user_choice = ""
    forbidden_choices = []
    
    while not check_user_choice(user_choice, len(documents), forbidden_choices):
        
        print(f"""Choisissez un {document_type} à emprunter :
0 - Retour""")
        
        for i, document in enumerate(documents):
            if document.available:
                print(f"{i+1} - {document.title}")
            else:
                print(f"{i+1} - {document.title} (Indisponible)")
                forbidden_choices.append(i+1)
            
        user_choice = input()
        
        
        if int(user_choice) == 0:
            break
        
        documents[int(user_choice)-1].available = False
