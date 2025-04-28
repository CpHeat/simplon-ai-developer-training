def check_user_choice(choice: str, available_choices: str|int, forbidden_choices: list=None) -> bool:
    
    if choice == "":
            return False
    elif isinstance(available_choices, str):
        if choice.isnumeric() and len(choice) == 1 and choice in available_choices:
            return True
        else:
            print("\nVeuillez entrer un choix valide\n")
            return False
    elif isinstance(available_choices, int):
        if choice.isnumeric() and int(choice) >= 0 and int(choice) <= available_choices:
            if int(choice) in forbidden_choices:
                print("Document indisponible, veuillez en sélectionner un autre")
                return False
            else:
                return True
        else:
            print("\nVeuillez entrer un choix valide\n")
            return False
    else:
        print("\nVeuillez entrer un choix valide\n")
        return False