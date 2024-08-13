<p align="center">
  <img src="assets/hummit_logo_b.png" width="200px">
</p>

<h1 align="center" style="color: blue;">
  Humm'it
</h1>

<p align="center">
  Transform your vocal melodies into lyrics with the support of Google AI Gemini models
</p>

<br>

Welcome to **Humm'it**, a Flutter application powered by Google Gemini that bridges the gap between your creative melodies and captivating lyrics. Whether you are an aspiring musician, an established songwriter, or someone who enjoys humming catchy tunes, Humm'it is designed to transform your musical ideas into professional lyrics. By simply humming a melody into your phone, Humm'it leverages advanced AI technology to process your tune and craft meaningful lyrics that align with the rhythm and style of your music.

## Features

-   **🎤 Hum & Record:** Capture your spontaneous melodies anytime, anywhere. Just hit record, and let the magic begin!
-   **🧠 AI-Powered Lyrics:** Using Google Gemini's cutting-edge AI models, Humm'it generates lyrics that fit your music perfectly, respecting the syllabic structure and vocal nuances of your recording.
-   **🎨 Style Customization:** Tailor your lyrics to suit your genre and style. Whether you're into pop, rock, or indie, Humm'it adapts to your preferences.

## Getting Started with Google Gemini

To use Humm'it, you need to integrate Google Gemini's API by obtaining an API key. Follow these steps to get started:

1. **Create a Google Cloud Account:** If you don't already have one, sign up for a [Google Cloud account](https://cloud.google.com/).
2. **Enable the Gemini API:** Navigate to the Google Cloud Console, enable the Gemini API, and set up billing if required.
3. **Generate an API Key:** Create a new API key to access Gemini's AI capabilities.
4. **Insert the API Key into the Code:** Open the `main.dart` file in your project and replace the placeholder with your API key:

    ```dart
    String _apiKey = "YOUR_API_KEY"; // Insert your API key here
    ```
