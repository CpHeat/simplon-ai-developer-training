from functions.data import load_data, save_data
from functions.menus import menu


if __name__ == "__main__":
    
    loaded_data = load_data()
    library = loaded_data[0]
    books = loaded_data[1]
    magazines = loaded_data[2]
    
    library = menu(library, books, magazines)
    
    save_data(library, books, magazines)