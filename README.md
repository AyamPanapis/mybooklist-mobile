# MyBookList

## Members

1. Revaldy Hafizhy Mukhtar
2. Ardhika Satria Narendra
3. Rakha Fahim Shahab
4. Hezekial Octora Yudha Tampubulon
5. Muhammad Obin Mandalika

## Story and Benefits
Inspired by "MyAnimeList.com" our application will use similiar listing system, but instead of anime titles, it will be replaced by books but in application form. this can easily help book readers manage their reading journey and keep track of the books they have read, are currently reading, and plan to read in the future. Users will be able to create personalized book lists, rate and review books, and connect with other book enthusiasts. They can also discover new books based on recommendations from the community and explore various genres and authors. Our website will provide a user-friendly interface with a comprehensive search feature, making it convenient for book readers to find specific titles or explore books based on their interests. Whether you are a casual reader or a passionate bookworm, our website will be the ultimate platform to enhance your reading experience.
## Features

- <strong>Book-To-Read-List</strong></br>
    Users can manage their book list neatly. The list will include 'Plan to Read' section, 'Reading' section, and 'Completed' section.

- <strong>Book Review</strong></br>
    Users can leave reviews on certain books, and will be showed publicly.

- <strong>Book Library</strong></br>
    Books that will be fetched from Midterm Project Website.

## List Of Modules & Workload distributions

- Main Page - Muhammad Obin Mandalika
- Book Page (Display Book) - Ardhika Satria 
- Profile Page - Revaldy Hafizhy Mukhtar
- Review Page and Authentication - Hezekial
- Category Page - Rakha Fahim Shahab

## User Roles
User can search up books that are available in the app database. User can also look up book general information such as author, publisher, and genre. User can also add books to their reading list, and leave reviews on books they have read. User can also see their and other user's reviews on books. User can also acess their profile to see the reading list.

## Flutter Integration flow with Django
To integrate the flutter application to our django app, we need to install some dependencies to fetch the data from our web application (for example : pbp_django_auth). We also need to create an API endpoint on django to fetch the JSON data. The API endpoint is needed to send the necessary data between flutter and django. 

[Progress Report](https://docs.google.com/spreadsheets/d/1ecUdBUnTy8FjqNU9iX15yIpQ5jW67C-kj5WiVRn5cic/edit?usp=sharing)



<details>
<summary>Development Environment</summary>

```
git clone git@github.com:AyamPanapis/mybooklist-mobile.git
cd mybooklist-mobile
```

```
# To run app
flutter run
```
</details>