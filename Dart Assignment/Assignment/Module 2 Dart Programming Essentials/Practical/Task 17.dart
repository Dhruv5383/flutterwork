// Create a class called Book with properties like title, author, and publication year. Add methods to display the book’s details and a method to check if it’s over 10 years old.

class Book {
  String title;
  String author;
  int publicationYear;

  Book(this.title, this.author, this.publicationYear);

  void displayDetails() {
    print('Title: $title');
    print('Author: $author');
    print('Publication Year: $publicationYear');
  }

  bool isOverTenYearsOld() {
    int currentYear = DateTime.now().year;
    return (currentYear - publicationYear) > 10;
  }
}

void main() {
  Book book = Book('1984', 'George Orwell', 1994);
  book.displayDetails();

  if (book.isOverTenYearsOld()) {
    print('This book is over 10 years old.');
  } else {
    print('This book is not over 10 years old.');
  }
}
