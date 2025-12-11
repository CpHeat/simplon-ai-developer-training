from abc import ABC


class Document(ABC):
    
    def __init__(self, id: int, title: str, author: str, available: bool):
        self.id = id
        self.title = title
        self.author = author
        self.available = available
        
    def display_infos(self):
        print("id:", self.id)
        print("Title :", self.title)
        print("Author :", self.author)
        print("Available :", self.available)
        
class Book(Document):
    
    def __init__(self, id:int, title: str, author: str, available: bool, pages: int):
        super.__init__(id, title, author, available)
        self.pages = pages
    
    def display_infos(self):        
        print("type : Book")
        print("id:", self.id)
        print("Title :", self.title)
        print("Author :", self.author)
        print("Available :", self.available)
        print(f"Pages : {self.pages}\n")
    
class Magazine(Document):
    
    def __init__(self, id: int, title: str, author: str, available: bool, issue_number: int):
        super.__init__(id, title, author, available)
        self.issue_number = issue_number
        
    def display_infos(self):
        print("type : Magazine")
        print("id:", self.id)
        print("Title :", self.title)
        print("Author :", self.author)
        print("Available :", self.available)
        print(f"Issue number : {self.issue_number}\n")

class Library:
    
    def __init__(self, name: str, documents: list[Document]):
        self.name = name
        self.documents = documents        
    
    def add(self, document: Document):
        # Pour ajouter un document
        self.documents.append(document)
    
    def display(self):
        # Pour afficher tous les documents avec leurs infos
        print(f"Liste des documents de la bibliothèque {self.name} :\n")
        for document in self.documents:
            document.display_infos()
    
    def find_by_id(self, id: int):
        #pour retrouver un document par son identifiant
        for document in self.documents:
            if document.id == id:
                print("Document trouvé :")
                document.display_infos()
    
    def borrow(self, document: Document):
        #pour emprunter un document
        if document.available:
            document.available = False
            print("Document emprunté !")
        else:
            print("Document indisponible !")
    
    def give_back(self, document: Document):
        #pour rendre un document
        document.available = True
        print("Document rendu !")