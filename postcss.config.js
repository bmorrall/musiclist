let environment = {
  plugins: [
    require('tailwindcss')('tailwind.config.js'),
    require('autoprefixer'),
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}

// Only run PurgeCSS in production
if (process.env.RAILS_ENV === "production") {
  environment.plugins.push(
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/**/*.html.erb',
        './app/decorators/**/*.rb',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/javascript/**/*.vue',
        './app/javascript/**/*.jsx',
        './config/initializers/simple_form*.rb',
      ],
      defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
    })
  )
}

module.exports = environment
