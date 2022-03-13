const path = require('path')
// cssファイルとして読み込めるように
const MiniCssExtractPlugin = require("mini-css-extract-plugin")
// HTMLファイルのビルド
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  mode: 'development',
  entry: './src/js/index.js',
  devtool: 'inline-source-map',
  devServer: {
    static: './public'
  },
  output: {
    filename: 'main.bundle.js',
    path: path.resolve(__dirname, 'public'),
    clean: true
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
    }),
    new HtmlWebpackPlugin({
      template: `${__dirname}/src/index.html`,
      filename: `${__dirname}/public/index.html`,
      inject: 'body'
    })
  ]
}