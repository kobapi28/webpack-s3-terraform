const path = require('path')
// cssファイルとして読み込めるように
const MiniCssExtractPlugin = require("mini-css-extract-plugin")

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
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader']
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'main.css',
    })
  ]
}