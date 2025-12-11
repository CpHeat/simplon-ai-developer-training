from utils import add_numbers, square
from data_loader import load_config, load_data

def main():
    data = load_data()
    result = add_numbers(2, 3)
    print("== Début du programme ==")
    print(f"Result: {result}")
    print(f"Data loaded: {data}")
    print(f"Nombre d'eléments chargés: {len(data['data'])}")
    print(f"Resultat au carré : {square(result)}")
    print(f"La config est {load_config()}")
    print("== Fin du programme ==")
    
if __name__ == "__main__":
    main()