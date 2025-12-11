import gc
import os
import pickle

from classes import Book, Library, Magazine


def load_data() -> list[Library|None, list[Book|None], list[Magazine|None]]:
    
    books = []
    magazines = []
    
    if os.path.getsize("library") > 0:
        with open("library", "rb") as f:
            data = pickle.load(f)
            
            library = data[0]
            books = data[1]
            magazines = data[2]           
                
        return [library, books, magazines]           
    
    return [None, [], []]

def save_data(library: Library, books: list[Book|None], magazines: list[Magazine|None]) -> None:
    
    with open("library", "wb") as f:
        pickle.dump([library, books, magazines], f)