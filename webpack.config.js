const path = require('path')

module.exports = {
  mode: 'development',
  entry: './src/index.js',
  devtool: 'inline-source-map',
  devServer: {
    static: './public'
  },
  output: {
    filename: 'main.bundle.js',
    path: path.resolve(__dirname, 'public'),
    clean: {
      keep: /index.html/
    }
  },
  module: {
    rules: [
      {
        test: /\.(css|sass|scss)$/,
        use: ['style-loader', 'css-loader', 'sass-loader']
      }
    ]
  }
}