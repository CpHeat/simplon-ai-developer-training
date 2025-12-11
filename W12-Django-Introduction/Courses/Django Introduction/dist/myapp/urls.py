from django.urls import path

from .import views

urlpatterns = [
    path("", views.index, name="index"),
    path('add/', views.add_book, name='add_book'),
    path("<int:book_id>/", views.detail, name="detail"),
]