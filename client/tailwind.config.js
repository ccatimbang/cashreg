/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#228be6',
          hover: '#1c7ed6',
        },
        background: '#f8f9fa',
        card: '#ffffff',
        text: {
          primary: '#1a1b1e',
          secondary: '#868e96',
        },
        border: '#e9ecef',
        success: '#40c057',
        error: '#fa5252',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
} 