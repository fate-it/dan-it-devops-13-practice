import random


def game():
    number = random.randint(1, 100)  
    attempts = 5
    while(attempts !=0 ):
        try:
            user_input = int(input("Вгадайте число від 1 до 100: "))
        except ValueError:
            print("Ви ввели не число! Спробуйте ще раз.")
            continue
    
        if user_input == number:
            print("Вітаємо! Ви вгадали правильне число")
            exit()
        elif user_input > number:
            print("Занадто високо")
        else:
            print("Занадто низько")
        attempts -= 1
        print(f"Залишилось спроб: {attempts}")
    print(f"Вибачте, у вас закінчилися спроби. Правильний номер був {number}")

game()
