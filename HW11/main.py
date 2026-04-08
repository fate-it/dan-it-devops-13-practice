class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang
        self.letters = letters

    def print(self):
        print("Літери алфавіту:", self.letters)

    def letters_num(self):
        return len(self.letters)


class EngAlphabet(Alphabet):
    _letters_num = 26

    def __init__(self):
        letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        super().__init__("En", letters)

    def s_en_letter(self, letter):
        return letter.upper() in self.letters

    def letters_num(self):
        return EngAlphabet._letters_num

    @staticmethod
    def example():
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."



eng = EngAlphabet()

eng.print()
print("Кількість літер:", eng.letters_num())
print("Чи є 'F' в англійському алфавіті:", eng.s_en_letter('F'))
print("Чи є 'Щ' в англійському алфавіті:", eng.s_en_letter('Щ'))
print("Приклад тексту:", EngAlphabet.example())