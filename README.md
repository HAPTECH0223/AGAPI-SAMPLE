<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Interactive Spline + AI</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      line-height: 1.6;
      background-color: #f9f9f9;
      color: #333;
    }
    h1 {
      color: #333;
    }
    a {
      color: #0366d6;
      text-decoration: none;
    }
    pre {
      background: #efefef;
      padding: 10px;
      border-radius: 4px;
      overflow-x: auto;
    }
  </style>
</head>
<body>
  <h1>Interactive Spline + AI</h1>
  <p>Hello, I'm [Your Name]. This repository contains the source code for a mobile-friendly web app I built as a take-home task for Agapi. The app allows users to input a statement and then generates a follow-up question using AI.</p>
  
  <p>The key features of the app include:</p>
  <ul>
    <li>A clean, minimal UI built with Flutter for a smooth cross-platform mobile experience.</li>
    <li>An interactive 3D background rendered via Spline Viewer (see <code>spline_interactive.html</code>), which adds a dynamic visual element.</li>
    <li>AI-powered follow-up question generation using the OpenAI GPT-4 API (configured in <code>follow_up_spline_page.dart</code>).</li>
    <li>Custom typography using Google Fonts (Share Tech Mono) for a modern, tech-inspired look.</li>
  </ul>
  
  <p>Here's a brief overview of the technologies and design choices I used:</p>
  <ul>
    <li><strong>Flutter:</strong> Chosen for its efficient cross-platform development, ensuring that the app works seamlessly on both Android and iOS devices.</li>
    <li><strong>Spline Viewer:</strong> Integrated via a local HTML file (<code>spline_interactive.html</code>) to display an immersive 3D scene as the app's background.</li>
    <li><strong>OpenAI GPT-4 API:</strong> Utilized to process the user's input statement and generate an engaging follow-up question.</li>
    <li><strong>Google Fonts:</strong> The Share Tech Mono font adds a distinctive aesthetic to the UI.</li>
  </ul>
  
  <p>To get started with the project locally, follow these steps:</p>
  <ol>
    <li><strong>Clone the repository:</strong>
      <pre>git clone &lt;repository_url&gt;
cd &lt;repository_directory&gt;</pre>
    </li>
    <li><strong>Install dependencies:</strong>
      <pre>flutter pub get</pre>
    </li>
    <li><strong>Setup assets:</strong> Make sure the <code>spline_interactive.html</code> file is in the <code>assets</code> folder and referenced in your <code>pubspec.yaml</code> file.</li>
    <li><strong>Configure the API key:</strong> Replace the placeholder OpenAI API key in <code>follow_up_spline_page.dart</code> with your actual key.</li>
    <li><strong>Run the app:</strong>
      <pre>flutter run</pre>
    </li>
  </ol>
  
  <p>You can also check out a demo video of the app in action here:</p>
  <p><a href="https://drive.google.com/drive/folders/15Mp_CiWGuIJEcmgP-wZc394fTBjb9jw-?usp=sharing" target="_blank">Demo Video</a></p>
  
  <p>Thanks for taking a look at my project. Feel free to explore the code and share any feedback you might have!</p>
</body>
</html>
