const path = require ('path');

module.exports = {
    mode: 'none',
    entry: './static/index.js',
    output: {
        path: path.join(__dirname, '/docs'),
        filename: 'app.js'
    },
    module: {
        rules: [
            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader: 'file-loader?name=[name].[ext]'
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'elm-webpack-loader?verbose=true&warn=true'
            }
 
        ],
        noParse: /\.elm$/
    }
}
