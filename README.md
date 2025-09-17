# Weatherly ☀️🌧️

A modern Flutter weather app that shows real-time weather information with a clean and elegant UI.  
The design is **inspired by [this Dribbble concept](https://dribbble.com/shots/25320809-Weather-App-Design)**.  

---

## ✨ Features
- Current weather with temperature & condition.
- Hourly forecast in a horizontally scrollable view.
- Glassmorphism-inspired UI (blurred cards, rounded edges).
- Clean typography using a custom font for outlined text.
- Responsive for mobile.

---

## 📸 Screenshots

<div style="display: flex; overflow-x: auto;">
  <img src="https://github.com/user-attachments/assets/598e2057-b214-4c7c-b9df-ed8ca8228462" width="250" />
  <img src="https://github.com/user-attachments/assets/6d027c1f-d563-4983-8392-5f16f690ffc3" width="250" />

</div>


---

---

## ⚙️ Configure Your Weather API Key

To use this app, you need a Weather API key.  

1. Open the file:

```text
lib/services/weather_service.dart
```

2. Find the line:

```dart
final String apiKey = "-------YOUR_API_KEY------";
```

3. Replace the value with your own API key. For example:

```dart
final String apiKey = "YOUR_OWN_API_KEY_HERE";
```

You can get a free API key from a weather API provider such as [OpenWeatherMap](https://openweathermap.org/api).

---

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)  
- Weather API key (e.g., [OpenWeather](https://openweathermap.org/))

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/weatherly-app.git
   cd weatherly-app


Created by Ali Nofal (e.alinofal@gmail.com)
