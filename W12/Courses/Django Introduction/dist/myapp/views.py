from django.http import HttpResponse
from django.shortcuts import render, redirect

from .forms import BookForm
from .models import Book


def index(request):
    latest_books = Book.objects.order_by('-published_date')[:5]
    context = {'latest_books': latest_books}
    return render(request, 'myapp/index.html', context)

def detail(request, book_id):
    return HttpResponse(f"détail du livre n°{book_id}")

def add_book(request):
    if request.method == 'POST':
        form = BookForm(request.POST)
        if form.is_valid():
            form.save() # Enregistre le livre dans la base
            return redirect('index') # Redirige vers la page d9accueil
        else:
            print(form.errors) # Affiche les erreurs dans le terminal
    else:
        form = BookForm() # Affiche un formulaire vide
        return render(request, 'myapp/add_book.html', {'form': form})
