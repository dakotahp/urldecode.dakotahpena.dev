module.exports = {
  entry: './webpack/entry.js',
  output: {
    path: __dirname + '/javascripts/',
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules)/,
        loader: 'babel-loader',
        query: {
          presets: ['react', 'es2015']
        }
      }
    ]
  },
  mode: 'development'
};
