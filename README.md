# 📱 DemoAlamofire – Pokémon List (MVVM)

This project demonstrates a simple iOS app that fetches and displays a list of Pokémon using the [PokeAPI](https://pokeapi.co/) and follows the **MVVM (Model-View-ViewModel)** design pattern.

---

## 🚀 Features

- Built with **Swift** and **UIKit**
- Clean MVVM architecture
- Uses **Alamofire** for networking
- Displays data using `UITableView`
- Handles loading states and error alerts
- Organized code structure for readability and scalability

---

## 💡 How It Works

- `HomeVC`: Displays the Pokémon list in a `UITableView`.
- `PokemonListViewModel`: Fetches data from the API and exposes it via closures.
- `PokemonService`: Makes network calls using **Alamofire**.
- `PokemonListTVC`: Custom table view cell to show Pokémon names.

---

## ⚙️ Dependencies

- [Alamofire](https://github.com/Alamofire/Alamofire) – for HTTP networking

---

## 🛠️ Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/DemoAlamofire.git
   ```

2. Open the project in Xcode.

3. Run `pod install` if using CocoaPods, or make sure **Alamofire** is integrated via Swift Package Manager.

4. Build and run on a simulator or device.

---

## 📚 Credits

- Data powered by [PokeAPI](https://pokeapi.co/)
- Built as a learning project to demonstrate MVVM with networking

---

## 🙌 Contributions

Feel free to fork and improve! PRs are welcome for features like:
- Search functionality
- Caching
- Pagination
- UI improvements
