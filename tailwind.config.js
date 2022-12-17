module.exports = {
  purge: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.vue",
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors:{
        'major': "#fb8500",
        'minor': "#ffb703", 
        'darkBlue': '#14213d',
        'hoverGray': '#f8f9fa',
      },
      screens:{
        lg: '1140px'
      },
      gridTemplateColumns: {
        '1-2': '1fr 2fr'

      },
      maxWidth: {
        '1140': '1140px'
      },
    },
  },
  variants: {
    extend: {
    },
  },
  plugins: [],
}
